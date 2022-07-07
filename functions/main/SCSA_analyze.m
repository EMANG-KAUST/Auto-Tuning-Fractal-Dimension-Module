function [ratio_test] = SCSA_analyze(data)
%SCSA_analyze checks if there is spike activities happening in a certain
%segment
[M,N]=size(data);
if M>N
    [M,N]=deal(N,M);
    data=data';
end
%   Matrix should be M*N where M and N are data samples and channels
%   respectively 
segment=[];
%   Preprocessing of the segment, each channel samples is smoothed
for i=1:M
    temp=smooth(data(i,:),0.3,'rloess');
    segment=[segment;temp'];
end
%   Processing the segment with SCSA

ratio_test=[];%%%for testing purposes

%%%%%%%%%
for i=1:M
    sig_t=segment(i,:);          %ith channel signal to process (temp)
    
%%%%%%%%%%%%resample%%%%%%%%%%%%sig_t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[sig_t] = st_resample(sig_t);
%%%%%%%%%%%%resample%%%%%%%%%%%%sig_t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig_t_len=length(sig_t);
[~,locs] = findpeaks(sig_t);NL=length(locs);  % find peak index again for SCSA processing
eig_buffer=[];
for j=1:NL
    le=max(1,locs(j)-150);
    ri=min(locs(j)+150,sig_t_len);
    piece_t=sig_t(le:ri);
    hmin=sqrt(abs(max(piece_t)))/pi; 
    [~ ,~,eig_v,~] =scsa_build(hmin,piece_t);
    eig_buffer(end+1)=eig_v(1,1);    
end

[m,I]=max(eig_buffer);
eig_buffer(I)=[];
ratioE=m/mean(eig_buffer);
ratio_test(end+1)=ratioE;
end
end



