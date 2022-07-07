function [regions] = regionExtract(spike_count,frameSize,step)
%regionExtract extracts regions from spike count
regions=[];
jj=1;
while jj<=length(spike_count)
    l_bin=0;
    if spike_count(jj)>0
        l_bin=1;
        tmp_start=jj;       
        jj=jj+1;
        tmp_end=jj;
        while jj<=length(spike_count)&&spike_count(jj)>0
            tmp_end=tmp_end+1;
            jj=jj+1;
        end
        regions=[regions;[1+step*(tmp_start-1),1+step*(tmp_end-1)+frameSize-step]];
        continue;
    end
    if l_bin==1
        continue;
    end
    jj=jj+1;
end
end

