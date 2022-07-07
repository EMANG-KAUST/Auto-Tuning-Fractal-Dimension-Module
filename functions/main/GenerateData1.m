function [EEG,y]=GenerateData1(filename,f,s,chanRange)

%%%%%%%%%%%%%%%%%%%%%%%some labling parameter%%%%%%%%%%%%%%%%%%%%
PositiveClassLable=1;
NegativeClassLable=2;               
SpikeLable=1;
NonSpikeLable=2;
%%%%%%%%%%%%%%%%%%%%%%%some labling parameter%%%%%%%%%%%%%%%%%%%%


load(filename);
% load(filename, 'events');
% [data,y]=eegextract(data,chantype,events);
% 
ySize=size(data,2)

data=data(chanRange(1):chanRange(2),:);
size(data)

y=zeros(ySize,1);
spikeTime=events.times;
for i=1:length(y)
    y(i)=NonSpikeLable;
end
for i=1:length(time)
    for j=1:length(spikeTime)
        if abs(time(i)-spikeTime(j))<0.001
        y(i)=SpikeLable;
        end
    end    
end





ytemp=y;


y=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%framing parameter%%%%%%%%%%%%%%%%%%%%%%%%%
FRAMESIZE=f;
TH=1;
STEP=s;
CURSOR=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%framing parameter%%%%%%%%%%%%%%%%%%%%%%%%%

SIZE=size(data,2);
EEG=[];
y=[];
while CURSOR+FRAMESIZE<SIZE
    yy=ytemp(CURSOR:CURSOR+FRAMESIZE);
    temp=data(:,(CURSOR:CURSOR+FRAMESIZE));
    flat=[];
    CURSOR=CURSOR+STEP;
    for i=1:size(temp,2)
        flat=[flat; temp(:,i)];
    end
    EEG=[EEG flat];
    if length(find(yy==SpikeLable))>=TH
        y(end+1)=PositiveClassLable;
        continue
    end
    y(end+1)=NegativeClassLable;
       
end


EEG=EEG';
y=y';
 
end