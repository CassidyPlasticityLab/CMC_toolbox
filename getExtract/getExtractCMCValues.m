function [CMCspctrm, CMC, CMCValsOneLine, CMCLabelOneLine] = getExtractCMCValues(fdCMC, fdFourierCMC, chanClass, freqBands, chansRemoved)

col =size(fdCMC.elec.label, 2);
labelsRowIndex = 1;
for i = 1:col
    for j = i+1:col
        elecCoh{i, j} = fdCMC.cohspctrm(labelsRowIndex, :);
        labelsRowIndex = labelsRowIndex+1;
    end
end

%%
freq_size = size(fdFourierCMC.freq, 2);

% number of chans
chan_size = size(chanClass.EEGChans, 2)+size(chanClass.EMGChans, 2)+size(chansRemoved, 2)-1;

numEEGChans = size(chanClass.EEGChans, 2)+size(chansRemoved, 2)-1;


CMCspctrm = fdFourierCMC.cohspctrm;

%%
leftExtensorCoh = reshape(CMCspctrm(195, :, :), [], freq_size);
leftFlexorCoh = reshape(CMCspctrm(196, :, :), [], freq_size);
leftInterosseiCoh = reshape(CMCspctrm(197, :, :), [], freq_size);
leftBicepsCoh = reshape(CMCspctrm(198, :, :), [], freq_size);
rightExtensorCoh = reshape(CMCspctrm(199, :, :), [], freq_size);
rightFlexorCoh = reshape(CMCspctrm(200, :, :), [], freq_size);
rightInterosseiCoh = reshape(CMCspctrm(201, :, :), [], freq_size);
rightBicepsCoh = reshape(CMCspctrm(202, :, :), [], freq_size);

newRow = zeros(1, freq_size);
newRow2 = zeros(32, freq_size);

