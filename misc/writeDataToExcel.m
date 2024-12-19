% Helper function to write data to Excel
function writeDataToExcel(fileName, filenames, labels, data)
    % Combine filenames, labels, and data
    combinedLabels = ['Filename', labels]; % Add 'Filename' as the first header
    combinedData = [filenames, num2cell(data)]; % Prepend filenames to data
    % Write to Excel
    writecell([combinedLabels; combinedData], fileName);
    fprintf('Saved: %s\n', fileName);
end