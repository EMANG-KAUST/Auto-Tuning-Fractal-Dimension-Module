TP=0;
FP=0;
RF=[];
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
    tempR=data(chan_index(1):chan_index(2),max(1,le-2*framesize):min(ri,size(data,2)));
    if(SCSASpikeDetect(tempR,framesize,sta,sto,GT))
        if GTCompare(GT,[sta,sto])
            TP=TP+1;
            RF=[RF;[sta,sto]];
            break
        else 
            FP=FP+1;
        end    
    end
    le=le+step;
    ri=ri+step;    
    end    
end