newLEDCoh = [leftExtensorCoh(1:66, :); newRow; leftExtensorCoh(67:71, :); newRow; leftExtensorCoh(72:79, :);newRow;leftExtensorCoh(80:87, :); newRow; newRow;leftExtensorCoh(88:96, :); newRow; newRow; leftExtensorCoh(97:103, :);newRow; newRow; leftExtensorCoh(104:110, :); newRow; newRow;  leftExtensorCoh(111:121, :); newRow; newRow; leftExtensorCoh(122:131, :); newRow; newRow; leftExtensorCoh(132:140, :); newRow; leftExtensorCoh(141:148, :); newRow; newRow; leftExtensorCoh(149:155, :); newRow; newRow; leftExtensorCoh(156:166, :); newRow; newRow; leftExtensorCoh(167:176, :); newRow; newRow; leftExtensorCoh(177:183, :); newRow; newRow; leftExtensorCoh(184:189, :); newRow; newRow; newRow; newRow; leftExtensorCoh(190:194, :); newRow2;leftExtensorCoh(195:end, :)];
newLFDCoh = [leftFlexorCoh(1:66, :); newRow; leftFlexorCoh(67:71, :); newRow; leftFlexorCoh(72:79, :);newRow;leftFlexorCoh(80:87, :); newRow; newRow;leftFlexorCoh(88:96, :); newRow; newRow; leftFlexorCoh(97:103, :);newRow; newRow; leftFlexorCoh(104:110, :); newRow; newRow;  leftFlexorCoh(111:121, :); newRow; newRow; leftFlexorCoh(122:131, :); newRow; newRow; leftFlexorCoh(132:140, :); newRow; leftFlexorCoh(141:148, :); newRow; newRow; leftFlexorCoh(149:155, :); newRow; newRow; leftFlexorCoh(156:166, :); newRow; newRow; leftFlexorCoh(167:176, :); newRow; newRow; leftFlexorCoh(177:183, :); newRow; newRow; leftFlexorCoh(184:189, :); newRow; newRow; newRow; newRow; leftFlexorCoh(190:194, :); newRow2;leftFlexorCoh(195:end, :)];
newLDFICoh = [leftInterosseiCoh(1:66, :); newRow; leftInterosseiCoh(67:71, :); newRow; leftInterosseiCoh(72:79, :);newRow;leftInterosseiCoh(80:87, :); newRow; newRow;leftInterosseiCoh(88:96, :); newRow; newRow; leftInterosseiCoh(97:103, :);newRow; newRow; leftInterosseiCoh(104:110, :); newRow; newRow;  leftInterosseiCoh(111:121, :); newRow; newRow; leftInterosseiCoh(122:131, :); newRow; newRow; leftInterosseiCoh(132:140, :); newRow; leftInterosseiCoh(141:148, :); newRow; newRow; leftInterosseiCoh(149:155, :); newRow; newRow; leftInterosseiCoh(156:166, :); newRow; newRow; leftInterosseiCoh(167:176, :); newRow; newRow; leftInterosseiCoh(177:183, :); newRow; newRow; leftInterosseiCoh(184:189, :); newRow; newRow; newRow; newRow; leftInterosseiCoh(190:194, :); newRow2;leftInterosseiCoh(195:end, :)];
newLBBCoh = [leftBicepsCoh(1:66, :); newRow; leftBicepsCoh(67:71, :); newRow; leftBicepsCoh(72:79, :);newRow;leftBicepsCoh(80:87, :); newRow; newRow;leftBicepsCoh(88:96, :); newRow; newRow; leftBicepsCoh(97:103, :);newRow; newRow; leftBicepsCoh(104:110, :); newRow; newRow;  leftBicepsCoh(111:121, :); newRow; newRow; leftBicepsCoh(122:131, :); newRow; newRow; leftBicepsCoh(132:140, :); newRow; leftBicepsCoh(141:148, :); newRow; newRow; leftBicepsCoh(149:155, :); newRow; newRow; leftBicepsCoh(156:166, :); newRow; newRow; leftBicepsCoh(167:176, :); newRow; newRow; leftBicepsCoh(177:183, :); newRow; newRow; leftBicepsCoh(184:189, :); newRow; newRow; newRow; newRow; leftBicepsCoh(190:194, :); newRow2;leftBicepsCoh(195:end, :)];
newREDCoh = [rightExtensorCoh(1:66, :); newRow; rightExtensorCoh(67:71, :); newRow; rightExtensorCoh(72:79, :);newRow;rightExtensorCoh(80:87, :); newRow; newRow;rightExtensorCoh(88:96, :); newRow; newRow; rightExtensorCoh(97:103, :);newRow; newRow; rightExtensorCoh(104:110, :); newRow; newRow;  rightExtensorCoh(111:121, :); newRow; newRow; rightExtensorCoh(122:131, :); newRow; newRow; rightExtensorCoh(132:140, :); newRow; rightExtensorCoh(141:148, :); newRow; newRow; rightExtensorCoh(149:155, :); newRow; newRow; rightExtensorCoh(156:166, :); newRow; newRow; rightExtensorCoh(167:176, :); newRow; newRow; rightExtensorCoh(177:183, :); newRow; newRow; rightExtensorCoh(184:189, :); newRow; newRow; newRow; newRow; rightExtensorCoh(190:194, :); newRow2;rightExtensorCoh(195:end, :)];
newRFDCoh = [rightFlexorCoh(1:66, :); newRow; rightFlexorCoh(67:71, :); newRow; rightFlexorCoh(72:79, :);newRow;rightFlexorCoh(80:87, :); newRow; newRow;rightFlexorCoh(88:96, :); newRow; newRow; rightFlexorCoh(97:103, :);newRow; newRow; rightFlexorCoh(104:110, :); newRow; newRow;  rightFlexorCoh(111:121, :); newRow; newRow; rightFlexorCoh(122:131, :); newRow; newRow; rightFlexorCoh(132:140, :); newRow; rightFlexorCoh(141:148, :); newRow; newRow; rightFlexorCoh(149:155, :); newRow; newRow; rightFlexorCoh(156:166, :); newRow; newRow; rightFlexorCoh(167:176, :); newRow; newRow; rightFlexorCoh(177:183, :); newRow; newRow; rightFlexorCoh(184:189, :); newRow; newRow; newRow; newRow; rightFlexorCoh(190:194, :); newRow2;rightFlexorCoh(195:end, :)];
newRDFICoh = [rightInterosseiCoh(1:66, :); newRow; rightInterosseiCoh(67:71, :); newRow; rightInterosseiCoh(72:79, :);newRow;rightInterosseiCoh(80:87, :); newRow; newRow;rightInterosseiCoh(88:96, :); newRow; newRow; rightInterosseiCoh(97:103, :);newRow; newRow; rightInterosseiCoh(104:110, :); newRow; newRow;  rightInterosseiCoh(111:121, :); newRow; newRow; rightInterosseiCoh(122:131, :); newRow; newRow; rightInterosseiCoh(132:140, :); newRow; rightInterosseiCoh(141:148, :); newRow; newRow; rightInterosseiCoh(149:155, :); newRow; newRow; rightInterosseiCoh(156:166, :); newRow; newRow; rightInterosseiCoh(167:176, :); newRow; newRow; rightInterosseiCoh(177:183, :); newRow; newRow; rightInterosseiCoh(184:189, :); newRow; newRow; newRow; newRow; rightInterosseiCoh(190:194, :); newRow2;rightInterosseiCoh(195:end, :)];
newRBBCoh = [rightBicepsCoh(1:66, :); newRow; rightBicepsCoh(67:71, :); newRow; rightBicepsCoh(72:79, :);newRow;rightBicepsCoh(80:87, :); newRow; newRow;rightBicepsCoh(88:96, :); newRow; newRow; rightBicepsCoh(97:103, :);newRow; newRow; rightBicepsCoh(104:110, :); newRow; newRow;  rightBicepsCoh(111:121, :); newRow; newRow; rightBicepsCoh(122:131, :); newRow; newRow; rightBicepsCoh(132:140, :); newRow; rightBicepsCoh(141:148, :); newRow; newRow; rightBicepsCoh(149:155, :); newRow; newRow; rightBicepsCoh(156:166, :); newRow; newRow; rightBicepsCoh(167:176, :); newRow; newRow; rightBicepsCoh(177:183, :); newRow; newRow; rightBicepsCoh(184:189, :); newRow; newRow; newRow; newRow; rightBicepsCoh(190:194, :); newRow2;rightBicepsCoh(195:end, :)];

