%some framing parameters
frame_size=200;
step=100;
chan_index=[1,306];
spike_index=events.samples;
SN=length(spike_index);
EP_event=[];

data=data*10^10;

 w = bartlett(50); %Barllet window
 
% for i=1:SN
%     EP_array=[];
%     % extract spike segment
%     center=spike_index(i);
%     le=max(center-ceil(frame_size/2),1);
%     ri=center+ceil(frame_size/2);
%     seg_temp=data(:,le:ri);
%     for j=chan_index(1):chan_index(2)
%     chan_temp=seg_temp(j,:);
%     [ey,ex]=energyop(chan_temp);
%     SENO_temp=conv(w,ey);
%     EP_array(end+1)=max(SENO_temp);
%     end
%     EP_event(end+1)=max(EP_array);
% end

window_EP=[];
le=1;
ri=frame_size;
while ri<size(data,2)
    EP_array=[];
    seg_temp=data(:,le:ri);
     for j=chan_index(1):chan_index(2)
    chan_temp=seg_temp(j,:);
    [ey,ex]=energyop(chan_temp);
    SENO_temp=conv(w,ey);
     EP_array(end+1)=max(SENO_temp);
     end
    window_EP(end+1)=max(EP_array); 
    le=le+step;
    ri=ri+step;
end




data=data/10^10;