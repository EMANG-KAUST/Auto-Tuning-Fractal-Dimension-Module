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
Tregions=[];
fprintf('\n################  Initiate FD_Analysis module ################\n\n')
i=0;

[regions] = FD_Analysis(200,200,chan_index,data,coefficient);

fprintf('\n################  FD analysis done! Initiate SCSA analysis ################\n\n')
Nregion=size(regions,1);
for k=1:Nregion %start iterating regions
    sta=regions(k,1);
    sto=regions(k,2);
    le=sta;
    ri=sta+framesize;
    cot=0;
    while ri<sto|cot==0
    cot=cot+1;
    tempR=data(chan_index(1):chan_index(2),max(1,le-3*framesize):ri);
    if(SCSASpikeDetect(tempR,framsize,sta,sto,GT))
        if GTCompare(GT,[sta,sto])
            TP=TP+1;
            break
        else 
            FP=FP+1;
        end    
    end
    le=le+step;
    ri=ri+step;    
    end    
end