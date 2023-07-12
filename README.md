Relative Power, Cortical-cortical, and Corticomusuclar Coherence toolbox
===========================

Includes processing scripts for analysis of EEG and/or EEG/EMG data. Requires 
data to be processed in EEGLAB (<https://sccn.ucsd.edu/eeglab/download.php>)

Calls on both functions from EEGLAB and FIELDTRIP (<https://www.fieldtriptoolbox.org/download.php>).
For convenience they have been added in the plugin folder.

This toolbox currently supports EGI 256 lead Hydrocel caps.

Prior to Running
-------------
Modify the configToolbox.m script with the appropriate information.

This includes:
       [1] the path where the data is stored
       [2] whether there is PNS input (EMG/ECG data)
       [3] whether the data is stroke or healthy control
       [4] channels removed from the dataset during processing
       [5] whether to hilbert transform the data
       [6] whether to rectify the data
       [7] whether affected (or right) or less affected (or left) extremity
       [8] stroke type (cortical/cerebellar)
       [9] trial computation window start time
       [10] trial computation window end time
       [11] extremity label value in the file name
       [12] frequency bands ranges
       [13] desired outputs

Modify the ROI.mat file accordingly, with the first row including labels
and the following containing the corresponding electrodes of interest.

To Run
-------------
Below are the steps to run the toolbox:
       [1] Add the toolbox to your path.
       [2] Open the folder you would like the outputs to be saved in
       [3] run main.m or enter main in the command line.

Outputs
-------------
The following outputs are:
       [1] cohSpctrm: a 3D matrix containing coherence data (Chan X Chan X Freq [0.33 increments starting at 1])
       [2] cohValsOneLine: A 1XN array containing coherence values
       [3] cohLabelOneLine: A 1XN array containing coherence label strings
       [4] CMCSpctrm: a 3D matrix containing CMC data (Chan X Chan X Freq [0.33 increments starting at 1])
       [5] CMCValsOneLine: A 1XN array containing CMC values
       [6] CMCLabelOneLine: A 1XN array containing CMC label strings
       [7] relPowSpctrm: a 3D matrix containing CMC data (Chan X Chan X Freq [0.33 increments starting at 1])
       [8] relPowValsOneLine: A 1XN array containing CMC values
       [8] relPowLabelOneLine: A 1XN array containing CMC label strings
       [9] retainedTrials: 1XN array defining which epochs are retained after preprocessing
       [10] totalTrials: A single number defining how many EPOCHS were performed during task data

