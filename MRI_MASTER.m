%% Setup directory and change input
%Define Path. The only user input to change is the mri_file, eeg_file, and
%the data_path
mri_file = 'S002_T1.nii';
eeg_file = 'S002_v2_Resting_final.set';
data_path = '/Users/jcassidy/Desktop';
eeg_path = fullfile(data_path, eeg_file);
mri_path = fullfile(data_path, mri_file);
freqInterest = 10; %Change to value of interest
%elec = ft_read_sens(fullfile(data_path, eeg_file), 'senstype', 'eeg');

ft_defaults;

%% Work with the MRI and create head model (
%Load in the MRI and define the coordinate system of the MRI
mri = ft_read_mri(mri_path);
mri_coordsys = ft_determine_coordsys(mri);
%enter y, r, a, s, a

%reslice mri
%mri_coordsys_cm = ft_convert_units(mri_coordsys, 'cm');
mri_reslice = ft_volumereslice([], mri_coordsys);

%Segment the MRI into the brain, skull and scalp
cfg           = [];
cfg.output    = {'brain','skull','scalp'};
segmentedmri  = ft_volumesegment(cfg, mri_reslice);

%Create a triangulated surface mesh volume that can be used as a
%geometrical description  for a voume conduction model
cfg=[];
cfg.tissue={'brain','skull','scalp'};
cfg.numvertices = [3000 2000 350]; 
mesh=ft_prepare_mesh(cfg,segmentedmri);

% Create a volume conduction model. 
cfg        = [];
cfg.method ='bemcp'; 
vol        = ft_prepare_headmodel(cfg, mesh);

%Check the plots of the images together and make sure everything looks okay
figure;
ft_plot_mesh(vol.bnd(1), 'facecolor','brain', 'facealpha', 0.5); %Brain model
hold on;
ft_plot_mesh(vol.bnd(2),'facecolor','black','facealpha',0.3); %Skull model
hold on;
ft_plot_mesh(vol.bnd(3),'facecolor','skin','facealpha', .2); %Head model

%% Align the electrodes
%Load in the EEG template file for an EGI 256 lead cap
EEG = pop_loadset; %(eeg_file);
data = eeglab2fieldtrip(EEG, 'preprocessing', 'none');
data.elec.type = 'egi256';
elec_mm = ft_convert_units(data.elec, 'mm');

elec = ft_read_sens(eeg_path, 'senstype', 'eeg');
elec.type = 'egi256';
elec_mm = ft_convert_units(elec, 'mm');

%Check the alignment of the two. Will likely need to realign
figure;
% head surface (scalp)
ft_plot_mesh(vol.bnd(3), 'facealpha',1, 'facecolor', 'skin');
hold on;
% electrodes
ft_plot_sens(elec_mm);


%Interactively realign the electrodes to the MRI. 
cfg           = [];
cfg.method    = 'interactive';
cfg.elec      = elec_mm;
cfg.headshape = vol.bnd(3);
elecAligned  = ft_electroderealign(cfg);
elecAligned.type = 'egi256';
%Need to divide the last oclumn by 10 i.e. (6 -> 0.6)
%For S003, {20, -7, 83 ; 1, 1, 1 ; .6, -.7, .7}

%Double check the alignment went well
figure;
% head surface (scalp)
ft_plot_mesh(vol.bnd(3), 'facealpha', 1, 'facecolor', 'skin');
hold on;
% electrodes
ft_plot_sens(elecAligned);

%COnvert Units to centimeter
vol_cm = ft_convert_units(vol, 'cm');
elec_cm = ft_convert_units(elecAligned, 'cm')
data.elec = elec_cm;

%% Process EEG data
%Compute power spectrum and cross power spectrum
cfg            = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.taper = 'dpss';
cfg.foi     = [1 50];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
freq           = ft_freqanalysis(cfg, data);


%% Create Leadfield
cfg                  = [];
cfg.elec             = data.elec;
cfg.headmodel        = vol_cm;
cfg.normalize        = 'yes'; %comment out to not eliminate for center bias of mri source loc
cfg.resolution       = 1;   
cfg.unit = 'cm';
leadfield = ft_prepare_leadfield(cfg);

%Visualize everything together and make sure it is all aligned
figure; hold on     % plot all objects in one figure
ft_plot_headmodel(vol_cm, 'facealpha', .1)
ft_plot_mesh(leadfield.pos(leadfield.inside,:), 'vertexcolor', 'r');
ft_plot_sens(data.elec);

%% Source Anaylsis
%Perfrom beamfoermer dipole analysis on EEG data freq analysis
cfg                 = [];
cfg.method          = 'dics'; %Dynamic imaging of coherent sources
cfg.headmodel       = vol_cm;
cfg.sourcemodel     = leadfield;
cfg.elec = data.elec;
cfg.frequency = freqInterest
cfg.lambda       = '5%'; %Change lambda to assess for rank deficiency due to amount of trials
cfg.dics.projectnoise = 'yes'; % also make an estimate of the noise distribution
source      = ft_sourceanalysis(cfg, freq);

%Interpolate source activity onto the MRI
cfg              = [];
cfg.parameter    = 'pow';
source_int   = ft_sourceinterpolate(cfg, source, mri_reslice);

%Visualize the source localization plot
cfg               = [];
cfg.method        = 'slice'; %can change to 'ortho'
cfg.frequency     = freqInterest,
cfg.funparameter  = 'pow';
cfg.maskparameter = 'pow';
cfg.opacitymap    = 'rampup';
ft_sourceplot(cfg, source_int);



