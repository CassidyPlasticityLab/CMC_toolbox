function EEG = standardizeEEGElectrodes(EEG)
    % Extract electrode positions
    chanlocs = [EEG.chanlocs];
    positions = [[chanlocs.X]', [chanlocs.Y]', [chanlocs.Z]'];
    
    % Define tolerance threshold
    tol = 1e-3;
    
    % Identify electrodes in the left and right hemispheres
    leftIdx = find([chanlocs.Y] > tol);    % Strictly > 0 + tol → left hemisphere
    rightIdx = find([chanlocs.Y] < -tol);  % Strictly < 0 - tol → right hemisphere
    
    % Find mirrored pairs across the Y-axis
    matchedPairs = [];
    for i = 1:length(leftIdx)
        leftPos = positions(leftIdx(i), :);
        % Compare X and Z positions with tolerance, and check Y symmetry
        for j = 1:length(rightIdx)
            rightPos = positions(rightIdx(j), :);
            if abs(leftPos(2) + rightPos(2)) < tol && ... % Y-axis symmetry
               abs(leftPos(1) - rightPos(1)) < tol && ... % X-coordinate match
               abs(leftPos(3) - rightPos(3)) < tol        % Z-coordinate match
                matchedPairs = [matchedPairs; leftIdx(i), rightIdx(j)];
                break; % Exit loop once a match is found
            end
        end
    end
    
    % Verify matched electrode pairs
    disp('Matched electrode pairs across Y-axis:');
    for i = 1:size(matchedPairs, 1)
        fprintf('Left: %s ↔ Right: %s\n', EEG.chanlocs(matchedPairs(i, 1)).labels, ...
                                        EEG.chanlocs(matchedPairs(i, 2)).labels);
    end
    
    % Flip EEG data for mirrored pairs
    tempData = EEG.data; % Temporary copy of EEG data
    for i = 1:size(matchedPairs, 1)
        left = matchedPairs(i, 1);
        right = matchedPairs(i, 2);
        % Swap EEG data
        EEG.data([left, right], :, :) = tempData([right, left], :, :);
    end

    disp('EEG data successfully flipped to standardize lesion hemisphere.');
end
