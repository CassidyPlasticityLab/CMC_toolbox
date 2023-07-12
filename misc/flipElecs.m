
function [EEG] = flipElecs(EEG, lesionSide, affectedExtremity, strokeType, chanClass)

if nargin < 1
    error('input_example :  EEG and lesionSide are required')
end


%Flip Electrodes
if lesionSide == 'r'
    if strokeType == 'cort'
        for i = 1:size(EEG.chanlocs, 2)
            EEG.chanlocs(i).Y = EEG.chanlocs(i).Y*(-1);
            EEG.chanlocs(i).theta = EEG.chanlocs(i).theta*(-1);
            EEG.chanlocs(i).sph_theta_besa = EEG.chanlocs(i).sph_theta_besa*(-1);
        end
    end
end


if nargin > 2
    col = size(chanClass.EMGChans, 2);
    if affectedExtremity == 'l'
        half = ceil(numel(chanClass.EMGChans)/2);
        newOrder = horzcat(chanClass.EMGChans(half+1:end), chanClass.EMGChans(1:half));
        tempData = EEG.data;
        for i = 1:col
            EEG.data(chanClass.EMGChans(i), :, :) = tempData(newOrder(i),:, :);
        end
    end
end
end

