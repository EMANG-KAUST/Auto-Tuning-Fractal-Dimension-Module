
<h1 align="center">Automatic Epilepsy Spike Detection</h1>

<p align="center">
  <a href="https://ieeexplore.ieee.org/document/9374974">
    <img src="https://img.shields.io/badge/paper-IEEE%20Access-brightgreen">
  </a>  <a href="https://ieeexplore.ieee.org/abstract/document/9631028">
    <img src="https://img.shields.io/badge/paper-EMBC2021-orange">
</a>   <a href="https://www.gnu.org/licenses/gpl-3.0.en.html">
<img src="https://img.shields.io/badge/license-GPL--3.0--or--later-blue">
  </a>  
</p>

<p align="center">
  <a href="#Dataset">Dataset</a> •
  <a href="#environment">Environment</a> •
  <a href="#download">Download</a> •
  <a href="#how-to-run">How to Run</a>  •
  <a href="#license">License</a>
</p>

Algorithm diagram            |  Sample Epilepsy Spikes
:-------------------------:|:-------------------------:
![1](https://github.com/EMANG-KAUST/Automatic-epilepsy-spike-detection-/blob/main/img/1.png)  |  ![2](https://github.com/EMANG-KAUST/Automatic-epilepsy-spike-detection-/blob/main/img/2.png)


## Dataset
Project team is currently considering the [UCI machine learning repository](https://archive.ics.uci.edu/ml/index.php), once dataset is uploaded users can export MEG/EEG data from the updated link. Each patient data contains the following elements.
- `data` (A Matrix element with each row containing waveform of a specific channel. )
- `events` (A struct element with *M* spike label imformation)
                                                                            
    Field | Data Types    | Value
    ----  | ----------------- | ----------
    label  | string | "spikes"
    times  | array (double)| M doubles
    samples  | array (double) | M doubles
                                                                            
- `smpfreq` (A integer element with sampling frequency)
- `chantype` (An array element with each array element showing data type of the corresponding row in *data* element)
- `channame` (An array element with each array eleemnt showing channel type of the corresponding type in *chantype* elements)
    > Note: For EEG data, the channel waveform is 
    the difference of voltage between the *electrode* 
    and the *ground*, with the type of electrode shown 
    in *channame* variable. EEG waveform can be generated 
    by substracting two data waveforms thus eliminating 
    the ground voltage. More basics about EEG signal can be 
    found in this [tutorial](https://www.youtube.com/watch?v=XMizSSOejg0).

## Environment

Our application is developed in Matlab 2020a. An equaling or higher version is recommended and no other dependencies are needed to implement our method. To implement other methods and utilities, it is recommended to install the following Matlab toolbox:

- [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)
- [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/deep-learning.html)
## Download

This application can be downloaded by built-in [git](https://www.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html) tool in Matlab.
![screenshot](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/2.gif)

## How to Run

The repo provides a wide variety of methods and utilities which can help researchers to study epilepsy spike detection methods. Both detection methods and feature extraction methods in existing literature publications are provided.
### Table of content
              
- Our method
    - Pre-defined system parameters
    - Automatic detection function 
    - Utilities
- Other methods
    - SNEO
    - Improved SNEO by SSA
    - FD
    - Spike Detection using FD and SSA
    - Spike detection using standard deviation and EMD
- Feature extraction methods
    - SCSA eplilepsy detection
    - QuPWM feature extraction method
    - Common spatial patterns and linear discriminant analysis
    - Amplitude Thresholding and Dynamic Time Warping

### Our method 
Both pre-defined system parameters and automatic detection function and utilities are described. The first subsection is listed for research purposes with some system parameters shown in variable location and variable name allowing easier tunning process. Then usages of automatic detection function and utilities are covered for implementations.
#### Pre-defined system parameters
Parameter Description | Variable Location    | Variable Name
----  | ----------------- | ----------
number of windows in *TestBuffer* | /functions/main/FD_analysis.m | KK
data scaling parameter  | /functions/main/FD_analysis.m | ds
Initial *u* value before search  | /functions/main/threshold2.m | c
non spike ratio *R* thresholds | /functions/main/ratiojudge.m| -
exponential search base number   | /functions/main/StateTrans.m| searchD
number of linear scanning intervals  | /functions/main/StateTrans.m | IndMax
ratio value for judging *C_1, C_2* conditions | /functions/main/SCSASpikeDetect.m| ThK, ThN
SCSA *C_1 , C_2* conditions thesholds  | /functions/main/SCSASpikeDetect.m | Ts1, Ts2
maximum sample length in a region |esRegionsExtract.m | NL
number of channels in data |esRegionsExtract.m| chan_index
window sample size |esRegionsExtract.m| frame_size
moving window step size |esRegionsExtract.m| step

#### Automatic detection function
This section provides implementation of **algorithm 3** in our paper. You can get extracted regions *R_F* from an input MEG/EEG patient data D (D is matrix with each row containing channel waveforms) simply by running the following command.
```matlab
[R_F] = esRegionsExtract(D)
```
> Note: Computing time for this function depends on
the length of the data. For instance, with a sampling frequency
of 500, it typically takes several minutes to analyze input with 
1-5 minutes of patient data, while it can take several hours to 
analyze the input with 15-30 minutes of patient data.
This non-linear increase in computing time lies in the threshold selection
since longer data will involve more efforts in computing FD threshold. 
Empirically, it is recommended to keep the patient data at around 15 minutes to 
achieve maximum performance.


#### Utilities
To perform performance comparisons or to implement seperate modules for debugging purposes, use the following functions with the specifications:

|     Utilities    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`P_Matrix`**  | `P_Matrix` will output the patient's performance matrix specified in epilepsy [review](https://ieeexplore.ieee.org/document/8489863). The data workspace must contain all events informations specified in <a href="#Dataset">Dataset</a>. Running this script will return a performance matrix summarized in a command line table.                                                                                                                                                                                                                                                     |
|  `FD`   | The fractal dimension of signals be estimated with [Katz’s](https://www.sciencedirect.com/science/article/pii/0010482588900418)  algorithm. Kat'z Fractal Dimention (FD) calculation of a window can be implemented by `F_D = FD(y)`. Note: scaling of *y* can affect F_D value given FD definitions. |
|   `FDM`   | Implementation of FD module only.  Input is the data matrix with rows containing all the channels. Parameters can be adjusted in the constant definitions section. This module can be implemented by `[R] = FDM(D,framesize,step,chan_index)`, where *D* is the input data matrix and *R* is extracted regions |
|   `FD_Analysis`    | FD analysis in a single iteration. This involves more detailed implementation such as state definitions and transitions. It can also adjust system parameters such as number of elements in *TestBuffer*. This function can be run by `[regions] = FD_Analysis(frame_size,step,chan_index,data,coefficient)`.|
|  `SCSAM`   | Implementation of SCSA detection module only. Input is the regions with each row containing boundaries. Ouput is the filtered regions with each row containing boundaries.  This function can be run by `[R_F] = SCSAM(D, regions, frame_size,step,chan_index)`.                                                                                                                                                                                                                                                   |
|   `SCSA`    | SCSA reconstruction. Users can decompose the signal with a positive `h` value, by `[yscsa,Nh,EigV,EigF] = scsa_build(h,y)`. **function Input**: `h` is a positive value, also known as the [SCSA](https://link.springer.com/content/pdf/10.1007/s00498-012-0091-1.pdf) semi-classical constant. It can be selected by [Quantum-based interval selection](https://ieeexplore.ieee.org/abstract/document/9287878). `y` is the input signal to be decomposed.  **function Output**: `yscsa` is the decomposed signal, `Nh` is the number of eigenfunctions. `EigV` is a matrix with eigenvalues on its diagonal (you can export the eigenvalues by `diag(EigV)`. `EigF` is the matrix of eigenfunctions. [UI interface](https://github.com/EMANG-KAUST/SCSA-reconstruction) of this tool is also available. |



### License

The application library (i.e. all code inside of the `functions` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
