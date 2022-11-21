%This script computes coherence for the muscles of interest and every
%electrode.
%Please change the directory to the path containg the cmcProcessed
%files...the files in which an fd strucuture has been created.

%Change this directory to the path of interest
myDir = '/Volumes/CassidyLab/EMBARK/EEG/Process';

%Grab each mat file in the path
myFiles = dir(fullfile(myDir, '*.mat'));

%Loops through each file of interest
for k = 15:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    tic
    load(fullFileName);

    %Directory to path containg the CMC processing scripts
     cd '/Users/jcassidy/Documents/MATLAB/CMC/';


    %Imports files containing locations of electrodes of interest
    load('regions.mat')
    load('wholeBrain.mat')
    load('leftBrain.mat')
    load('rightBrain.mat')

    clear coh

    %Computes coherence measures for each electrode as determined by lesion
    %hemisphere
    range = (size(regions, 2));
    if fd.lesion_side =='l'
        for j = 22:range
            coh{2, j-21} = getCoh(1:256, regions{2, j}, fd);
            coh{1, j-21} = regions{1, j};
        end


        %Create coherence value upper triangle matrix for right sided stroke
    else fd.lesion_side == 'r'
        for j = 22:range
            coh{2, j-21} = getCoh(1:256, regions{5, j}, fd);
            coh{1, j-21} = regions{1, j};
        end
    end

    %PlaceHolder VAleus for each Coherence substrucuture
    wholeBrainAverageCoh.delta = coh;
    wholeBrainAverageCoh.theta = coh;
    wholeBrainAverageCoh.alphaMu = coh;
    wholeBrainAverageCoh.beta1 = coh;
    wholeBrainAverageCoh.beta2 = coh;
    wholeBrainAverageCoh.gamma1 = coh;
    wholeBrainAverageCoh.gamma2 = coh;
    wholeBrainAverageCoh.allFreq = coh;


    leftBrainAverageCoh.delta = coh;
    leftBrainAverageCoh.theta = coh;
    leftBrainAverageCoh.alphaMu = coh;
    leftBrainAverageCoh.beta1 = coh;
    leftBrainAverageCoh.beta2 = coh;
    leftBrainAverageCoh.gamma1 = coh;
    leftBrainAverageCoh.gamma2 = coh;
    leftBrainAverageCoh.allFreq = coh;

    rightBrainAverageCoh.delta = coh;
    rightBrainAverageCoh.theta = coh;
    rightBrainAverageCoh.alphaMu = coh;
    rightBrainAverageCoh.beta1 = coh;
    rightBrainAverageCoh.beta2 = coh;
    rightBrainAverageCoh.gamma1 = coh;
    rightBrainAverageCoh.gamma2 = coh;
    rightBrainAverageCoh.allFreq = coh;

    %Computes average coherence measures for freq bands of itnerest
    for i =1:length(coh);

        wholeBrainAverageCoh.delta{2, i} = mean(mean(coh{2, i}(wholeBrain, 1:7))); % 1-3 Hz;;
        wholeBrainAverageCoh.theta{2, i} = mean(mean(coh{2, i}(wholeBrain, 10:16))); % 4-6 Hz;
        wholeBrainAverageCoh.alphaMu{2, i}  = mean(mean(coh{2, i}(wholeBrain, 22:34))); % 8-13 Hz;
        wholeBrainAverageCoh.beta1{2, i} = mean(mean(coh{2, i}(wholeBrain, 37:55))); % 13-19 Hz;;
        wholeBrainAverageCoh.beta2{2, i} = mean(mean(coh{2, i}(wholeBrain, 58:88))); % 20:30 Hz;
        wholeBrainAverageCoh.gamma1{2, i} = mean(mean(coh{2, i}(wholeBrain, 91:118))); % 31-40 Hz;
        wholeBrainAverageCoh.gamma2{2, i} = mean(mean(coh{2, i}(wholeBrain, 121:148))); % 41:50 Hz;
        wholeBrainAverageCoh.allFreq{2, i} = mean(mean(coh{2, i}(wholeBrain, 1:148))); % 1:50 Hz;;
    end


    for i =1:length(coh);

        leftBrainAverageCoh.delta{2, i} = mean(mean(coh{2, i}(leftBrain, 1:7))); % 1-3 Hz;;
        leftBrainAverageCoh.theta{2, i} = mean(mean(coh{2, i}(leftBrain, 10:16))); % 4-6 Hz;
        leftBrainAverageCoh.alphaMu{2, i}  = mean(mean(coh{2, i}(leftBrain, 22:34))); % 8-13 Hz;
        leftBrainAverageCoh.beta1{2, i} = mean(mean(coh{2, i}(leftBrain, 37:55))); % 13-19 Hz;;
        leftBrainAverageCoh.beta2{2, i} = mean(mean(coh{2, i}(leftBrain, 58:88))); % 20:30 Hz;
        leftBrainAverageCoh.gamma1{2, i} = mean(mean(coh{2, i}(leftBrain, 91:118))); % 31-40 Hz;
        leftBrainAverageCoh.gamma2{2, i} = mean(mean(coh{2, i}(leftBrain, 121:148))); % 41:50 Hz;
        leftBrainAverageCoh.allFreq{2, i} = mean(mean(coh{2, i}(leftBrain, 1:148))); % 1:50 Hz;;
    end

    for i =1:length(coh);

        rightBrainAverageCoh.delta{2, i} = mean(mean(coh{2, i}(rightBrain, 1:7))); % 1-3 Hz;;
        rightBrainAverageCoh.theta{2, i} = mean(mean(coh{2, i}(rightBrain, 10:16))); % 4-6 Hz;
        rightBrainAverageCoh.alphaMu{2, i}  = mean(mean(coh{2, i}(rightBrain, 22:34))); % 8-13 Hz;
        rightBrainAverageCoh.beta1{2, i} = mean(mean(coh{2, i}(rightBrain, 37:55))); % 13-19 Hz;;
        rightBrainAverageCoh.beta2{2, i} = mean(mean(coh{2, i}(rightBrain, 58:88))); % 20:30 Hz;
        rightBrainAverageCoh.gamma1{2, i} = mean(mean(coh{2, i}(rightBrain, 91:118))); % 31-40 Hz;
        rightBrainAverageCoh.gamma2{2, i} = mean(mean(coh{2, i}(rightBrain, 121:148))); % 41:50 Hz;
        rightBrainAverageCoh.allFreq{2, i} = mean(mean(coh{2, i}(rightBrain, 1:148))); % 1:50 Hz;;
    end
   

    toc

    turnGlobalCoh2Lines;
    cd '/Users/jcassidy/Documents/MATLAB/CMC/EMBARKOUTPUTGLOBAL/'
    save(fd.SUBJ_ID)
end