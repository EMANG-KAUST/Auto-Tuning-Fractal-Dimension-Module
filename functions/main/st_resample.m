function [sig_t] = st_resample(sig_t)
%st_resample this function resamples the channel for the preferable number of
%samples for SCSA to analyze
%   此处显示详细说明
[pks,locs] = findpeaks(sig_t);   
locsd=[];NL=length(locs);
for j=2:NL
    locsd(end+1)=locs(j)-locs(j-1);
end
ld=mean(locsd);                 %find average peak width
sig_t=resample(double(sig_t),400,ceil(ld*2)); % resample sig_t to be the proper peak regions length
%plot(sig_t)
end

