function [cohSpctrm, coh, cohValsOneLine, cohLabelOneLine] = getExtractCohValues(fdFourierCoh, chanClass, freqBands)
load ROI
cohSpctrm = fdFourierCoh.cohspctrm;

cohSpctrmDelta = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.delta(1) & round(fdFourierCoh.freq) <=freqBands.delta(end))), 3));
cohSpctrmTheta = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.theta(1) & round(fdFourierCoh.freq) <=freqBands.theta(end))), 3));
cohSpctrmAlphaMu = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.alphaMu(1) & round(fdFourierCoh.freq) <=freqBands.alphaMu(end))), 3));
cohSpctrmBeta1 = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.beta1(1) & round(fdFourierCoh.freq) <=freqBands.beta1(end))), 3));
cohSpctrmBeta2 = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.beta2(1) & round(fdFourierCoh.freq) <=freqBands.beta2(end))), 3));
cohSpctrmGamma1 = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.gamma1(1) & round(fdFourierCoh.freq) <=freqBands.gamma1(end))), 3));
cohSpctrmGamma2 = squeeze(mean(cohSpctrm(:, :, (round(fdFourierCoh.freq) >=freqBands.gamma2(1) & round(fdFourierCoh.freq) <=freqBands.gamma2(end))), 3));

[cohSpctrmDelta] = add_deleted_chans_square_matrix(cohSpctrmDelta);
[cohSpctrmTheta] = add_deleted_chans_square_matrix(cohSpctrmTheta);
[cohSpctrmAlphaMu] = add_deleted_chans_square_matrix(cohSpctrmAlphaMu);
[cohSpctrmBeta1] = add_deleted_chans_square_matrix(cohSpctrmBeta1);
[cohSpctrmBeta2] = add_deleted_chans_square_matrix(cohSpctrmBeta2);
[cohSpctrmGamma1] = add_deleted_chans_square_matrix(cohSpctrmGamma1);
[cohSpctrmGamma2] = add_deleted_chans_square_matrix(cohSpctrmGamma2);

for roiIndex = 1:length(ROI)-8
    region.delta.(ROI{1, roiIndex}) = cohSpctrmDelta(ROI{2, roiIndex}, :);
    region.theta.(ROI{1, roiIndex}) = cohSpctrmTheta(ROI{2, roiIndex}, :);
    region.alphaMu.(ROI{1, roiIndex}) = cohSpctrmAlphaMu(ROI{2, roiIndex}, :);
    region.beta1.(ROI{1, roiIndex}) = cohSpctrmBeta1(ROI{2, roiIndex}, :);
    region.beta2.(ROI{1, roiIndex}) = cohSpctrmBeta2(ROI{2, roiIndex}, :);
    region.gamma1.(ROI{1, roiIndex}) = cohSpctrmGamma1(ROI{2, roiIndex}, :);
    region.gamma2.(ROI{1, roiIndex}) = cohSpctrmGamma2(ROI{2, roiIndex}, :);
end

for  regionIndex = 1:length(ROI)-8
    for roiIndex = 1:length(ROI)-8
        coh.delta.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.delta.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.theta.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.theta.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.alphaMu.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.alphaMu.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.beta1.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.beta1.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.beta2.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.beta2.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.gamma1.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.gamma1.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));
        coh.gamma2.(ROI{1, regionIndex}).(ROI{1, roiIndex}) = mean(mean(region.gamma2.(ROI{1, regionIndex})(:, ROI{2, roiIndex})));

    end
end

fields_A = fieldnames(coh);
for i = 1:length(fields_A)
    fields_B = fieldnames(coh.(fields_A{i}));
    for j = 1:length(fields_B)
        fields_C = fieldnames(coh.(fields_A{i}).(fields_B{j}));
    end
end


monsterArrayLength = length(fields_A)*length(fields_B)*length(fields_C);
cohValsOneLine = zeros(1, monsterArrayLength);
for i = 1:monsterArrayLength
    for j = 1:length(fields_A)
        for k = 1:length(fields_B)
            for l = 1:length(fields_C)
                cohValsOneLine(i) = coh.(fields_A{j}).(fields_B{k}).(fields_C{l});
                cohLabelOneLine{i} = strcat(fields_A{j}, '_', fields_B{k}, '_', fields_C{l});
                i = i+1;
            end
        end
    end
end


cohValsOneLine = cohValsOneLine(4032:end);
cohLabelOneLine = cohLabelOneLine(4032:end);
