function [RF] = esRegionsExtract(data)
%This section provides implementation of algorithm 3 in our paper. 
%You can get extracted regions R_F from an input MEG/EEG patient data D 
%(D is matrix with each row containing channel waveforms) simply by 
%running the function.


%constants definition
step=100;
framesize=200;
coefficient=1;
NL=5000;


%NumChannel is the end index of the channel number. System will select
%channels ranging 1~NumChannel to analyse.
NumChannel=306;

S1=size(data,1)
if S1>=NumChannel
chan_index=[1,NumChannel]; 
else
    chan_index=[1,S1];
end

%Un-comment the following command for channel specifications. 
%input the left and right boundaries of channels. For example, if 
%channel 1-306 is MEG and 307-327 is EEG, then chan_index=[1,306] if you
%want to analyse MEG and chan_index=[307,327] if you want to analyze EEG.

%chan_index=[1,306]; 



%fprintf('\n################  Initiate FD_Analysis module ################\n\n')
regions=FDM(data,framesize,step,chan_index);


%fprintf('\n################  FD analysis done! Initiate SCSA analysis ################\n\n')
[RF] = SCSAM(data,regions,framesize,step,chan_index)


end

