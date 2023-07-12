%Little cheat sheet to extract the data for analysis
clear
dataPath = '/Volumes/CassidyLab/EEG_CognitiveMotor_Study/Data/EEG/Young/final/Left/CMC_POW_COH';
fileList = dir(fullfile(dataPath, '**', '*.mat'));

for i = 1:length(fileList)
load(fileList(i).name, 'CMCLabelOneLine', 'CMCValsOneLine', 'cohLabelOneLine', 'cohValsOneLine', 'relPowLabelOneLine', 'relPowValsOneLine')
fileList(i).CMC_Vals = CMCValsOneLine;
fileList(i).CMC_Labels = CMCLabelOneLine;
fileList(i).COH_Vals = cohValsOneLine;
fileList(i).COH_Labels = cohLabelOneLine;
fileList(i).POW_Vals = relPowValsOneLine;
fileList(i).POW_Labels = relPowLabelOneLine;
end

for i = 1:length(fileList)
    CMCGroup(i, :) = fileList(i).CMC_Vals;
    COHGroup(i, :) = fileList(i).COH_Vals;
    POWGroup(i, :) = fileList(i).POW_Vals;
end

save('groupOutput', 'CMCGroup', 'COHGroup', 'POWGroup', 'fileList')