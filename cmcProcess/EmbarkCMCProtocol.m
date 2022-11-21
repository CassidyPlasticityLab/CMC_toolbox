%This script computes coherence for the muscles of interest and every
%electrode.
%Please change the directory to the path containg the cmcProcessed
%files...the files in which an fd strucuture has been created.

%Change this directory to the path of interest
myDir = '/Volumes/CassidyLab/EMBARK/EEG/ProtocolCMC/';

%Grab each mat file in the path
myFiles = dir(fullfile(myDir, '*.mat'));

%Loops through each file of interest
for k = 16:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    tic
    load(fullFileName)

    %Directory to path containg the CMC processing scripts
    cd '/Users/jcassidy/Documents/MATLAB/CMC/';
    clear CMC coh meanCoh
    for i = 1:length(cohspctrm)
        load('wholeBrain.mat')

        coh{i}= getCoh(wholeBrain, 263, cohspctrm(i));
        meanCoh{i} = mean(coh{1, i});
        CMC(i) = mean(meanCoh{1, i}(58:88))
    end
end
clearvars -except fd CMC cohspctrm myDir myFiles baseFileName fullFileName;
cd '/Volumes/CassidyLab/EMBARK/EEG/ProtocolCMCOutput/'
save(baseFileName, 'CMC')
