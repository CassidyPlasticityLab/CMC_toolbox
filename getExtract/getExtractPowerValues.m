function [relPow, relPowValsOneLine, relPowLabelOneLine] = getExtractPowerValues(freqRelPow, freqBands, EEG)

    % Load ROI information
    load ROI;

    % Average relative power across trials
    averagedTrialRelPow = squeeze(mean(freqRelPow.powspctrm, 1));
    trialRelPowChansAdded = add_deleted_chans(averagedTrialRelPow, EEG.chanlocs);

    % Frequency bands
    bandNames = fieldnames(freqBands);
    relPowData = struct();

    % Extract power for each frequency band
    for b = 1:length(bandNames)
        band = bandNames{b};
        freqIdx = round(freqRelPow.freq) >= freqBands.(band)(1) & round(freqRelPow.freq) <= freqBands.(band)(2);
        relPowData.(band) = trialRelPowChansAdded(:, freqIdx);
    end

    % Include all frequencies as a band
    relPowData.allFreq = trialRelPowChansAdded;

    % Calculate average relative power for each ROI and band
    relPow = struct();
    for roiIndex = 1:length(ROI)
        regionName = ROI{1, roiIndex};
        channelIndices = ROI{2, roiIndex};

        for b = 1:length(bandNames)
            band = bandNames{b};
            % Compute mean relative power for the ROI in this band
            relPow.(band).(regionName) = mean(mean(relPowData.(band)(channelIndices, :)));
        end

        % Compute mean relative power for all frequencies
        relPow.allFreq.(regionName) = mean(mean(relPowData.allFreq(channelIndices, :)));
    end

    % Linearize relative power values and labels
    fields_A = fieldnames(relPow);
    relPowValsOneLine = [];
    relPowLabelOneLine = {};

    for i = 1:length(fields_A)
        band = fields_A{i};
        fields_B = fieldnames(relPow.(band));
        for j = 1:length(fields_B)
            regionName = fields_B{j};
            % Append power values and labels
            relPowValsOneLine(end+1) = relPow.(band).(regionName);
            relPowLabelOneLine{end+1} = strcat(band, '_', regionName);
        end
    end
end