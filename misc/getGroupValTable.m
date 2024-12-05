%Little cheat sheet to extract the data for analysis
clear
dataPath = '/Volumes/CassidyLab/PersonalFolders_CassidyLabMembers/Jasper/HospitalStudyProcess/V1_SA/POW_COH_CMC';
fileList = dir(fullfile(dataPath, '**', '*.mat'));
addpath(dataPath)
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