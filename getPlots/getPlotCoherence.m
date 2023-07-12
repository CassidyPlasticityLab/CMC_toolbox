function [imName] = getPlotCoherence(EEG, fdCoh, chanClass, freqBands, lesionSide, strokeType, saveTopos, imageName)

left_M1 = {'E59' 'E58' 'E51' 'E52' 'E60' 'E66' 'E65'};
right_M1 = {'E155' 'E164' 'E182' 'E183' 'E184' 'E195' 'E196'}
%GRAPHI
cfg                  = [];
cfg.parameter        = 'cohspctrm';
cfg.xlim             = [freqBands.delta(1) freqBands.delta(end-1); freqBands.theta(1) freqBands.theta(end-1); freqBands.alphaMu(1) freqBands.alphaMu(end-1); freqBands.beta1(1) freqBands.beta1(end-1); freqBands.beta2(1) freqBands.beta2(end-1); freqBands.gamma1(1) freqBands.gamma1(end-1); freqBands.gamma2(1) freqBands.gamma2(end-1)];
cfg.zlim             = [0.0 .5];
cfg.comment          = 'xlim';
cfg.channel = chanClass.EEGOriginalLabels;
cfg.colorbar = 'yes';


if lesionSide == 'r'
    if strokeType == 'cort'
        cfg.layout           = 'GSN-HydroCel-257-flip.sfp';
        cfg.refchannel = right_M1;
    end
else
    cfg.layout       = 'GSN-HydroCel-257.sfp';
    cfg.refchannel = left_M1;
end
figure; ft_topoplotER(cfg, fdCoh);
imName = strcat(imageName(1:end-4), '_COH_', 'M1', '.svg');
title(imName)
if saveTopos =='y'
    saveas(gcf, imName);
end
end