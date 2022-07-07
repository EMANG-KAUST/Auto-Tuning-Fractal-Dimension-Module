function [R] = FDM(data,framesize,step,chan_index)
%Implementation of FD module only 
% Input is the data matrix with rows containing all the channels 
% Parameters can be adjusted in the constant definitions section.

%%%%%%%%%%%%%%%% constant definitions %%%%%%%%%%%%%%%%%%%%%%%%%%
 coefficient=1;
%%%%%%%%%%%%%%%% constant definitions %%%%%%%%%%%%%%%%%%%%%%%%%%

%  GT=events.samples;
% TP=0; %true positive
% TN=0; %true negative
% FP=0; %false positive
% FN=0; %false negative
% dataBig=data;
% DATASIZE=size(data,2);
% frequency=500;
% MINUTE=300;
% MINUTE_INTERVAL=frequency*MINUTE;
% cursor=1; 
% nthMINUTE=0;
% Tregions=[];
fprintf('\n################  Initiate FD_Analysis module ################\n\n')
% i=0;

[regions] = FD_Analysis( framesize,step,chan_index,data,coefficient);

% save('2.mat','regions')


fprintf('\n################  breaking bigger regions... ################\n\n') 

%save('pqfile.mat','regions')

i=1;

%r_new=[];
while i<=size(regions,1)
    tl=regions(i,1);
    tr=regions(i,2);
    if tr-tl>=5000        
        regions(i,:)=[];
        [rt] = FD_Analysis( framesize,step,chan_index,data(:,tl:tr),coefficient);
        regions=[regions;rt+tl];
        continue
    end
    i=i+1;
end
R=regions;
end

