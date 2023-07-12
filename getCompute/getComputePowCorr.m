function [freqPowCorr, fdPowCorr] = getComputePowCorr(data)


cfg            = [];
cfg.output     = 'pow';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqPowCorr           = ft_freqanalysis(cfg, data);

cfg            = [];
cfg.method     = 'powcorr';
cfg.keeptrials = 'yes';
fdPowCorr             = ft_connectivityanalysis(cfg, freqPowCorr);

end
