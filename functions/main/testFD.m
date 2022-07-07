%load('EPI006_EPI006_28OCT2020_EPILEPSY2_tsss_mc_anon_(3)_band_resample_notch_kt.mat');

%some parameters
frame_size=200;
step=100;
chan_index=[1,306];
FD_event=[];
window_FD=[];
FDP_event=[];
spike_index=events.samples;
SN=length(spike_index);

data=data*10^12;

% for i=1:SN
%     FD_array=[];
%     % extract spike segment
%     center=spike_index(i);
%     le=max(center-ceil(frame_size/2),1);
%     ri=center+ceil(frame_size/2);
%     seg_temp=data(:,le:ri);
%     for j=chan_index(1):chan_index(2)
%     chan_temp=seg_temp(j,:);
%     FD_array(end+1)=FD(chan_temp);
%     end
%     FD_event(end+1)=max(FD_array);
%     
%     
%     %take the previous frame
%     FD_array=[];
%     center=center-step;
%     le=max(center-ceil(frame_size/2),1);
%     ri=center+ceil(frame_size/2);
%     seg_temp=data(:,le:ri);
%     for j=chan_index(1):chan_index(2)
%     chan_temp=seg_temp(j,:);
%     FD_array(end+1)=FD(chan_temp);
%     end
%     FDP_event(end+1)=max(FD_array);
%     
% end
% FDS_event=abs(FD_event-FDP_event);

% 
% le=1;
% ri=frame_size;
% while ri<size(data,2)
%     FD_array=[];
%     seg_temp=data(:,le:ri);
%      for j=chan_index(1):chan_index(2)
%     chan_temp=seg_temp(j,:);
%     FD_array(end+1)=FD(chan_temp);
%      end
%     window_FD(end+1)=max(FD_array); 
%     le=le+step;
%     ri=ri+step;
% end
% window_FDS=[];
% for k=2:length(window_FD)
%     window_FDS(end+1)=abs(window_FD(k)-window_FD(k-1));
% end


data=data/10^12;