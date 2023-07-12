% EMG_PREPROCESS reads in .mff files collected via EGI netstation and
% isolates the data collected from the PNS system labeled 'Extensor' 
% 'Flexor' and 'Policis'. 

% It filters and rectifies the EMG data.
% It also plots an interactive plot where the data can be scrolled through.

%       Once the plot is opened, select the button labeled 'vertical' and 
%       change the range to [-5 100]

%Load the dataset into Matlab
cfg = [];
cfg.dataset = 'Beta_Test_1_Task.mff';
data = ft_preprocessing(cfg);

%Filter and rectify the EMG signals
cfg.lpfreq = 200;
cfg.hpfreq = 10;
cfg.channel = {'Extensor', 'Flexor', 'Policis'};
cfg.rectify = 'yes';
EMG_rectify = ft_preprocessing(cfg, data);


%Scroll plot the EMG electrodes
cfg = [];
cfg.channel       = 'all';
cfg.layout        = ft_prepare_layout([],EMG_rectify);
cfg.viewmode      = 'vertical'; % 'butterfly', 'vertical', 'component' for visualizing ICA/PCA components (default is 'butterfly')
cfg.blocksize     = 10; %time frame 
EMGscroll = ft_databrowser(cfg,EMG_rectify);


