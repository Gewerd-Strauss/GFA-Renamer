# GFA_Renamer: Utility for renaming consecutive image files

This  is a small utility script written for my internship. Simply drag a folder containing ordered image files onto the GUI and follow the Instructions.

## Getting started

After downloading the script, run `GFA_Renamer.ahk` or `GFA_Renamer.exe` (depending on whether or not you have AutoHotkey as a local install.)  
It is usually recommended to use non-compiled scripts because that allows you to actually modify them without issue, but performance-wise it makes basically no difference.

## Documentation

Documentation regarding the installation and setup are in this readme-file, located on the repository's GH-page or within the `res`-subfolder.
Documentation regarding how to use the utility are located under `assets/Documentation/GFA_Renamer.<docx/html/pdf>`.

## Test Files

Test Images are downloaded from [this gist](https://gist.github.com/Gewerd-Strauss/d944d8abc295253ced401493edd377f2). They will remain up for future downloads, but unless deleted they should only be downloaded once.
Every time you load the Testset after moving the utility elsewhere, they will be downloaded to the utility's dierectory again.
The size on-disk for the zipped source set is 166 MB.

## Data access

Be aware that for obvious reasons I am not handling cleanup of the system trash bin for you; and I do not handle images outside of the script's access - which is limited to its own directory, as well as any folder you drop onto the GUI.

- For its own directory, the script handles cleanup post-execution.

- In folders provided to the script by being dropped onto the GUI, the script will only interact with image files of the filetype you have set in the configuration - `.PNG` by default. Additionally, it will write a txt-log file to the working directory.  
  - The working directory is a subfolder in the folder you drop onto the GUI, and will contain the renamed files and the log file.
