function [cohSpctrm, coh, cohValsOneLine, cohLabelOneLine] = getExtractCohValues(fdFourierCoh, freqBands)
    load ROI;

    % Initialize structures for coherence spectra
    cohSpctrm = fdFourierCoh.cohspctrm;

    % Frequency bands
    bandNames = fieldnames(freqBands);
    bandData = struct();

    % Extract frequency bands using loops
    for b = 1:length(bandNames)
        band = bandNames{b};
        freqIdx = round(fdFourierCoh.freq) >= freqBands.(band)(1) & round(fdFourierCoh.freq) <= freqBands.(band)(2);
        bandData.(band) = squeeze(mean(cohSpctrm(:, :, freqIdx), 3));
        % Add deleted channels for square matrices
        bandData.(band) = add_deleted_chans_square_matrix(bandData.(band));
    end

    % Create regional coherence matrices
    region = struct();
    for roiIndex = 1:length(ROI) - 8
        regionName = ROI{1, roiIndex};
        for b = 1:length(bandNames)
            band = bandNames{b};
            region.(band).(regionName) = bandData.(band)(ROI{2, roiIndex}, :);
        end
    end

    % Calculate mean coherence between ROIs
    coh = struct();
    for regionIndex = 1:length(ROI) - 8
        regionName = ROI{1, regionIndex};
        for roiIndex = 1:length(ROI) - 8
            roiName = ROI{1, roiIndex};
            for b = 1:length(bandNames)
                band = bandNames{b};
                coh.(band).(regionName).(roiName) = ...
                    mean(mean(region.(band).(regionName)(:, ROI{2, roiIndex})));
            end
        end
    end

    % Linearize coherence values and labels
    fields_A = fieldnames(coh);
    cohValsOneLine = [];
    cohLabelOneLine = {};
    for i = 1:length(fields_A)
        band = fields_A{i};
        fields_B = fieldnames(coh.(band));
        for j = 1:length(fields_B)
            regionName = fields_B{j};
            fields_C = fieldnames(coh.(band).(regionName));
            for k = 1:length(fields_C)
                roiName = fields_C{k};
                cohValsOneLine(end+1) = coh.(band).(regionName).(roiName); % Append coherence value
                cohLabelOneLine{end+1} = strcat(band, '_', regionName, '_', roiName); % Append label
            end
        end
    end

end