%Process the data normally while in EEGlab
%Follow EEG Preprocessing SOP for more information

%Load the file from eeglab into fieldtrip
eeglab EEGPRAC_1
[EEG] = eeglab2fieldtrip(EEG, 'preprocessing', 'none')