% main reads in processed EEG data from eeglab (.set) and computes various
% biomarkers including power, coherence, and corticomusuclar coherence.

% Calculations are ultimately averaged across each epoch.

% To Run, modify the input parameters below. You must define
%   [1] the path where the data is stored
%   [2] whether there is PNS input (EMG/ECG data)
%   [3] whether the data is stroke or healthy control
%   [4] channels removed from the dataset during processing
%   [5] whether to hilbert transform the data
%   [6] whether to rectify the data
%   [7] whether affected (or right) or less affected (or left) extremity
%   [8] stroke type (cortical/cerebellar)
%   [9] trial computation window start time
%   [10] trial computation window end time
%   [11] extremity label value in the file name
%   [12] frequency bands ranges
%   [13] desired outputs

%OUTPUT:
%   cohSpctrm: a 3D matrix containing coherence data (Chan X Chan X Freq [0.33 increments starting at 1])
%   cohValsOneLine: A 1XN array containing coherence values
%   cohLabelOneLine: A 1XN array containing coherence label strings
%   CMCSpctrm: a 3D matrix containing CMC data (Chan X Chan X Freq [0.33 increments starting at 1])
%   CMCValsOneLine: A 1XN array containing CMC values
%   CMCLabelOneLine: A 1XN array containing CMC label strings
%   relPowSpctrm: a 3D matrix containing CMC data (Chan X Chan X Freq [0.33 increments starting at 1])
%   relPowValsOneLine: A 1XN array containing CMC values
%   relPowLabelOneLine: A 1XN array containing CMC label strings
%   retainedTrials: 1XN array defining which epochs are retained after preprocessing
%   totalTrials: A single number defining how many EPOCHS were performed during task data

%SPECIAL NOTE:
% During task, the outputs define the right hand as the task performing
% extremity. Meaning if it is left hand performing the task data, the hands
% and cortices are flipped.

%Additionally, it is standardized so the left hemisphere is ipsilesional.

%To run. Input parameters in the config.m script

configToolbox;
for indexProcess = 1:length(config.fileList)
    tic
    clearvars -except config indexProcess
    
    %Load in the processed data for analysis
    EEG = pop_loadset(config.fileList(indexProcess).name);
    
    config.extremity = config.fileList(indexProcess).name(config.extremityLableValue); %Is this right (affected) or left (less-affected) extremity data (r/l). Note data is standardized so the affected extremity is the right hand
    
    chanClass = getChanClass(EEG);
    
    %Apply Hilbert Transform
    if config.hilb == 'y'
        EEG.data(chanClass.EMGChans, :, :) = hilbert(EEG.data(chanClass.EMGChans, :, :));
        disp('Hilbert Transform applied to EMG');
    else
        EEG.data = EEG.data;
    end
    
    %Rectify EMG
    if config.rectify =='y'
        EEG.data(chanClass.EMGChans, :, :) = abs(EEG.data(chanClass.EMGChans, :, :));
        disp('EMG is rectified')
    else
        EEG.data = EEG.data;
    end
    
    %Flip electrodes
    EEG = flipElecs(EEG, config.lesionSide{1, indexProcess}, config.extremity, config.strokeType, chanClass);
    
    %Compute the total number of trials and which trials were retained for    tolerability
    [retainedTrials, totalTrials] = getRetainedTrials(EEG);
    
    %Convert data for fieldtrip processing
    data  = eeglab2fieldtrip(EEG, 'preprocessing');
    col = size(EEG.chanlocs, 2);
    for i = 1:col
        data.label{i} = EEG.chanlocs(i).labels;
    end
    
    col = size(data.trial, 2);
    for i = 1:col
        data.trial{1, i} = data.trial{1, i}(:, config.trialStart:config.trialEnd);
        data.time{1, i} = data.time{1, i}(:, config.trialStart:config.trialEnd);
    end
    
    if config.computeCoherence == 'y'
        [freqFourierCoh,fdFourierCoh] = getComputeCoherence(data);
        [cohSpctrm, coh, cohValsOneLine, cohLabelOneLine] = getExtractCohValues(fdFourierCoh, chanClass, config.freqBands);
        [imName] = getPlotCoherence(EEG, fdFourierCoh, chanClass, config.freqBands, config.lesionSide{1, indexProcess}, config.strokeType, config.saveTopos, config.fileList(indexProcess).name);
    end
    
    if config.pnsData == 'y'
        if config.computeCMC == 'y'
            [freqCMC, freqFourierCMC, fdCMC,fdFourierCMC] = getComputeCMC(data);
            [CMCSpctrm, CMC, CMCValsOneLine, CMCLabelOneLine] = getExtractCMCValues(fdCMC, fdFourierCMC, chanClass, config.freqBands, config.chansRemoved);
            [imName] = getPlotCMC(EEG, fdCMC, chanClass, config.freqBands, config.lesionSide{1, indexProcess}, config.strokeType, config.saveTopos, config.fileList(indexProcess).name);
        end
        
    end
    
    
    if config.computeRelativePower == 'y'
        [freqRelPow] = getComputeRelativePower(data);
        [relPowSpctrm, relPowValsOneLine, relPowLabelOneLine] = getExtractPowerValues(freqRelPow, config.freqBands, EEG, chanClass);
        [imName] = getPlotRelativePower(EEG, freqRelPow, chanClass, config.freqBands, config.lesionSide{1, indexProcess}, config.strokeType, config.saveTopos, config.fileList(indexProcess).name);
    end
    
    if config.computePAC == 'y'
        [PACz, PAC, ampByPhase] = getComputePhaseAmplitudeCoupling(data, config.fsample, chanClass, config.PACLowFreq, config.PACHighFreq, config.PACLowFreqRoi);
    end
    
    saveName = strcat(config.fileList(indexProcess).name(1:end-4), '_CMC_POW_COH');
    
    
    % List of variables to save
    variableList = {'cohSpctrm', 'cohValsOneLine', 'cohLabelOneLine', ...
        'CMCSpctrm', 'CMCValsOneLine', 'CMCLabelOneLine', ...
        'relPowSpctrm', 'relPowValsOneLine', 'relPowLabelOneLine', ...
        'retainedTrials', 'totalTrials', 'PACz', 'PAC', 'ampByPhase'};
    
    % Initialize a struct to hold the variables
    dataToSave = struct();
    
    % Loop through the variable list and add existing variables to the struct
    for i = 1:length(variableList)
        if exist(variableList{i}, 'var') % Check if the variable exists
            dataToSave.(variableList{i}) = eval(variableList{i}); % Add to the struct
        end
    end
    
    % Save the struct to the file
    if ~isempty(fieldnames(dataToSave)) % Ensure there is data to save
        save(saveName, '-struct', 'dataToSave');
        fprintf('Data saved to %s\n', saveName);
    else
        fprintf('No variables to save.\n');
    end
    toc
    clearvars -except config
    
end
displayCredits

% Author: Jasper Mark
% Revised: 7/11/2023

