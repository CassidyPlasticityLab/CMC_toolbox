% data_process.m reads in .mff files collected via EGI netstation and
% applies several user-specified preprocessing steps including filtering,
% rereferencing, and channel selection

% It preprocesses the data, isolates the data signals, and concatenates the
% EEG and EMG

% TO RUN, follow the prompt and load the .set file corresponding to the file of interest
%         after prompted next load the raw .mff file corresponding to the
%         file of interest. The raw .mff file must be in the current
%         directory


%OUTPUT:
% fd: A struct containing all relevant coherence info created by matlab
% data: A struct containing all relevant information. Can be utilized with
% fieldtrip functions

% Load the preprocessed EEG into Matlab
EEG = pop_loadset;

% Load the raw dataset into Matlab
cfg = [];
[FileName] = uigetfile('.mff');
cfg.dataset = FileName;
data = ft_preprocessing(cfg); % save raw file in the workspace

%%
%Define lesion side
lesion_side = input('input the string of the side the lesion occured on (l/r) \n' );
%Subject ID
SUBJ_ID = input('input the string of the subject ID (i.e. "<SUBJID>_<Visit#>_<SA/LA>_hand" \n' );

% Segment EMG data into 1 second segments
cfg.length = 1;
data_segmented = ft_redefinetrial(cfg, data); % EMG data ONLY

% View Events and remove segmentation events
[event] = EEG.event;%view events from raw file from netstation
%D127 is onset
%D255 is offset
% Remove unnecessary event labels
segmented_event_index = 1  ;
while segmented_event_index <= length(event)
    if strcmp(event(segmented_event_index).type,'X')
        event(segmented_event_index) = [];
        segmented_event_index = segmented_event_index-1;
    end
    segmented_event_index = segmented_event_index+1;
end


%Isolate channel labels
label = data.label;

% Filter the EMG signals
cfg.bpfreq = [10:50, 70:100]; %Freq bands of interest are 10:50 Hz and 70:100 Hz
cfg.channel = data.label(258:end); %{'Extensor', 'Flexor', 'Policis', 'Biceps'}; %EMG electrode labels
cfg.rectify = 'no'; %Opting to not rectify the EMG
EMG_unrectify = ft_preprocessing(cfg, data_segmented); %save the processed EMG in the worksapce

%%
% Extract Filtered EMG channels from the Raw .mff file
Number_of_Epochs = 1:(length(data_segmented.trial)-1);
EMG_Final = [EMG_unrectify.trial{1, 1}, EMG_unrectify.trial{1, (Number_of_Epochs)}]; %extracts EMG signal array

%%
%Perform Hilbert Transformation
EMG_Final = hilbert(EMG_Final);
EMG_Final = abs(EMG_Final);
framelen = 3;
EMG_Final = sgolayfilt(EMG_Final, 1, framelen); %framelen = 1 period of oscillation.  e.g., for 10-50 HZ, the middle is 3- Hz, so I might say 33 ms is my period

%%
% Convert EEG data to double structure and reshape
EEG_double = double(EEG.data);
EEG_reshape = reshape(EEG.data,194,[]);


% Add back deleted channels and extract the EEG array from eeglab. Unsegment the data
EEG_Final = cmc_add_chans(EEG_reshape, EEG.chanlocs); % data is processed EEG from eeglab (no epochs removed in EMG)

% Remove epochs that were removed from EEG
% Epochs removed before ICA
for Epochs_Removed_preICA_index = input('List the removed epochs from the EEG dataset before the ICA [] \n' );
    if length(Epochs_Removed_preICA_index) < 1
        EMG_Final = EMG_Final;
    end
    if Epochs_Removed_preICA_index >=1
        EMG_Final(:, [Epochs_Removed_preICA_index:(Epochs_Removed_preICA_index+999)]) = [];
    end
end

% Epoches removed after ICA
for Epochs_Removed_postICA_index = input('List the removed epochs from the EEG dataset after the ICA [] \n' );
    if length(Epochs_Removed_postICA_index) < 1
        EMG_Final = EMG_Final;
    end
    if Epochs_Removed_postICA_index >=1
        EMG_Final(:, [Epochs_Removed_postICA_index:(Epochs_Removed_postICA_index+999)]) = [];
    end
end

%Resize data based off how EEGLAB data is segmented by EEGLab
a = length(EMG_Final);
b = length(EEG_Final);
if abs(a-b) >= 1000
    EMG_Final = EMG_Final(:, 1:(end-1000));
else
    EMG_Final = EMG_Final;
end

%IfERROR, matrix sizes are not compatable, and error in recording epochs deleted
% Concatenate the data
data_Final = [EEG_Final; EMG_Final]; % Add the EEG and EMG signal arrays together

% Create and index the trials for 300 ms pre stimulus and 1500 ms post


current_cidx = event(1).mffkey_cidx;
for index = 2:(length(event))
    if current_cidx == event(index).mffkey_cidx;
        eval(['trials.trial' num2str(current_cidx) '= data_Final(1:end,event(index-1).latency'  ':event(index).latency'  ')']);
        
    else
        current_cidx = event(index).mffkey_cidx;
    end
    
end


% Removes rounding error (EDDIT COMMENT LATER)
trials = struct2cell(trials)
for resize_index = 1:length(trials)
    while size(trials{resize_index, 1}, 2) > 4000
        remove = (size(trials{resize_index, 1}, 2) - 4000);
        trials{resize_index, 1} = trials{resize_index, 1}(:, 1001:end-remove);
    end
end

y = length(trials)


for i = 1:y
    data.time{1, i} = 0:.001:2.999
end
for i = 1:y
    data.trial{1, i} = trials{i, 1}
end
data.label(257) = []
data.hdr.chantype(257:264) = {'emg'}
data.hdr.chantype(265) = {''}

cfg            = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freq           = ft_freqanalysis(cfg, data);

cfg            = [];
cfg.method     = 'coh';
fd             = ft_connectivityanalysis(cfg, freq);

fd.lesion_side = lesion_side;
fd.SUBJ_ID = SUBJ_ID

clearvars -except fd data freq


% Author: Jasper Mark, November 2020
% Last debug: Jasper Mark, 5-12-2021
