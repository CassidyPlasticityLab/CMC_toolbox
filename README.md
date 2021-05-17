CMC Data processing toolbox
===========================

Includes both preprocessing and processing scripts for Corticomuscular 
Coherence data collected via EGI Geodesic EEG/EMG system. Requires download 
of EEGLAB <https://sccn.ucsd.edu/eeglab/download.php> and the fieldtrip 
toolbox <https://www.fieldtriptoolbox.org/download.php>.

cmcPreprocess
-------------
Preprocesses, isolates signals, and concatenates the EEG and EMG portions 
of corticomusuclar coherence (CMC) data. To run enter cmcPreprocess into 
the command window.

Before running, make sure EEGLAB and fieldtrip are added to the path.
The user must upload the raw .mff file collected from egi netstation to the 
'current folder' and add it to the path. Other inputs include the processed 
.mat file from eeglab, a list of theepochs removed from the EEG set in 
matlab (before and after ICA), the subject ID, and the lesion hemisphere.

OutPut includes structures:
freq - power spectrum and cross spectrum
fd - coherence spectrum
data - data / trial information

cmcProcess
----------
Processing the CMC data and computes a coherence matrix for all regions of
interest (ROI) across all frequency bands. 

Regions of interest are defined in regions.mat. Can be changed as needed. 
Due to flipping the data to standardize the lesion to the left hemisphere, 
the flipped ROI label and electrode array must be placed under the 
corresponding ROI.

Requires user to upload the fd.mat file created during the above steps to
the 'current folder'. To run enter main into the command window after 
ensuring that the cmcProcess folder is added to the pathway.

Output:
coh -  A structure containing multiple matrices including the raw coherence 
       data for each region across all frequency bands as well as the
       single coherence value matrix for each region at their respective
       frequency bands. This is saved in a newly created folder in the path
       CMC/data/<SUBJ.ID> 

--------------------------------------------------------------------------

Trouble Shoot

During the preprocessing steps four things may go wrong. Don't stress, it 
happens to all of us. Here are some simple resolutions.

Case 1. You can't load in the raw .mff file

        First, don't get upset, I know reading the README file can be a lot
        but there is some really nice information here. For example, make 
        sure to reread line 15 and 16. The .mff file must be in the current
        folder that you are working in AND added to the path.

Case 2. The EEG and EMG cannot be concatenated after inputing the epochs 
        removed (before and after ICA)

        I wish I could help you here. It seems like someone didn't properly
        record which epochs were removed in their excel sheet or notebook.
        Double check that you didn't include any duplicates, otherwise you
        have to start from ground zero. I wish I had better news.

Case 3. The trial timings are wack. 

        After the trials created double check the command window and make 
        sure that each trial before the final 3 second segmentation ranged 
        from 4-6 seconds. If you had some that  were 13 seconds or 2, 
        something went wrong. This occurs when the event information was 
        a) not properly transfered over from EGI, or b) someone missed a 
        part of a trial during the recording session. Worry not! This is a 
        tedious, but easy fix. Scroll through the event information in the 
        workspace. Manually double check that each pair under the 
        mffkey_cidx column is matched correctly. This means looking at the 
        Din label to make sure each pair contains D125 then D255 in order.
        The timing should also be ~5 seconds apart in the other columns.
        After making the change, copy and paste lines 120 through the end 
        into the commaned window and enter.

Case 4. The trials are made, but only a couple of timings are off.

        During EEG cleaning, someone must've removed a portion of data from
        the trial and failed to removed one of the event labels during the
        newly 'edited' trial. That's okay. Go ahead and reenter lines 1:140
        in the comaned window. After completing the steps open up trials in
        the workspace. By hand, look for the trials that are greater than 3
        seconds (3000ms) and delete the corresponding row. Then enter lines 
        140:174 in the command line. finí!

Any other errors that pop up are likely due to user error, i.e., not 
placing the prompt responses in single-quotes, '' or brackets, [].  
        

Author: Jasper Mark | Last Update: 5/17/2021
        
