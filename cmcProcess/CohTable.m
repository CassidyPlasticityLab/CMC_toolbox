tic
myDir = '/Volumes/CassidyLab/EMBARK/EEG/Process';
myFiles = dir(fullfile(myDir, '*.mat'));

%Loops through each file of interest

for k = 1:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    load(fullFileName);

    CMCTable{k, :} = coh2LinesCAT{1, :};
    %CMCTable{1, l} = coh2Lines{1,l};
end




toc

clearvars -except IMCTable myFiles