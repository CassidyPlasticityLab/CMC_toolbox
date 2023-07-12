function [retainedTrials, totalTrials] = getRetainedTrials(EEG)

if contains(EEG.history, "pop_select( EEG, 'notrial',[")
    %Specific trial number saved
    popSelectStr = "EEG = pop_select( EEG, 'notrial',[";
    k = strfind(EEG.history, popSelectStr);
    col = size(k, 2);
    for i =1:col
        l{i} = extractAfter(EEG.history, k(i)+strlength(popSelectStr)-1);
        m{i} = extractBefore(l{i}, ']');
        rejectedEpochs{i} = str2num(m{1, i});
    end
    
    for i = 1:length(rejectedEpochs)
        totalTrials(i) = length(rejectedEpochs{1, i});
    end
    
    totalTrials = sum(totalTrials)+length(EEG.epoch);
    
    retainedTrials = [1:totalTrials];
    col = size(rejectedEpochs, 2);
    for i = 1:col
        retainedTrials(rejectedEpochs{1, i}(1, :)) = [];
    end
else 
    retainedTrials = 1:size(EEG.data, 3);
    totalTrials = size(EEG.data, 3)
end
end