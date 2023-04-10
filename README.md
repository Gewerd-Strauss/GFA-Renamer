# GFA_Renamer: Utility for renaming consecutive image files based on a set of names

This  is a small utility script written for my internship. Simply drag a folder containing ordered image files - onto the GUI.  
Then enter the required group names and number of pots per group and confirm your choices. 

The image files in that folder will then be duplicated into a subfolder `GFAR_WD`, wherein they will be renamed according to the information provided.

The script additionally provides a log file stating
1. The number of expected files
2. The number of renamed files, and
3. For every file its original and new filename.

The original files will never be altered directly as a precaution. It is the user's responsibility to decide to delete the original backup files.

## How to deal with missing images
In cases where a certain group has fewer images than the other - as could be the case if you loose a single pot at some point due to damage - simply copy the image of the previous pot and create a copy.

Example:

You have a group of plants which get watered at half the normal volume for 14 days, and every group has 7 pots.
The pot G14D4 (14 Days at reduced water supply, then back up to normal) was removed because it got dropped a day before. 

In this case, all groups have seven images, but the G14-Group only has six. Thus, imagine you have the following images to work with:


| Number | Filename        | plant label                         |
| ------ | --------------- | ----------------------------------- |
| 1      | DSC10111.JPG        | `G14D1`                             |
| 2      | DSC10112.JPG        | `G14D2`                             |
| 3      | DSC10113.JPG        | `G14D3`                             |
| 4      | DSC10114.JPG        | `G14D5`                             |
| 5      | DSC10115.JPG        | `G14D6`                             |
| 6      | DSC10116.JPG        | `G14D7`                             |

In this example, `DSC10111-DSC10113` are `G14D1-G14D3`,and `DSC10114-DSC10116` are `G14D5-G14D7`. Thus, the image for `G14D5` is missing. If you just run the program, you would falsely rename all files beyond `DSC10113` because there would be a frame shift.  
To prevent this, create a copy of `DSC10113` - it is important that you copy the image of the pot _immediately before the one that is missing_:

| Number | Filename        | plant label                         |
| ------ | --------------- | ----------------------------------- |
| 1      | DSC10111.JPG        | `G14D1`                             |
| 2      | DSC10112.JPG        | `G14D2`                             |
| 3      | DSC10113.JPG        | `G14D3`                             |
| 4      | DSC10113 - Copy.JPG | `Placeholder for the missing G14D4` |
| 5      | DSC10114.JPG        | `G14D5`                             |
| 6      | DSC10115.JPG        | `G14D6`                             |
| 7      | DSC10116.JPG        | `G14D7`                             |


Because the script will read images in the folder based on their name, this method ensures the gap is filled appropriately.

This repository contains a sample set in the folder `assets\Image Test Files`. It contains the raw images, as well as the resulting output in the subfolder `GFAR_WD`.



