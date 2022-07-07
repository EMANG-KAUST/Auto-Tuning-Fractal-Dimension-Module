function [r] = regionCount(regions)
%This count the number of frames
framesize=200;
N=size(regions,1);
r=0;
for i=1:N
    n=floor((regions(i,2)-regions(i,1))/framesize);
    r=r+n;
end

end