leftExtensorCoh = newLEDCoh;
leftFlexorCoh = newLFDCoh;
leftInterosseiCoh = newLDFICoh;
leftBicepsCoh = newLBBCoh;
rightExtensorCoh = newREDCoh;
rightFlexorCoh = newRFDCoh;
rightInterosseiCoh = newRDFICoh;
rightBicepsCoh = newRBBCoh;

load ROI;
for i =1:size(ROI, 2)
    leftExtensor{i} = leftExtensorCoh(ROI{2, i}(:, :), :);
    leftFlexor{i} = leftFlexorCoh(ROI{2, i}(:, :), :);
    leftInterossei{i} = leftInterosseiCoh(ROI{2, i}(:, :), :);
    leftBiceps{i} = leftBicepsCoh(ROI{2, i}(:, :), :);
    
    rightExtensor{i} = rightExtensorCoh(ROI{2, i}(:, :), :);
    rightFlexor{i} = rightFlexorCoh(ROI{2, i}(:, :), :);
    rightInterossei{i} = rightInterosseiCoh(ROI{2, i}(:, :), :);
    rightBiceps{i} = rightBicepsCoh(ROI{2, i}(:, :), :);
end

% (round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))

for i = 1:size(ROI, 2)
    CMC.delta.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.leftExtensor.(ROI{1, i}) = mean(leftExtensor{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));

    CMC.delta.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.delta(1) & round(fdCMC.freq) <=freqBands.delta(end))));
    CMC.theta.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.theta(1) & round(fdCMC.freq) <=freqBands.theta(end))));
    CMC.alphaMu.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.alphaMu(1) & round(fdCMC.freq) <=freqBands.alphaMu(end))));
    CMC.beta1.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.beta1(1) & round(fdCMC.freq) <=freqBands.beta1(end))));
    CMC.beta2.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.beta2(1) & round(fdCMC.freq) <=freqBands.beta2(end))));
    CMC.gamma1.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.gamma1(1) & round(fdCMC.freq) <=freqBands.gamma1(end))));
    CMC.gamma2.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}((round(fdCMC.freq) >=freqBands.gamma2(1) & round(fdCMC.freq) <=freqBands.gamma2(end))));
    
    
