function [restored_data] = add_deleted_chans_square_matrix(clean_data)
% this function takes the cleaned EEG data and the chanlocs struct from the

deleted_chans = [67, 73, 82, 91, 92, 102, 103, 111, 112, 120, 121, 133, 134, 145, 146, 156, 165, 166, 174, 175, 187, 188, 199, 200, 208, 209, 216, 217, 218, 219, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256];


% Determine the number of rows and columns in the restored data matrix
num_rows = (numel(deleted_chans) + size(clean_data, 1));
num_cols = num_rows;

% Reshape the clean_data matrix to match the restored data dimensions
clean_data_reshaped = reshape(clean_data, size(clean_data, 1), []);

% Initialize the restored data matrix
restored_data = zeros(num_rows, num_cols);

% Loop through the channel numbers and add them to the restored data matrix
j = 1;
for i = 1:num_rows
    for k = 1:num_cols
        if ~ismember(i, deleted_chans) && ~ismember(k, deleted_chans)
            restored_data(i, k) = clean_data_reshaped(j);
            j = j + 1;
        end
    end
end
end

