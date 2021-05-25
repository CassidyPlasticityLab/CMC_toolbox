4%--------------------------------------------
% getCoh
%
% params:
%   region1, array of electrodes that make up region of interest
%   region2, array of electrodes that make up region of interest
%   freqBands is optional, default returns all
% Delta band is 1-3 Hz | fd.freq(1):fd.Freq(7)
% Theta band is 4-6 Hz | fd.freq(10):fd.Freq(16)
% Alpha mu band is 8-12 Hz | fd.freq(22):fd.Freq(34)
% Beta 1 is 13-19 Hz | fd.freq(37):fd.Freq(55)
% Beta 2 band is 20-30 Hz | fd.freq(58):fd.Freq(88)
% Gamma 1 is 31-40 Hz | fd.freq(91):fd.Freq(118)
% Gamma 2 is 41-50 Hz | fd.freq(121):fd.Freq(148)
%   fd, data structure providewd by fieldtrip toolbox
%
% return:
%    coherence of regions for given frequency bands
%--------------------------------------------

function coh = getCoh(region1, region2, fd)
coh = []; % return value
sameElcCount = 0; % count number of duplicate electrode between the regions
allPairs = []; % all the possible pairings for the regions
comPair = []; % all pairings for the regions excluding repeats
interestingRows = []; % displays rows of interest that correspond with the elc pairs and coherence row in fd.cohspctrm

% If regions are the same, coherence across region is 1
if size(region1) == size(region2)
    if region1 == region2
        coh = 1;
        return
    end
end

% Create and order all possible electrode pairs
for r1 = 1:numel(region1)
    for r2 = 1:numel(region2)
        
        % Count number of duplicate electrode pairs | not adding (x,x) to pairings
        if (region1(r1) == region2(r2))
            sameElcCount = sameElcCount + 1;
            
            % Order electrode pair so the smaller number is placed in column 1 of all piars
        elseif (region1(r1) > region2(r2))
            allPairs((end+1), 1) = region2(r2);
            allPairs(end, 2) = region1(r1);
            
        else
            allPairs((end+1),1) = region1(r1);
            allPairs(end, 2) = region2(r2);
            
        end
        
    end
end

%while loop instead
% % Remove duplicate pairs from set of possible pairings
for i = 1:size(allPairs, 1)
    % save current electrode set
    currentPair = (allPairs(i,:));
    % Compare currentPair with following pairs
    for j = (i+1):size(allPairs, 1)
        % remove duplicates of currentPair
        if currentPair == allPairs(j)
            allPairs(j) = [];
        end
    end
end

% Remove duplicate elc pairs
comPair = unique(allPairs, 'rows');

% Get the row number that corresponds with each elc pair
for z = 1:size(comPair, 1)
    % Run through equation that gets the corresponding row number
    % ((summation base i = 2 to x of (264 - i)) + (y -1)) where (x, y) is
    % (E1, E2)
    syms i;
    rowNum(comPair(z, 1),comPair(z, 2)) = symsum(264-i, i, 2, comPair(z, 1)) + comPair(z, 2) - 1;
    interestingRows(z) = rowNum((comPair(z, 1)),comPair(z, 2));
end

% Get the coherence values for each electrode pairing
coh = fd.cohspctrm(interestingRows, :);

% Add in row of 1's for coherence between the same electrodes
coh((end + (1:sameElcCount)), :) = ones;
end

