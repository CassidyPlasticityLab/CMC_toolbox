% modify the input parameters below. You must define
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

config.dataPath   = 'Z:/ahs/Groups/CassidyLab/EEG_CognitiveMotor_Study/Data/EEG/Young/final/Right/final';
config.pnsData = 'y'; %Is there EMG/ECG? Or other PNS data you would like to process (y/n)
config.stroke = 'n'; %Is this stroke data
config.lesionSide = {'l', 'r', 'l','l', 'l', 'l', 'r', 'l','l', 'l', 'l', 'r', 'l','l', 'l', 'l', 'r', 'l','l', 'l', 'l', 'r', 'l','l', 'l', 'l', 'r', 'l','l', 'l'} %lesion hemisphere side ('l'/'r'). If control data enter 'l'. This is for each subject to be processed.
config.chansRemoved = [67, 73, 82, 91, 92, 102, 103, 111, 112, 120, 121, 133, 134, 145, 146, 156, 165, 166, 174, 175, 187, 188, 199, 200, 208, 209, 216, 217, 218, 219, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257];
config.hilb = 'y';  %Do you want to hilbert transform the PNS data(y/n)
config.rectify = 'y'; %Do you want to rectify the PNS data(y/n)
config.strokeType = 'cort'; %Was the stroke cortical or cerebellar (cort/cereb). If no stroke...leave at cortical
config.trialStart = 1000; %Start time within each epoch for computation
config.trialEnd = 4000; %End time within each epoch for computation
config.extremityLableValue = 6; %write the value of the extremity in the name (i.e. S001_v1_L_final.set => 9 [9 characters])
config.saveTopos = 'n'; % Do you want to save the topos (y/n)

%Define Frequency Bands
config.freqBands.delta = 1:3; %1-3Hz
config.freqBands.theta = 4:7; %4-7Hz
config.freqBands.alphaMu = 8:12; %8-12Hz
config.freqBands.beta1 = 13:19; %13-19Hz
config.freqBands.beta2 = 20:30; %20-30Hz
config.freqBands.gamma1 = 31:40; %31-40Hz
config.freqBands.gamma2 = 41:50; %41-50Hz
config.fsample = 1000; %sample rate
config.PACLowFreq = [1 4]; %freq range in hz
config.PACHighFreq = [13 30]; %freq range in hz
config.PACLowFreqRoi = [32, 37, 46,54, 61,33,38,47,55,27,34,39,48,28,35,1,2, 3, 4, 10, 11, 12, 13, 18, 19, 20, 25, 190, 191, 192]; %Range of electrodes to use for PAC low frequency seed region


% Desired Outputs
config.computeCoherence = 'n'; %Do you want to compute scalp coherence (y/n)
config.computeCMC ='n'; %Do you want to compute corticomuscular coherence (y/n)
config.computeRelativePower = 'n'; %Do you want to compute relative power (y/n)
config.computePAC = 'n'; %Do you want to compute relative power (y/n)


config.fileList = dir(fullfile(config.dataPath, '**', '*.set'));

addpath(config.dataPath)