% %     
% %     CMC.delta.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.delta));
% %     CMC.theta.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.theta));
% %     CMC.alphaMu.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.alphaMu));
% %     CMC.beta1.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.beta1));
% %     CMC.beta2.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.beta2));
% %     CMC.gamma1.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.gamma1));
% %     CMC.gamma2.leftFlexor.(ROI{1, i}) = mean(leftFlexor{1, i}(freqBands.gamma2));
% %     
% %     CMC.delta.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.delta));
% %     CMC.theta.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.theta));
% %     CMC.alphaMu.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.alphaMu));
% %     CMC.beta1.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.beta1));
% %     CMC.beta2.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.beta2));
% %     CMC.gamma1.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.gamma1));
% %     CMC.gamma2.leftInterossei.(ROI{1, i}) = mean(leftInterossei{1, i}(freqBands.gamma2));
%     
%     CMC.delta.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.delta));
%     CMC.theta.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.theta));
%     CMC.alphaMu.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.alphaMu));
%     CMC.beta1.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.beta1));
%     CMC.beta2.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.beta2));
%     CMC.gamma1.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.gamma1));
%     CMC.gamma2.leftBiceps.(ROI{1, i}) = mean(leftBiceps{1, i}(freqBands.gamma2));
%     
%     CMC.delta.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.delta));
%     CMC.theta.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.theta));
%     CMC.alphaMu.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.alphaMu));
%     CMC.beta1.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.beta1));
%     CMC.beta2.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.beta2));
%     CMC.gamma1.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.gamma1));
%     CMC.gamma2.rightExtensor.(ROI{1, i}) = mean(rightExtensor{1, i}(freqBands.gamma2));
%     
%     CMC.delta.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.delta));
%     CMC.theta.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.theta));
%     CMC.alphaMu.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.alphaMu));
%     CMC.beta1.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.beta1));
%     CMC.beta2.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.beta2));
%     CMC.gamma1.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.gamma1));
%     CMC.gamma2.rightFlexor.(ROI{1, i}) = mean(rightFlexor{1, i}(freqBands.gamma2));
%     
%     CMC.delta.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.delta));
%     CMC.theta.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.theta));
%     CMC.alphaMu.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.alphaMu));
%     CMC.beta1.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.beta1));
%     CMC.beta2.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.beta2));
%     CMC.gamma1.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.gamma1));
%     CMC.gamma2.rightInterossei.(ROI{1, i}) = mean(rightInterossei{1, i}(freqBands.gamma2));
%     
%     CMC.delta.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.delta));
%     CMC.theta.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.theta));
%     CMC.alphaMu.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.alphaMu));
%     CMC.beta1.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.beta1));
%     CMC.beta2.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.beta2));
%     CMC.gamma1.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.gamma1));
%     CMC.gamma2.rightBiceps.(ROI{1, i}) = mean(rightBiceps{1, i}(freqBands.gamma2));
end

fields_A = fieldnames(CMC);
for i = 1:length(fields_A)
    fields_B = fieldnames(CMC.(fields_A{i}));
    for j = 1:length(fields_B)
        fields_C = fieldnames(CMC.(fields_A{i}).(fields_B{j}));
    end
end


monsterArrayLength = length(fields_A)*length(fields_B)*length(fields_C);
cohValsOneLine = zeros(1, monsterArrayLength);
for i = 1:monsterArrayLength
    for j = 1:length(fields_A)
        for k = 1:length(fields_B)
            for l = 1:length(fields_C)
                cohValsOneLine(i) = CMC.(fields_A{j}).(fields_B{k}).(fields_C{l});
                cohLabelOneLine{i} = strcat(fields_A{j}, '_', fields_B{k}, '_', fields_C{l});
                i = i+1;
            end
        end
    end
end


CMCValsOneLine = cohValsOneLine(1792:end);
CMCLabelOneLine = cohLabelOneLine(1792:end);

end