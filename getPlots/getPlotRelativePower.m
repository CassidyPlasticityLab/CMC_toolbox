function [imName] = getPlotRelativePower(EEG, freqRelPow, chanClass, freqBands, lesionSide, strokeType, saveTopos, imageName)

cfg                  = [];
cfg.parameter        = 'relPowSpctrm';
cfg.xlim             = [freqBands.delta(1) freqBands.delta(end-1); freqBands.theta(1) freqBands.theta(end-1); freqBands.alphaMu(1) freqBands.alphaMu(end-1); freqBands.beta1(1) freqBands.beta1(end-1); freqBands.beta2(1) freqBands.beta2(end-1); freqBands.gamma1(1) freqBands.gamma1(end-1); freqBands.gamma2(1) freqBands.gamma2(end-1)];
%cfg.zlim             = [0.0 1];
cfg.comment          = 'xlim';
cfg.channel = chanClass.EEGOriginalLabels;
cfg.colorbar = 'yes';
% cfg.highlight = 'on';
% cfg.highlightcolor = 'red';
% cfg.highlightsymbol = '.';
% cfg.highlightsize = 12;

if lesionSide == 'r'
    if strokeType == 'cort'
        cfg.layout           = 'GSN-HydroCel-257-flip.sfp';
        
    end
else
    cfg.layout       = 'GSN-HydroCel-257.sfp';
    
end
figure; ft_topoplotER(cfg, freqRelPow);
imName = strcat(imageName(1:end-4), '_POW_', '.svg');
title(imName)
if saveTopos =='y'
    saveas(gcf, imName);
end
end