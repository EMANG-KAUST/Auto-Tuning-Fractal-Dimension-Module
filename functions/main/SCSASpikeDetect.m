function [isSpike] = SCSASpikeDetect(tempR,framesize,sta,sto,GT)
%SCSASpikeDetect uses SCSA algorithm to determine wether a region is spiky
%   this function returns a bool value

ThK=1.4;
ThN=1.5;
       Ts1=5;
       Ts2=5;
chan_index=[1,size(tempR,1)];
Nratio=[];
Kratio=[];
tempSize=size(tempR,2);
isSpike=0;
for j=chan_index(1):chan_index(2)
    seg_temp=tempR(j,:);
    seg_temp=seg_temp-min(seg_temp);
    le=tempSize-framesize;
    ri=tempSize;
    chan_temp=seg_temp(le:ri);


[yscsac ,Nhc,eig_vc,~] = scsa_build(1/pi*sqrt(max(chan_temp)),chan_temp);
    h_1=1/pi*sqrt(max(chan_temp));

    le=max(le-framesize,1);
    ri=ri-framesize;
    chan_temp=seg_temp(le:ri);
    chan_temp=chan_temp-min(chan_temp);
[yscsa ,Nh,eig_v,~] = scsa_build(h_1,chan_temp);
Nratio(end+1)=Nhc/Nh;
Kratio(end+1)=eig_vc(1,1)/eig_v(1,1);
end
% if GTCompare(GT,[sta,sto])
%    fprintf('\n################  here is the spike ################\n\n')
% end 

    if length(find(Kratio>ThK|Kratio<(1/ThK)))>=Ts1
        ttt=Nratio(find(Kratio>ThK));
        if length(find(ttt<(1/ThN)|ttt>ThN))>=Ts2
            isSpike=1;
%             fprintf('\n#  potential events logged! #\n')
            return 
        end

        
    end
    
% fprintf('\n#  potential events eliminated! #\n')


end

