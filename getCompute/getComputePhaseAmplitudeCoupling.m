function [PACz, PAC, ampByPhase] = getComputePhaseAmplitudeCoupling(data, fsample, chanClass, lowFreq, highFreq, lowFreqSeed)
% myDir = '\\ad.unc.edu\med\ahs\Groups\CassidyLab\PersonalFolders_CassidyLabMembers\Jasper\FinalEEGsforPAC\PACpre';

data = horzcat(data.trial{1, 1:end});

signal_seed = mean(data(lowFreqSeed, :));
[lowPhase_seed, lowAmp_seed] =hilbertTransform_JR(fsample, [lowFreq], signal_seed(1, :));

for  idxElec= 1:size(data, 1)
    [highPhase_elec(idxElec, :), highAmp_elec(idxElec, :)] =hilbertTransform_JR(fsample, [highFreq], data(idxElec, :));
end

% Compute PAC for each electrode with respect to the seed
for idxElec = 1:size(data, 1)
    % Combine low-phase with high-frequency amplitude for PAC computation
    [lowPhaseHighAmp, ~] = hilbertTransform_JR(fsample, [lowFreq], highAmp_elec(idxElec, :));
    
    % Compute PAC metrics (PACz and raw PAC)
    [PACz(idxElec, :), PAC(idxElec, :), iteratedPAC(idxElec, :),ampByPhase(idxElec, :)] = PACz_cohen(lowPhase_seed, highAmp_elec(idxElec, :), lowPhaseHighAmp);
end

end
