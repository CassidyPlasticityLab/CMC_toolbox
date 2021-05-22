tic
%load fd
load('regions.mat')
import cohAllReg.*
import getCoh.*
coh = {};

parpool('local', maxNumCompThreads);

coh.cohSquare = cohAllReg(regions, fd);

%Create a matrix with the corresponding labels. The raw values will be overwritten 
coh.delta = coh.cohSquare;
coh.theta = coh.cohSquare;
coh.alphaMu = coh.cohSquare;
coh.beta1 = coh.cohSquare;
coh.beta2 = coh.cohSquare;
coh.gamma1 = coh.cohSquare;
coh.gamma2 = coh.cohSquare;
coh.allFreq = coh.cohSquare;


%Create mean coherence matrix all frequency bands 
for i = 2:size(coh.cohSquare, 2)
    for j =2:size(coh.cohSquare, 2)
        if i < j
            coh.delta{i, j} =mean(mean(coh.cohSquare{i, j}(:, 1:7))); % 1-3 Hz
            coh.theta{i, j} =mean(mean(coh.cohSquare{i, j}(:, 10:16))); % 4-6 Hz
            coh.alphaMu{i, j} =mean(mean(coh.cohSquare{i, j}(:, 22:34))); % 8-13 Hz
            coh.beta1{i, j} =mean(mean(coh.cohSquare{i, j}(:, 37:55))); % 13-19 Hz
            coh.beta2{i, j} =mean(mean(coh.cohSquare{i, j}(:, 58:88))); % 20-30 Hz
            coh.gamma1{i, j} =mean(mean(coh.cohSquare{i, j}(:, 91:118))); % 31-40 Hz
            coh.gamma2{i, j} =mean(mean(coh.cohSquare{i, j}(:, 121:148))); % 41-50 Hz
            coh.allFreq{i, j} =mean(mean(coh.cohSquare{i, j}(:, 1:148))); % 1-50 Hz            
        elseif i == j
            coh.delta{i, j} = 1;
            coh.theta{i, j} = 1;
            coh.alphaMu{i, j} = 1;
            coh.beta1{i, j} = 1;
            coh.beta2{i, j} = 1;
            coh.gamma1{i, j} = 1;
            coh.gamma2{i, j} = 1;
            coh.allFreq{i, j} = 1;
        end
    end
end

coh2Lines = turnCoh2Lines(coh);

cmcLatIndex = getCMCLatIndex(coh2Lines)

s1 = '/Users/jcassidy/Documents/MATLAB/CMC/data/';
pathName = strcat(s1, fd.SUBJ_ID);
mkdir (pathName);
cd (pathName);
clearvars -except fd coh data coh2Lines;
save;
newName = strcat(fd.SUBJ_ID, '.mat');
movefile('matlab.mat', newName);
clear newName;
toc;
delete(gcp('nocreate'));

