function [freqCMC, freqFourierCMC, fdCMC,fdFourierCMC] = getComputeCMC(data)

cfg            = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqCMC           = ft_freqanalysis(cfg, data);

cfg            = [];
cfg.output     = 'fourier';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqFourierCMC           = ft_freqanalysis(cfg, data);

cfg            = [];
cfg.method     = 'coh';
cfg.keeptrials = 'yes';
fdCMC             = ft_connectivityanalysis(cfg, freqCMC);

cfg            = [];
cfg.method     = 'coh';
cfg.keeptrials = 'yes';
fdFourierCMC      = ft_connectivityanalysis(cfg, freqFourierCMC);


end
