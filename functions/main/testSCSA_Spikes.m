%  clear all
%  load('EPI006_EPI006_28OCT2020_EPILEPSY2_tsss_mc_anon_(3)_band_resample_notch_kt.mat')
%some parameters
frame_size=500;
step=500;
chan_index=[1,306];
spike_index=events.samples;
SN=length(spike_index);
coefficient=1;
level=2;
stdNratio=[];
stdNratioA=[];
stdKratio=[];
stdKratioA=[];
NNratioS=[];
NKratioS=[];
%%%%%%%%%%%%%%%%%%%%%%%%%FD threshold for each channel %%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n################  load data first ################\n\n')
% data=data*10^12;
% load data2
% load threshold.mat
% load data
% fprintf('\n################  compute SCSA threshold ################\n\n')

% threshold_buffer=threshold2(data,chan_index,frame_size,step,coefficient,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
countS=0;
fprintf('\n################  compute spike parameter ################\n\n')
for i=1:SN
    Kratio=[];
    % extract spike segment
    center=spike_index(i);
    Nratio=[];
    NNratio=[];
    NKratio=[];
    %seg_temp=data(:,le:ri);
    for j=chan_index(1):chan_index(2)
    le=max(center-ceil(frame_size/2),1);
    ri=center+ceil(frame_size/2);
    j;
    seg_temp=data(j,:);
    chan_temp=seg_temp(le:ri);
    chan_temp=chan_temp-min(chan_temp);
%     nn=norm(chan_temp);
    [yscsac ,Nhc,eig_vc,~] = scsa_build(1/pi*sqrt(max(chan_temp)),chan_temp);
%     if j==185
%         chan_temp
%     end
%     chan_temp = wdenoise(double(chan_temp),2);
%     Ft=FD(chan_temp);
    %take the previous frame
    center1=center-step;
    le=max(center1-ceil(frame_size/2),1);
    ri=center1+ceil(frame_size/2);
    chan_temp=seg_temp(le:ri);
    chan_temp=chan_temp-min(chan_temp);
%     chan_temp=chan_temp*co;
%     chan_temp = wdenoise(double(chan_temp),2);
%     Ftm1=FD(chan_temp);
%     abs(Ft-Ftm1);
%     threshold_buffer(j);
    [yscsa ,Nh,eig_v,~] = scsa_build(1/pi*sqrt(max(chan_temp)),chan_temp);
    
    center2=center-2*step;
    le=max(center2-ceil(frame_size/2),1);
    ri=center2+ceil(frame_size/2);
    chan_temp=seg_temp(le:ri);
    chan_temp=chan_temp-min(chan_temp);
    [yscsa1 ,Nh1,eig_v1,~] = scsa_build(1/pi*sqrt(max(chan_temp)),chan_temp);
    
    Nratio(end+1)=Nhc/Nh;
    Kratio(end+1)=eig_vc(1,1)/eig_v(1,1);
    NNratio(end+1)=Nhc*Nh1/Nh^2;
    NKratio(end+1)=eig_vc(1,1)*eig_v1(1,1)/eig_v(1,1)^2;
    
    end  
    NNratioS(end+1)=var(NNratio);
    NKratioS(end+1)=var(NKratio);
    
    stdNratio(end+1)=var(Nratio);
    stdKratio(end+1)=var(Kratio);
    stdNratioA(end+1)=var(abs(Nratio-1));
    stdKratio(end+1)=var(abs(Kratio-1));
    if length(find(Kratio>1.2))>=5
        ttt=Nratio(find(Kratio>1.2));
        if length(find(ttt<0.9|ttt>1.1))>=1
            countS=countS+1;
            fprintf('\n#  potential events logged! #\n')
        end
    end
    fprintf('\n################  one region analysis done! ################\n\n')
end



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


