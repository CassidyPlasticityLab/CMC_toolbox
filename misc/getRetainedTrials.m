function [retainedTrials, totalTrials] = getRetainedTrials(EEG)
    
    if contains(EEG.history, "pop_select( EEG, 'notrial',[")
        popSelectStr = "EEG = pop_select( EEG, 'notrial',[";
        k = strfind(EEG.history, popSelectStr);
        col = numel(k);
        rejectedEpochs = cell(1, col);
        
        for i = 1:col
            l = extractAfter(EEG.history, k(i) + strlength(popSelectStr) - 1);
            m = extractBefore(l, ']');
            rejectedEpochs{i} = str2num(m);
        end
        
        totalTrials = sum(cellfun(@numel, rejectedEpochs)) + numel(EEG.epoch);
        retainedTrials = 1:totalTrials;
        
        for i = 1:col
            retainedTrials = setdiff(retainedTrials, rejectedEpochs{i});
        end
    elseif contains(EEG.history, "pop_select( EEG, 'notrial',")
        popSelectStr = "EEG = pop_select( EEG, 'notrial',";
        k = strfind(EEG.history, popSelectStr);
        col = numel(k);
        rejectedEpochs = cell(1, col);
        
        for i = 1:col
            l = extractAfter(EEG.history, k(i) + strlength(popSelectStr) - 1);
            m = extractBefore(l, ']');
            rejectedEpochs{i} = str2num(m);
        end
        
        totalTrials = sum(cellfun(@numel, rejectedEpochs)) + numel(EEG.epoch);
        retainedTrials = 1:totalTrials;
        
        for i = 1:col
            retainedTrials = setdiff(retainedTrials, rejectedEpochs{i});
        end
    else
        retainedTrials = 1:size(EEG.data, 3);
        totalTrials = numel(retainedTrials);
    end
end
