function [category] = ratiojudge(spike_count)

Nnil=150; %%specificity check parameter
threhHold=7.5;

thresholdZero=0.7;

%ratiojudge will give the current decision for adjusting threshol
if length(find(spike_count~=0))<ceil(length(spike_count)*threhHold/Nnil)
category=3;   %0,0,0,0,0,0,0,0,0,0,0,.....
elseif length(find(spike_count==0))<ceil(length(spike_count)*thresholdZero)
        category=1; %43,24,32,42,14,15,19........
else
    category=2; %0,0,0,0,0,0,2,3,0,0,0,0,1,2,4,0,0,0........
end



end

