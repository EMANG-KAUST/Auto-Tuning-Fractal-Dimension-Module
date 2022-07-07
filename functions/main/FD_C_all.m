clear
load('EPI008_EPI008_18NOV2018_EPILEPSY_anon_sss_mc_(6)_band_resample_notch_kt');

%some parameters
frame_size=200;
step=200;
chan_index=[1,306];
spike_index=events.samples;
SN=length(spike_index);
coefficient=1;
level=2;
 for i=chan_index(1):chan_index(2)
     data(i,:)=double(data(i,:)/norm(data(i,:)));     
 end
co=1;
%%%%%%%%%%%%%%%%%%%%%%%%%FD threshold for each channel %%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n################  load data first ################\n\n')
% load threshold.mat
% load data
data=data*50;
fprintf('\n################  compute FD threshold ################\n\n')

threshold_buffer=threshold2(data,chan_index,frame_size,step,coefficient,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n################  compute spike parameter ################\n\n')
spike_count=[];

le=1+step;
ri=frame_size+step;
while ri<size(data,2)
    count=0;
    for j=chan_index(1):chan_index(2)
        seg_temp=data(j,:);
        chan_temp=seg_temp(le:ri);
        chan_temp=chan_temp*co;
        Ft=FD(chan_temp);
        le2=max(le-frame_size,1);
        ri2=ri-frame_size;
        chan_temp=seg_temp(le2:ri2);
        chan_temp=chan_temp*co;
        Ftm1=FD(chan_temp);
        if abs(Ft-Ftm1)>threshold_buffer(j)
            count=count+1;
        end
    end
    spike_count(end+1)=count;
    
    
    le=le+step;
    ri=ri+step;
end
