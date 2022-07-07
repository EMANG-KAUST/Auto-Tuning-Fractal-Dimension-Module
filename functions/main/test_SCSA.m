clear all
load('EPI006_EPI006_28OCT2020_EPILEPSY2_tsss_mc_anon_(3)_band_resample_notch_kt.mat');

%some parameters
frame_size=500;
step=500;
chan_index=[1,306];
FD_event=[];
window_FD=[];
FDP_event=[];
spike_index=events.samples;
SN=length(spike_index);

data=data*10^13;

for i=1:SN
    FD_array=[];
    % extract spike segment
    center=spike_index(i);
    le=max(center-ceil(frame_size/2),1);
    ri=center+ceil(frame_size/2);
    seg_temp=data(:,le:ri);
    [ratio_test] = SCSA_analyze(seg_temp);
end

data=data/10^13;