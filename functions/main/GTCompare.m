function [isTP] = GTCompare(GT,region)
%GTCompare compares if the detected region is TP
%   returns a bool value
isTP=0;
le=region(1);
ri=region(2);
for i=1:length(GT)
    if (le<GT(i))&(GT(i)<ri)
        isTP=1;
        break;
    end
end

