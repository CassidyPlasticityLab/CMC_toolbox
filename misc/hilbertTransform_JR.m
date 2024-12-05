function [varargout]=hilbertTransform_JR(sampleRate,bandRange,inputData,varargin)

% Default to output amplitude and phase
analyticSignalFLAG = 0;
if ~isempty(varargin)
    % Analytic Signal for Ampltiude Phase
    analyticSignalFLAG = varargin{1};
    if strcmp(analyticSignalFLAG,'as')
        analyticSignalFLAG = 1;
    end
end
mirrorFLAG = 1;
if length(varargin)>1
    if strcmpi(varargin{2},'off')
        mirrorFLAG = 0;
    end
end
% Adapted from Mike X. Cohen
inputDataSize = size(inputData);
numTimePts = max(inputDataSize);
if inputDataSize(1) > inputDataSize(2)
    transposeData = 1;
    inputData = inputData';
else
    transposeData = 0;
end

% mirror the input data
if mirrorFLAG
    mirrorData = [fliplr(inputData) inputData fliplr(inputData)];
else
    mirrorData = inputData;
end

% Band pass filter the data in this range
trans_width = 0.2;
nyquist = sampleRate/2;

filt_order = round(3*(sampleRate/bandRange(1)));
frequencies = [0 (1-trans_width)*bandRange(1) bandRange (1+trans_width)*bandRange(2) nyquist]/nyquist;

if ~isempty(find(frequencies > 1,1))
    trans_width = 0.1;
    frequencies = [0 (1-trans_width)*bandRange(1) bandRange (1+trans_width)*bandRange(2) nyquist]/nyquist;
end

idealresponse = [0 0 1 1 0 0 ];
filterweights = firls(filt_order,frequencies,idealresponse);
filtered_data = filtfilt(filterweights,1,double(mirrorData));
hilbertData = hilbert(filtered_data);

if mirrorFLAG
    hilbertData = hilbertData((numTimePts+1):(numTimePts*2));
end
if transposeData
    hilbertData = hilbertData';
end
if analyticSignalFLAG
    varargout{1} = hilbertData;
else
    freqPhase = angle(hilbertData);
    freqAmp = abs(hilbertData);
    varargout{1} = freqPhase;
    varargout{2} = freqAmp;
end