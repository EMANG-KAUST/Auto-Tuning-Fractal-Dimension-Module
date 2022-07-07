function [regions] = FD_Analysis2(frame_size,step,chan_index,data,coefficient)
lent=size(data,2);
nNil=min(150,lent);
dataBig=data;
%FD analysis to the coarse search of potential spike regions M*2
%  Nnil=floor(size(data,2)/frame_size); %%specificity check parameter
nNil=floor(nNil*0.9);
Nnil=nNil;
maxSearch=20; %search should not be over 20 times
% threhHold=15;
regions=[]; %%function output
level=2;
 tmp=[];
 PS=[99];%%PS initiated with 99 for programing purposes
 SearchD=10;
 ScanInterval=10;
 %boundary=[];
 index=1;
 SS=0;%%scaning state
%  frequency=500;
%  MINUTE=60;
%  MINUTE_INTERVAL=frequency*MINUTE;
%  nthMinute=0;
 %global parameters
 cursor=1;

 
 
%%%%%%%%%%%%%%%a magic scaling parameter%%%%%%%%%%%%%%%%%%%%%%%%%%
 for jiji=1:ScanInterval
     tmp(end+1)=mean(abs(data(jiji,:)));
 end
 
  data=data*2/mean(tmp);
 %%%%%%%%%%%%%%%a magic scaling parameter%%%%%%%%%%%%%%%%%%%%%%%%%%


% 
% fprintf('\n################  Preprocessing data! wait... ################\n\n')
% for i=chan_index(1):chan_index(2)
%    data(i,:)=wdenoise(double(data(i,:)),level);    
% end



% fprintf('\n################  compute FD threshold ################\n\n')
threshold_buffer=threshold2(data,chan_index,frame_size,step,coefficient,1);
bl=threshold_buffer/norm(threshold_buffer);
br=threshold_buffer/norm(threshold_buffer);
sh=0;
while 1



spike_count=[];

% fprintf('\n################  compute spike parameter ################\n\n')
spike_count=[];

le=1+step;
ri=frame_size+step;
while ri<size(data,2)
    count=0;
    
    for j=chan_index(1):chan_index(2)
        seg_temp=data(j,:);
        chan_temp=seg_temp(le:ri);
        Ft=FD(chan_temp);
        le2=max(le-frame_size,1);
        ri2=ri-frame_size;
        chan_temp=seg_temp(le2:ri2);
        Ftm1=FD(chan_temp);
        if abs(Ft-Ftm1)>threshold_buffer(j)
            count=count+1;
        end
    end
    spike_count(end+1)=count;
    
    if length(spike_count)==Nnil
        PS
        sh=sh+1;
        if sh>20
            return;
        end
        [isEnd,threshold_buffer,SS,PS,index,bl,br] = StateTrans(threshold_buffer,SS,PS,bl,br,index,ScanInterval,SearchD,spike_count);
        if isEnd==0
            break
        end
%         if length(pratio)>20
%             threshold_buffer=bl;
%             continue
%         end
        
        
%         if ratiojudge(spike_count)==3
%             
%             if length(pratio)>0
%                 if pratio(end)==3
%             %fprintf('\n################  FD wrong parameter, readjusting.. ################\n\n')
%             threshold_buffer=threshold_buffer/SearchD;%%%highly unlikely, readjust threshold value
%             pratio(end+1)=3;
%             break %%% jump out of the loop to the "continue" line
%                     
%                 elseif pratio(end)==1
%                    bl=threshold_buffer; 
%                    br=threshold_buffer*SearchD;
%                    pratio(end+1)=4;    %%%%%%adjusting scaning phase
%                    break
%                 else%already in scaning phase
%                     if index<ScanInterval
%                         threshold_buffer=bl+(br-bl)/ScanInterval*index;
%                         index=index+1;
%                         pratio(end+1)=4;
%                         break
%                     elseif index==ScanInterval
%                         bl=bl+(br-bl)/(ScanInterval-1)*index;
%                         index=1;
%                         pratio(end+1)=4;
%                         break
%                     end
%                 end
%             elseif length(pratio)==0
%                 threshold_buffer=threshold_buffer/SearchD;%%%highly unlikely, readjust threshold value
%             pratio(end+1)=3;
%             break %%% jump out of the loop to the "continue" line
%          
% 
%                                  
%             end
%             
%         elseif ratiojudge(spike_count)==1 
%             if length(pratio)>0
%                 if pratio(end)==4 %%already in scanning phse
%             if index<ScanInterval
%                         threshold_buffer=bl+(br-bl)/ScanInterval*index;
%                         index=index+1;
%                         pratio(end+1)=4;
%                         break
%                     elseif index==ScanInterval
%                         bl=bl+(br-bl)/(ScanInterval-1)*index;
%                         index=1;
%                         pratio(end+1)=4;
%                         break
%                         
%             end
%             elseif pratio(end)==3
%                 bl=threshold_buffer; 
%                    br=threshold_buffer*SearchD;
%                    pratio(end+1)=4;    %%%%%%adjusting scaning phase
%                    break
%                 end
%             else
%               threshold_buffer=threshold_buffer*SearchD;%%%highly unlikely, readjust threshold value
%             pratio(end+1)=1;
%             break %%% jump out of the loop to the "continue" line  
%                 
%             end
%            threshold_buffer=threshold_buffer*SearchD;%%%highly unlikely, readjust threshold value
%             pratio(end+1)=1;
%             break %%% jump out of the loop to the "continue" line 
%        
%     elseif ratiojudge(spike_count)==2
%         
%         end  
%     
%     end


            
            
            
            
            
            
            
            
    end
    

    
    le=le+step;
    ri=ri+step;
end

%fprintf('\n################  Reaching loop end.. ################\n\n')
if length(spike_count)==Nnil
continue;
end

break;




end
fprintf('\n################  FD finalizing.. ################\n\n')
[regions] = regionExtract(spike_count,step);

end


