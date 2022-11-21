% Determines coherence for a given frequency band at each electrode

% freq : frequency band of interest
% samplingRate : acquisition sampling rate -- Note : generally @ 1000 Hz
function [ coh,freqcor,frequencies ] = coherence( epoched_data,freq,samplingRate )
maxFreq = 100;                                  % save data up to 100 Hz
nEpochs = size(epoched_data,1);
epochLength = size(epoched_data,2);
nChan = size(epoched_data,3); 
T = epochLength/samplingRate;
df = 1/T;
nFreqs = maxFreq/df + 1;                        % number of frequencies to keep
frequencies = 0:df:df*(nFreqs-1);

ffttemp = fft(epoched_data,[],2)/epochLength;   % FFT over the 2nd dimension

freqPower = zeros(nFreqs,nChan);
coh = zeros(nFreqs,nChan,nChan);
freqcor = zeros(nFreqs,nChan,nChan);
relphase = zeros(nFreqs,nChan,nChan);

for j = 1:nFreqs;
  freqData = squeeze(ffttemp(:,j,:));           % epochs x channels
  freqPower(j,:) = 2*epochLength*var(freqData); % normalize by epoch length because MATLAB fft gives power spectrum in data-units^2/bin
  freqcor(j,:,:) = corrcoef(freqData);
  freqPower(j,:) = 2*epochLength*var(freqData); % normalize by epoch length because MATLAB fft gives power spectrum in data-units^2/bin

end;

coh = abs(freqcor).^2;
relphase = angle(freqcor);

coh=coh(min(freq)+1:max(freq)+1,:,:);           % keep frequencies of interest 
freqcor=freqcor(min(freq)+1:max(freq)+1,:,:);   % keep frequencies of interest
relphase=relphase(min(freq)+1:max(freq)+1,:,:);           
frequencies=frequencies(1,min(freq)+1:max(freq)+1);
end

% Author: Jennifer Wu, February 2012
% Adapted from script by : Ramesh Srinivasan
% Last debug: Jennifer Wu, 07-27/2012