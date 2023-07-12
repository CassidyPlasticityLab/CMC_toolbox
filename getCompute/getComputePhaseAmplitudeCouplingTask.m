function [freqPAC, fdPAC] = getComputePhaseAmplitudeCouplingTask(data)

cfg            = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqPAC        = ft_freqanalysis(cfg, data);


cfg            = [];
cfg.method      = 'plv';
fdPAC = ft_connectivityanalysis(cfg, freqPAC);
end
