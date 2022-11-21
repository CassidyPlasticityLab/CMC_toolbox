%WILL NEED TO MAUALLY FLIP THE TOPO SO THAT THE STROKE IS ON THE Left SIDE
myDir = '/Volumes/CassidyLab/EMBARK/EEG/EMBARKOUTPUTGLOBAL/LA/Flip';
myFiles = dir(fullfile(myDir, '*.mat'));
for k = 1:length(myFiles)
    myDir = '/Volumes/CassidyLab/EMBARK/EEG/EMBARKOUTPUTGLOBAL/LA/Flip';
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    load(fullFileName, 'fd')

%     if fd.labelcmb{256, 1} == 'Left Extensor '
%         cfg.parameter        = 'cohspctrm';
%         cfg.xlim             = [1:3:4, 8:4:12 13:6:19 20:10:30];
%         cfg.zlim             = [0.02 0.06];
%         cfg.refchannel       = 'Left Extensor';
%         cfg.layout           = 'GSN-HydroCel-257.sfp';
%         figure; ft_topoplotER(cfg, fd);
%         photoName = strcat(fullFileName, '_Right_ED.tiff')
%         saveas(gcf, photoName)
% 
%         cfg.parameter        = 'cohspctrm';
%         cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30];
%         cfg.zlim             = [0.02 0.06];
%         cfg.refchannel       = 'Left Flexor';
%         cfg.layout           = 'GSN-HydroCel-257.sfp';
%         figure; ft_topoplotER(cfg, fd);
% 
%         photoName = strcat(fullFileName, '_Right_FD.tiff')
%         saveas(gcf, photoName)
% 
%         cfg.parameter        = 'cohspctrm';
%         cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30];
%         cfg.zlim             = [0.02 0.06];
%         cfg.refchannel       = 'Left Interossei';
%         cfg.layout           = 'GSN-HydroCel-257.sfp';
%         figure; ft_topoplotER(cfg, fd);
% 
%         photoName = strcat(fullFileName, '_Right_FDI.tiff')
%         saveas(gcf, photoName)
% 
%         cfg.parameter        = 'cohspctrm';
%         cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30];
%         cfg.zlim             = [0.02 0.06];
%         cfg.refchannel       = 'Left Biceps';
%         cfg.layout           = 'GSN-HydroCel-257.sfp';
%         figure; ft_topoplotER(cfg, fd);
% 
%         photoName = strcat(fullFileName, '_Right_BB.tiff')
%         saveas(gcf, photoName)
%     
%     else
        cfg                  = [];
        cfg.parameter        = 'cohspctrm';
        cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30];
        cfg.zlim             = [0.02 0.06];
        cfg.refchannel       = {'Left Extensor '};
        cfg.layout           = 'GSN-HydroCel-257.sfp';
        figure; ft_topoplotER(cfg, fd);
        photoName = strcat(fullFileName, '_Right_ED.tiff')
        saveas(gcf, photoName)

        cfg.parameter        = 'cohspctrm';
        cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30, 30:10:40, 40:10:50];
        cfg.zlim             = [0.02 0.06];
        cfg.refchannel       = {'Left Flexor '};
        cfg.layout           = 'GSN-HydroCel-257.sfp';
        figure; ft_topoplotER(cfg, fd);

        photoName = strcat(fullFileName, '_Right_FD.tiff')
        saveas(gcf, photoName)

        cfg.parameter        = 'cohspctrm';
        cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30, 30:10:40, 40:10:50];
        cfg.zlim             = [0.02 0.06];
        cfg.refchannel       = {'Left Interossei '};
        cfg.layout           = 'GSN-HydroCel-257.sfp';
        figure; ft_topoplotER(cfg, fd);

        photoName = strcat(fullFileName, '_Right_FDI.tiff')
        saveas(gcf, photoName)

        cfg.parameter        = 'cohspctrm';
        cfg.xlim             = [1:2:4, 8:4:12 13:6:19, 20:10:30, 30:10:40, 40:10:50];
        cfg.zlim             = [0.02 0.06];
        cfg.refchannel       = {'Left Biceps'};
        cfg.layout           = 'GSN-HydroCel-257.sfp';
        figure; ft_topoplotER(cfg, fd);

        photoName = strcat(fullFileName, '_Right_BB.tiff')
        saveas(gcf, photoName)


    end
%end