% FT_MAIN reads in .mff files collected via EGI netstation and applies
% several user-specified preprocessing steps including filtering,
% rereferencing, and channel selection

% FT_MAIN calls in the event markers and breaks the data collected into
% trials during muscle contraction with a slight buffer

% It preprocesses the data


%Load the dataset into Matlab
cfg = [];
cfg.dataset = 'Beta_Test_1_Task.mff';
data = ft_preprocessing(cfg);

%View Events
[event] = ft_read_event('Beta_Test_1_Task.mff');

%Remove Unnecessary Channels
cfg.channel = [1:66 68:72 74:81 83:90 93:101 104:110 113:119 122:132 135:144 147:155 157:164 167:173 176:186 189:198 201:207 210:215 220:224];
data = ft_preprocessing(cfg, data);

%Isolate data
Raw_data = data.trial{1, 1};
EEG = Raw_data(1:194, :);
EMG = Raw_data(195:197, :);

emg_data_extensors = EMG(1,:);
emg_data_flexors = EMG(2,:);
emg_data_policis = EMG(3,:);

%Load the dataset into Matlab
cfg = [];
cfg.dataset = 'Beta_Test_1_Task.mff';
data = ft_preprocessing(cfg);

%View Events
[event] = ft_read_event('Beta_Test_1_Task.mff');

%Filter and rectify the EMG signals
cfg.lpfreq = 200;
cfg.hpfreq = 10;
cfg.channel = {'Extensor', 'Flexor', 'Policis'};
cfg.rectify = 'yes';
EMG_rectify = ft_preprocessing(cfg, data);

%Extract EMG signal
EMG_Signal = EMG_rectify.trial{1, 1}