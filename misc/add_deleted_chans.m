function [restored_data, restored_chanlocs] = add_deleted_chans(clean_data, chanlocs)
% this function takes the cleaned EEG data and the chanlocs struct from the
% eeglab EEG struct and adds in the channels that are deleted in the
% cleaning process
% inputs:
%   *clean_data - cleaned EEG data, expected dimensions of [chan, data,
%   epoch]
%   *chanlocs - EEG.chanlocs
% outputs:
%   *restored_data - cleaned EEG data that has been resized to 256 channels
%   *restored_chanlocs - restored chanlocs location data

% array containing the deleted channel numbers
deleted_chans = [67, 73, 82, 91, 92, 102, 103, 111, 112, 120, 121, 133, 134, 145, 146, 156, 165, 166, 174, 175, 187, 188, 199, 200, 208, 209, 216, 217, 218, 219, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256];

% num data points per epoch
data_size = size(clean_data, 2);
% num epochs
epoch_size = size(clean_data, 3);

restored_data=zeros(256, data_size, epoch_size);
restored_chanlocs = struct;

%loops through the channel numbers and adds them in
j = 1;
for i=1:256
    if isempty(intersect(deleted_chans,i))
        restored_data(i,:,:)=clean_data(j,:,:);
        
        for field=fieldnames(chanlocs)'
           %each field corresponds to an array of values
           restored_chanlocs(i).(field{1}) = chanlocs(j).(field{1}); 
        end
        
        j=j + 1;
    else
        % fill deleted channel data with zeros
        restored_data(i,:,:)=nan(1, data_size, epoch_size);
        
        % add in chan location info corresponding to deleted channel
        restored_chanlocs(i).labels = 'deleted';
        restored_chanlocs(i).description = [];
        % deleted chan locations are all at 0, 0, 0, which probably doesnt
        % reflect their actual locations, could be problematic when ploting
        % things
        restored_chanlocs(i).X = 0;
        restored_chanlocs(i).Y = 0;
        restored_chanlocs(i).Z = 0;
        restored_chanlocs(i).identifier = 0;
        restored_chanlocs(i).type = 'deleted';
        restored_chanlocs(i).ref = 'deleted';
        restored_chanlocs(i).sph_theta = 0;
        restored_chanlocs(i).sph_phi = 0;
        restored_chanlocs(i).sph_radius = 0;
        restored_chanlocs(i).radius = 0;
        restored_chanlocs(i).ur_chan = [];
    end
end 

end
