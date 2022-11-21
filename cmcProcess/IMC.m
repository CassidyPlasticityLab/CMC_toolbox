tic
myDir = '/Volumes/CassidyLab/HOSPITAL_STUDY_DATA/EEG/cmc_data';
myFiles = dir(fullfile(myDir, '*.mat'));

%Loops through each file of interest

for k = 1:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    load(fullFileName);

    clear IMC2Lines

%     if exist('IMC2Lines') >= 1
%         for l = 1:length(IMC2Lines)
%             IMCTable{k+1, l} = IMC2Lines{2, l};
%             IMCTable{1, l} = IMC2Lines{1,l};
%         end
%     else
        IMC2Lines = turnIMC2Lines(coh);
        IMC2Lines = horzcat(IMC2Lines.delta, IMC2Lines.theta, IMC2Lines.alphaMu, IMC2Lines.beta1, IMC2Lines.beta2, IMC2Lines.gamma1, IMC2Lines.gamma2);
        for l = 1:length(IMC2Lines)
            IMCTable{k+1, l} = IMC2Lines{2, l};
            IMCTable{1, l} = IMC2Lines{1,l};
        end
    %end
    

end

toc

clearvars -except IMCTable myFiles