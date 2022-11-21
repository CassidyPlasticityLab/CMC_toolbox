myDir = '/Volumes/CassidyLab/HOSPITAL_STUDY_DATA/EEG/cmc_data';
myFiles = dir(fullfile(myDir, '*.mat'));
for k = 1:length(myFiles)
    myDir = '/Volumes/CassidyLab/HOSPITAL_STUDY_DATA/EEG/cmc_data';
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    load(fullFileName, 'coh')
    myFiles(k).LED = coh{2, 1};
    myFiles(k).RED = coh{2, 2};
    myFiles(k).LFD = coh{2, 3};
    myFiles(k).RFD = coh{2, 4};
    myFiles(k).LFDI = coh{2, 5};
    myFiles(k).RFDI = coh{2, 6};
    myFiles(k).LBB = coh{2, 7}; 
    myFiles(k).RBB = coh{2, 8};

    myFiles(k).meanLED = nanmean(myFiles(k).LED);
    myFiles(k).meanRED = nanmean(myFiles(k).RED);
    myFiles(k).meanLFD = nanmean(myFiles(k).LFD);
    myFiles(k).meanRFD = nanmean(myFiles(k).RFD);
    myFiles(k).meanLFDI = nanmean(myFiles(k).LFDI);
    myFiles(k).meanRFDI = nanmean(myFiles(k).RFDI);
    myFiles(k).meanLBB = nanmean(myFiles(k).LBB);
    myFiles(k).meanRBB = nanmean(myFiles(k).RBB);

    myFiles(k).latHemLED = myFiles(k).LED(rightBrain, :);
    myFiles(k).latHemRED = myFiles(k).RED(leftBrain, :);
    myFiles(k).latHemLFD = myFiles(k).LFD(rightBrain, :);
    myFiles(k).latHemRFD = myFiles(k).RFD(leftBrain, :);
    myFiles(k).latHemLFDI = myFiles(k).LFDI(rightBrain, :);
    myFiles(k).latHemRFDI = myFiles(k).RFDI(leftBrain, :);
    myFiles(k).latHemLBB = myFiles(k).LBB(rightBrain, :);
    myFiles(k).latHemRBB = myFiles(k).RBB(leftBrain, :);

    myFiles(k).meanLatHemLED = nanmean(myFiles(k).latHemLED);
    myFiles(k).meanLatHemRED = nanmean(myFiles(k).latHemRED);
    myFiles(k).meanLatHemLFD = nanmean(myFiles(k).latHemLFD);
    myFiles(k).meanLatHemRFD = nanmean(myFiles(k).latHemRFD);
    myFiles(k).meanLatHemLFDI = nanmean(myFiles(k).latHemLFDI);
    myFiles(k).meanLatHemRFDI = nanmean(myFiles(k).latHemRFDI);
    myFiles(k).meanLatHemLBB = nanmean(myFiles(k).latHemLBB);
    myFiles(k).meanLatHemRBB = nanmean(myFiles(k).latHemRBB);

    myFiles(k).ipsiHemLED = myFiles(k).LED(leftBrain, :);
    myFiles(k).ipsiHemRED = myFiles(k).RED(rightBrain, :);
    myFiles(k).ipsiHemLFD = myFiles(k).LFD(leftBrain, :);
    myFiles(k).ipsiHemRFD = myFiles(k).RFD(rightBrain, :); 
    myFiles(k).ipsiHemLFDI = myFiles(k).LFDI(leftBrain, :);
    myFiles(k).ipsiHemRFDI = myFiles(k).RFDI(rightBrain, :);
    myFiles(k).ipsiHemLBB = myFiles(k).LBB(leftBrain, :);
    myFiles(k).ipsiHemRBB = myFiles(k).RBB(rightBrain, :);     

    myFiles(k).meanIpsiHemLED = nanmean(myFiles(k).ipsiHemLED);
    myFiles(k).meanIpsiHemRED = nanmean(myFiles(k).ipsiHemRED);
    myFiles(k).meanIpsiHemLFD = nanmean(myFiles(k).ipsiHemLFD);
    myFiles(k).meanIpsiHemRFD = nanmean(myFiles(k).ipsiHemRFD);
    myFiles(k).meanIpsiHemLFDI = nanmean(myFiles(k).ipsiHemLFDI);
    myFiles(k).meanIpsiHemRFDI = nanmean(myFiles(k).ipsiHemRFDI);
    myFiles(k).meanIpsiHemLBB = nanmean(myFiles(k).ipsiHemLBB);
    myFiles(k).meanIpsiHemRBB = nanmean(myFiles(k).ipsiHemRBB);
end

