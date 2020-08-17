## RPIfield
RPIfield dataset is a new multi-camera multi-shot re-id dataset collected at Rensselaer Polytechnic Institute, USA. Timestamps of each person image is preserved. To automatically collect person images, we used an off-the-shelf person detector, based on the [aggregated channel features (ACF) algorithm](https://ieeexplore.ieee.org/document/6714453/). The statistics of the proposed RPIfield dataset are provided below: 
- 12 synchronized outdoor cameras
- 112 known participants, with each showing up in at least 3 camera views
- ~4000 distractors
- 30 hours of video length in total, 

| Cam | # bboxes  | # participants | # reapp | # distractors | #Sequences |
|:---:|:------:|:-----:|:-------:|:-----:|:-----:|
|1 | 59,230 | 78 | 107 | 297 | 485 |
2 | 112,523 | 83 | 94 | 653 | 830|
3 | 72,005 | 74 | 68 | 822 | 964 |
4 | 53,986 | 70 | 72 | 393 | 536 |
5 | 67,672 | 63 | 52 | 781 | 896 |
6 | 56,472 | 64 | 38 | 865 | 967 |
7 | 17,809 | 48 | 36 | 93 | 177 |
8 | 36,338 | 55 | 40 | 266 | 361 |
9 | 3,910 | 40 | 16 | 32 | 88 |
10 | 10,492 | 62 | 51 | 105 | 218 |
11 | 73,601 | 76 | 149 | 448| 673 |
12 | 37,543 | 70 | 79 | 233 | 382 |

More details can be found in this [paper](http://openaccess.thecvf.com/content_cvpr_2018_workshops/papers/w36/Zheng_RPIfield_A_New_CVPR_2018_paper.pdf)

## How to access
1. Download the dataset from [Google Drive] (https://drive.google.com/file/d/1GO1zm7vCAJwXgJtoFyUs367_Knz8Ev0A/view?usp=sharing) or [Baidu Disk] (https://pan.baidu.com/s/1TsPRkRQwI_i88zPQqGC3oQ) (Extract Code：RPIf) and extract the files.
2. There are 4 items inside the package.
- "Data". This folder has 12 subfolders (Cam_1 to Cam_12) for 12 camera views. 
In each folder "Cam_", we include image sequence(s) for each identity at different times in different subfolder(s) with name as the label of the identity.
Label 1-112 indicate the known actors, Label #>= 10000 corresponds to pedestrians (distractors).
Note: appearance(s) of each participant at different time are put in different subfolders, e.g., subfolder "2_1" contains the first reappearance (image sequence) of person 2, subfolder "3_2" includes the second reappearance of person 3.
For the naming rule of each image, e.g., "Cam_1f_44841.png", "Cam_1": camera 1, "f_44841": frame number = 44841.

- "Data_Info". This folder has 12 items corresponds to the collective info for data in "Data" folder. 
"Cam_.mat" collects image name info, id info and timestamp info for data in each camera view.

- "load_data.m" file. You are able to access the image data from "Struct" variable by simply running this script.
Field "Struct.Imgnames", "Struct.PersonId", "Struct.CamID", "Struct.TimeStamp" and "Struct.ReappInd" are the image name, identity label, Camera label, timestamps, reappearance info for each image;

Specifically, you can access the original image by calling following Matlab command:
imread(fullfile(strcat('.\Data\Cam_',num2str(Cam#)),Struct.Imgnames{Cam#}{Img#}));

## References
Please kindly cite the paper if you use this dataset in your research. Enjoy!

@inproceedings{zheng2018rpifield,
  title={RPIField: A New Datasef for Temporally Evaluating Person Re-Identification},
  author={Zheng, Meng and Karanam, Srikrishna and Radke, Richard J},
  booktitle={IEEE Conference on Computer Vision and Pattern Recognition Workshops},
  year={2018}
}

@conference{Srik_ICDSC17,
	author = {S. Karanam and E. Lam and R. J. Radke},
	title = {Rank Persistence: Assessing the Temporal Performance of Real-World Person Re-Identification.},
	booktitle = {ICDSC},
    year=2017
}
