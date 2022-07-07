function [RF] = SCSAM(data,regions,framesize,step,chan_index)
%Implementation of SCSA detection module only
%Input is the regions with each row containing boundaries 
%Output is the filtered regions with each row containing boundaries.
RF=[];
% step=100;
% framesize=200;
fprintf('\n################ Initiate SCSA analysis ################\n\n')
Nregion=size(regions,1);

while regions(1,1)<=3*framesize
    regions(1,:)=[];%eliminate corner case
end

for k=1:Nregion %start iterating regions
    sta=regions(k,1);
    sto=regions(k,2);
    le=sta;
    ri=sta+framesize;
    cot=0;
    while ri<sto|cot==0
    cot=cot+1;
    tempR=data(chan_index(1):chan_index(2),max(1,le-2*framesize):min(ri,size(data,2)));
    if(SCSASpikeDetect(tempR,framesize,sta,sto))       
            RF=[RF;[sta,sto]];
            break
         
    end
    le=le+step;
    ri=ri+step;    
    end    
end

