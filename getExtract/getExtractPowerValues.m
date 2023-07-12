function [relPow, relPowValsOneLine, relPowLabelOneLine] = getExtractPowerValues(freqRelPow, freqBands, EEG, chanClass)

load ROI
% averagedTrialPow = squeeze(mean(freqRelPow.powspctrm, 1));
% trialPowChansAdded = add_deleted_chans(averagedTrialPow, EEG.chanlocs);
% trialPow = vertcat(trialPowChansAdded, averagedTrialPow(chanClass.EMGChans, :));
% 
% powDelta = trialPow(:, (round(freqRelPow.freq) >=freqBands.delta(1) & round(freqRelPow.freq) <=freqBands.delta(end)));
% powTheta = trialPow(:, (round(freqRelPow.freq) >=freqBands.theta(1) & round(freqRelPow.freq) <=freqBands.theta(end)));
% powAlphaMu = trialPow(:, (round(freqRelPow.freq) >=freqBands.alphaMu(1) & round(freqRelPow.freq) <=freqBands.alphaMu(end)));
% powBeta1 = trialPow(:, (round(freqRelPow.freq) >=freqBands.beta1(1) & round(freqRelPow.freq) <=freqBands.beta1(end)));
% powBeta2 = trialPow(:,(round(freqRelPow.freq) >=freqBands.beta2(1) & round(freqRelPow.freq) <=freqBands.beta2(end)));
% powGamma1 = trialPow(:, (round(freqRelPow.freq) >=freqBands.gamma1(1) & round(freqRelPow.freq) <=freqBands.gamma1(end)));
% powGamma2 = trialPow(:, (round(freqRelPow.freq) >=freqBands.gamma2(1) & round(freqRelPow.freq) <=freqBands.gamma2(end)));
% powAllFreq = trialPow(:, :);
% 
% for roiIndex = 1:length(ROI)
%     Pow.delta.(ROI{1, roiIndex}) = mean(mean(powDelta(ROI{2, roiIndex})));
%     Pow.theta.(ROI{1, roiIndex}) = mean(mean(powTheta(ROI{2, roiIndex})));
%     Pow.alphaMu.(ROI{1, roiIndex}) = mean(mean(powAlphaMu(ROI{2, roiIndex})));
%     Pow.beta1.(ROI{1, roiIndex}) = mean(mean(powBeta1(ROI{2, roiIndex})));
%     Pow.beta2.(ROI{1, roiIndex}) = mean(mean(powBeta2(ROI{2, roiIndex})));
%     Pow.gamma1.(ROI{1, roiIndex}) = mean(mean(powGamma1(ROI{2, roiIndex})));
%     Pow.gamma2.(ROI{1, roiIndex}) = mean(mean(powGamma2(ROI{2, roiIndex})));
%     Pow.allFreq.(ROI{1, roiIndex}) = mean(mean(powAllFreq(ROI{2, roiIndex})));
% end
% fields_A = fieldnames(Pow);
% for i = 1:length(fields_A)
%     fields_B = fieldnames(Pow.(fields_A{i}));
% end
% 
% 
% monsterArrayLength = length(fields_A)*length(fields_B);
% powValsOneLine = zeros(1, monsterArrayLength);
% for i = 1:monsterArrayLength
%     for j = 1:length(fields_A)
%         for k = 1:length(fields_B)
%             powValsOneLine(i) = Pow.(fields_A{j}).(fields_B{k});
%             powLabelOneLine{i} = strcat(fields_A{j}, '_', fields_B{k});
%             i = i+1;
%         end
%     end
% end
% 
% 
% 
% powValsOneLine = powValsOneLine(256:end);
% powLabelOneLine = powLabelOneLine(256:end);

%Repeat the above for relative power
averagedTrialRelPow = squeeze(mean(freqRelPow.relPowSpctrm, 1));
trialRelPowChansAdded = add_deleted_chans(averagedTrialRelPow, EEG.chanlocs);
trialRelPow = vertcat(trialRelPowChansAdded, averagedTrialRelPow(chanClass.EMGChans, :));

relPowDelta = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.delta(1) & round(freqRelPow.freq) <=freqBands.delta(end)));
relPowTheta = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.theta(1) & round(freqRelPow.freq) <=freqBands.theta(end)));
relPowAlphaMu = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.alphaMu(1) & round(freqRelPow.freq) <=freqBands.alphaMu(end)));
relPowBeta1 = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.beta1(1) & round(freqRelPow.freq) <=freqBands.beta1(end)));
relPowBeta2 = trialRelPow(:,(round(freqRelPow.freq) >=freqBands.beta2(1) & round(freqRelPow.freq) <=freqBands.beta2(end)));
relPowGamma1 = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.gamma1(1) & round(freqRelPow.freq) <=freqBands.gamma1(end)));
relPowGamma2 = trialRelPow(:, (round(freqRelPow.freq) >=freqBands.gamma2(1) & round(freqRelPow.freq) <=freqBands.gamma2(end)));
relPowAllFreq = trialRelPow(:, :);


for roiIndex = 1:length(ROI)
    relPow.delta.(ROI{1, roiIndex}) = mean(mean(relPowDelta(ROI{2, roiIndex})));
    relPow.theta.(ROI{1, roiIndex}) = mean(mean(relPowTheta(ROI{2, roiIndex})));
    relPow.alphaMu.(ROI{1, roiIndex}) = mean(mean(relPowAlphaMu(ROI{2, roiIndex})));
    relPow.beta1.(ROI{1, roiIndex}) = mean(mean(relPowBeta1(ROI{2, roiIndex})));
    relPow.beta2.(ROI{1, roiIndex}) = mean(mean(relPowBeta2(ROI{2, roiIndex})));
    relPow.gamma1.(ROI{1, roiIndex}) = mean(mean(relPowGamma1(ROI{2, roiIndex})));
    relPow.gamma2.(ROI{1, roiIndex}) = mean(mean(relPowGamma2(ROI{2, roiIndex})));
    relPow.allFreq.(ROI{1, roiIndex}) = mean(mean(relPowAllFreq(ROI{2, roiIndex})));
end

fields_A = fieldnames(relPow);
for i = 1:length(fields_A)
    fields_B = fieldnames(relPow.(fields_A{i}));
end


monsterArrayLength = length(fields_A)*length(fields_B);
relPowValsOneLine = zeros(1, monsterArrayLength);
for i = 1:monsterArrayLength
    for j = 1:length(fields_A)
        for k = 1:length(fields_B)
            relPowValsOneLine(i) = relPow.(fields_A{j}).(fields_B{k});
            relPowLabelOneLine{i} = strcat(fields_A{j}, '_', fields_B{k});
            i = i+1;
        end
    end
end

relPowValsOneLine = relPowValsOneLine(256:end);
relPowLabelOneLine = relPowLabelOneLine(256:end);