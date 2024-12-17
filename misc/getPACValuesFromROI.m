function [PACValsOneLine, PACLabelOneLine] = getPACValuesFromROI(PAC, EEG)
    % Inputs:
    %   PAC: PAC values (256x1, corresponding to individual channels)
    %   ROI: Region of interest (ROI{1,:} contains ROI names, ROI{2,:} contains channel indices)
    load ROI
    PAC = add_deleted_chans(PAC, EEG.chanlocs);
    % Initialize outputs
    PACValsOneLine = [];
    PACLabelOneLine = {};
    
    % Loop through each ROI
    for roiIndex = 1:length(ROI)
        regionName = ROI{1, roiIndex}; % ROI name
        channelIndices = ROI{2, roiIndex}; % Indices of channels for this ROI
    
        % Validate indices (make sure they do not exceed PAC size)
        validIndices = channelIndices(channelIndices <= size(PAC, 1));
        if isempty(validIndices)
            warning(['No valid channels for ROI: ', regionName]);
            continue;
        end
    
        % Compute mean PAC value for the ROI
        meanPAC = mean(PAC(validIndices));
    
        % Append to one-line arrays
        PACValsOneLine(end+1) = meanPAC; % Add PAC value
        PACLabelOneLine{end+1} = regionName; % Add corresponding label
    end
end