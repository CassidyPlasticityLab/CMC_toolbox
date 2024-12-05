function [PACz, PAC, iteratedPAC, ampByPhase] = PACz_cohen(lowFreq_phase, highFreq_power, varargin)
%% Run phase amplitude coupling analysis
% Calculates phase amplitude coupling using Cohen's method
% and calculates a normalized value from a null-distribution created by
% randomly shifting the input data.
%
% INPUTS:
%   lowFreq_phase = time series of phase values of low frequency
%   highFreq_power = time series of amplitude values of high frequency
%
% OPTIONAL INPUTS:
%   options = structure with possible fields:
%       numPhaseBins = double, number of bins for average amplitude in phase
%       numIterations = double, number of iterations for null distribution
%
% OUTPUTS:
%   PACz = normalized PAC (z-score)
%   PAC = raw PAC values
%   iteratedPAC_all = null distribution of PAC values
%   ampByPhase = mean amplitude by phase bin

%% Default options
if ~isempty(varargin)
    options = varargin{1};
else
    options = struct([]);
end
if isfield(options, 'numPhaseBins')
    numPhaseBins = options.numPhaseBins;
else
    numPhaseBins = 30;
end
if isfield(options, 'numIterations')
    numIterations = options.numIterations;
else
    numIterations = 1000;
end

%% COHEN VERSION OF PAC
% Calculate PAC value
PAC_cohen = abs(mean(highFreq_power .* exp(1i * lowFreq_phase)));

%% Power by phase
ampByPhase = NaN(1, numPhaseBins);
phaseSpacing = linspace(min(lowFreq_phase), max(lowFreq_phase), numPhaseBins + 1);
for binIdx = 1:numPhaseBins
    ampByPhase(binIdx) = mean(highFreq_power(lowFreq_phase > phaseSpacing(binIdx) & ...
                                             lowFreq_phase < phaseSpacing(binIdx + 1)));
end

%% Iterative bootstrapping for Cohen's PAC
numTotalTimePoints = length(lowFreq_phase);
iteratedPAC = NaN(numIterations, 1);
shift = 0.1; % Shift proportion (10%-90%)
minShiftNum = ceil(shift * numTotalTimePoints);
numPossRand = floor(numTotalTimePoints * (1 - (2 * shift)));

for iterIdx = 1:numIterations
    % Randomly shift the data
    randIdx = randi(numPossRand);
    shiftPoints = minShiftNum + randIdx;
    thisIter_highFreq_pwr = circshift(highFreq_power, shiftPoints);

    % Calculate Cohen's PAC for this iteration
    iteratedPAC(iterIdx) = abs(mean(thisIter_highFreq_pwr .* exp(1i * lowFreq_phase)));
end

%% Normalize the PAC value using the null distribution
PACz_cohen = (PAC_cohen - mean(iteratedPAC)) / std(iteratedPAC);

%% Store outputs
PACz = PACz_cohen;
PAC = PAC_cohen;

end
