function [GlobalFeature]=GetGlobalFeature(signature,argument)
GlobalFeature.total_time=sum(signature(:,3));
GlobalFeature.point_number=size(signature,1);
GlobalFeature.pen_ups=0;
% figure
% plot(signature(:,1),signature(:,2));
% hold on;
for i=2:size(signature,1)-1
    if (signature(i-1,4)~=0 && signature(i+1,4)==0)
        GlobalFeature.pen_ups=GlobalFeature.pen_ups+1;
%         plot(signature(i,1),signature(i,2),'r*');
    end
end
GlobalFeature.direction_change=0;
for i=2:size(signature,1)-1
    if ( (signature(i,2)>signature(i-1,2) && signature(i,2)>signature(i+1,2)) || ...
         (signature(i,2)<signature(i-1,2) && signature(i,2)<signature(i+1,2)) || ...
         (signature(i,1)>signature(i-1,1) && signature(i,1)>signature(i+1,1)) || ...
         (signature(i,1)<signature(i-1,1) && signature(i,1)<signature(i+1,1)) )
        GlobalFeature.direction_change=GlobalFeature.direction_change+1;
%         plot(signature(i,1),signature(i,2),'ro');
    end
    
end



dxy=signature(2:end,1:2)-signature(1:end-1,1:2);
GlobalFeature.total_long=sum((dxy(:,1).^2+dxy(:,2).^2).^0.5);


    
    

