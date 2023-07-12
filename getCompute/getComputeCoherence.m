function [freqFourierCoh, fdFourierCoh] = getComputeCoherence(data)

% cfg            = [];
% cfg.output     = 'powandcsd';
% cfg.method     = 'mtmfft';
% cfg.foilim     = [1 50];
% cfg.channel    = 'E*';
% cfg.tapsmofrq  = 5;
% cfg.keeptrials = 'yes';
% freqCoh           = ft_freqanalysis(cfg, data);

cfg            = [];
cfg.output     = 'fourier';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.channel    = 'E*';
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqFourierCoh           = ft_freqanalysis(cfg, data);

% cfg            = [];
% cfg.method     = 'coh';
% cfg.keeptrials = 'yes';
% fdCoh             = ft_connectivityanalysis(cfg, freqCoh);

cfg            = [];
cfg.method     = 'coh';
cfg.keeptrials = 'yes';
fdFourierCoh      = ft_connectivityanalysis(cfg, freqFourierCoh);


end
