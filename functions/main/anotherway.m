clear 
fprintf('\n################  load data! wait.... ################\n\n')
load('EPI005_EPI005_03MAR2020_EPILEPSY_tsss_mc_anon_(5)_band_resample_notch_kt');

 step=200;
 framesize=200;
% 
 chan_index=[1,306];
 coefficient=1;
 GT=events.samples;
TP=0; %true positive
TN=0; %true negative
FP=0; %false positive
FN=0; %false negative
dataBig=data;
DATASIZE=size(data,2);
frequency=500;
MINUTE=300;
MINUTE_INTERVAL=frequency*MINUTE;
cursor=1; 
nthMINUTE=0;
NDataSegment=300;
CURSOR=1;
Tregions=[];
fprintf('\n################  Initiate FD_Analysis module ################\n\n')
i=0;

while CURSOR+framesize*NDataSegment<DATASIZE
    %size(data(:,CURSOR:CURSOR+NDataSegment))
    [regions] = FD_Analysis(200,200,chan_index,data(:,CURSOR:CURSOR+NDataSegment*framesize),coefficient);
    Tregions=[Tregions;regions+(CURSOR-1)];
    CURSOR=CURSOR+NDataSegment*framesize;
end


%[regions] = FD_Analysis(200,200,chan_index,data,coefficient);

%save('pqfile.mat','regions')

% 
% fprintf('\n################  breaking bigger regions... ################\n\n') 
% 
% save('pqfile.mat','regions')
% 
% i=1;
% 
% %r_new=[];
% while i<=size(regions,1)
%     tl=regions(i,1);
%     tr=regions(i,2);
%     if tr-tl>=5000        
%         regions(i,:)=[];
%         [rt] = FD_Analysis(200,200,chan_index,data(:,tl:tr),coefficient);
%         regions=[regions;rt+tl];
%         continue
%     end
%     i=i+1;
% end

