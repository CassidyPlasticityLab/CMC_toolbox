%Classifies channel types. Takes in dataset from eeglab .set output

function [chanClass] = getChanClass(data)


col = size(data.chanlocs, 2);

%Get channel types and their respective rows
for i = 1:col
    if data.chanlocs(i).type == 'EEG'
        chanClass.EEGChans(i) = i;
        chanClass.EEGOriginalLabels{i} = data.chanlocs(i).labels;
    elseif data.chanlocs(i).type == 'PNS'
        chanClass.EMGChans(i) = i;
        chanClass.EMGChans( :, all(~chanClass.EMGChans,1) ) = [];
        chanClass.EMGLocs(i) = data.chanlocs(i);
    else
        chanClass.otherChans(i) =i;
        chanClass.otherChans( :, all(~chanClass.otherChans,1) ) = [];
        chanClass.otherChansLocs(i) = data.chanlocs(i);
    end

end
