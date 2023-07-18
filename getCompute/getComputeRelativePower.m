function [freqRelPow] = getComputeRelativePower(data, freqBands)


cfg            = [];
cfg.output     = 'pow';
cfg.method     = 'mtmfft';
cfg.foilim     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freqRelPow           = ft_freqanalysis(cfg, data);

for i = 1:size(freqRelPow.powspctrm, 1)
    for j = 1:size(freqRelPow.powspctrm, 2)
relPowSpctrm(i, j, :) = freqRelPow.powspctrm(i, j, :)/ sum(freqRelPow.powspctrm(i, j, (round(freqRelPow.freq) >=freqBands.delta(1) & round(freqRelPow.freq) <=freqBands.beta2(end))));
end
end

freqRelPow.relPowSpctrm = relPowSpctrm;

end
