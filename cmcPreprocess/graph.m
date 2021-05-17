%WILL NEED TO MAUALLY FLIP THE TOPO SO THAT THE STROKE IS ON THE LEFT SIDE

cfg = [];
cfg.parameter        = 'cohspctrm';
cfg.xlim             = [4 13];     
cfg.zlim             = [0 0.08];
cfg.refchannel       = 263;
cfg.layout           = 'GSN-HydroCel-257.sfp';
figure; ft_topoplotER(cfg, Squeeze.Raw.fd)

cfg = [];
cfg.parameter        = 'cohspctrm';
cfg.xlim             = [8:5:13 13:6:19 20:10:30];
%cfg.zlim             = [0 0.06];
cfg.refchannel       = 263;
cfg.layout           = 'GSN-HydroCel-257.sfp';
%cfg.colorbar         = 'yes'
figure; ft_topoplotER(cfg, Squeeze.Raw.fd);


cfg                  = [];
cfg.parameter        = 'cohspctrm';
cfg.xlim             = [5 80];
cfg.refchannel       = 257;
cfg.layout           = 'GSN-HydroCel-257.sfp';
cfg.showlabels       = 'yes';
figure; ft_multiplotER(cfg, Squeeze.Raw.fd)

% Delta band is 1-3 Hz | fd.freq(1):fd.Freq(7)
% Theta band is 4-6 Hz | fd.freq(10):fd.Freq(16)
% Alpha mu band is 8-12 Hz | fd.freq(22):fd.Freq(34)
% Beta 1 is 13-19 Hz | fd.freq(37):fd.Freq(55)
% Beta 2 band is 20-30 Hz | fd.freq(58):fd.Freq(88)
% Gamma 1 is 31-40 Hz | fd.freq(91):fd.Freq(118)
% Gamma 2 is 41-50 Hz | fd.freq(121):fd.Freq(148)

% % Left Muscles
% left_extensor = 257;
% left_flexor = 258;
% left_interossei = 259;
% left_biceps = 260;
% 
% %Right Muscles
% right_extensor = 261;
% right_flexor = 262;
% right_interossei = 263;
% right_biceps = 264;
