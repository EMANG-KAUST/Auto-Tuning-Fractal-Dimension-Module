function threshold_buffer = threshold(data,chan_index,frame_size,step,c)
%threshold computes the FD threshold of each channel

threshold_buffer=[];
for k=chan_index(1):chan_index(2)
le=1;
ri=frame_size;
FD_array=[];
while ri<size(data,2)-frame_size
    chan_temp=data(k,le:ri);
    nn=norm(data(k,le+frame_size:min(ri+frame_size,size(data,2))));
    chan_temp=chan_temp/nn;
    chan_temp = wdenoise(double(chan_temp),2);
    FD_array(end+1)=FD(chan_temp);
    le=le+step;
    ri=ri+step;
end
window_FDS=[];
for kk=2:length(FD_array)
    window_FDS(end+1)=abs(FD_array(kk)-FD_array(kk-1));
end
threshold_buffer(end+1)=mean(window_FDS);
end
threshold_buffer=threshold_buffer*c;
end

