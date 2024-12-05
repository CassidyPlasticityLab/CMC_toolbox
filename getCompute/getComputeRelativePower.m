function [freqRelPow] = getComputeRelativePower(data)


cfg            = [];
cfg.output     = 'pow';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqRelPow           = ft_freqanalysis(cfg, data);

for i = 1:size(freqRelPow.powspctrm, 1)
    for j = 1:size(freqRelPow.powspctrm, 2)
relPowSpctrm(i, j, :) = freqRelPow.powspctrm(i, j, :)/mean(freqRelPow.powspctrm(i, j, :));
end
end

freqRelPow.relPowSpctrm = relPowSpctrm;

end
