function signature=Signature_Read(signature_name,TaskArgument)
if TaskArgument.data_type==1
    origin_signature=importdata(signature_name);
elseif TaskArgument.data_type==2
    [x,y,z,az,in,pps]=FPG_Signature_Read(signature_name,0,0);
    origin_signature=zeros(length(x),6);
    origin_signature(:,1)=x;
    origin_signature(:,2)=y;
    origin_signature(:,3)=1000/pps;
    origin_signature(:,4)=z;
    origin_signature(:,5)=az;
    origin_signature(:,6)=in;
end

if TaskArgument.hidden==1
    origin_signature(origin_signature(:,4)==0,:)=[];
end

if TaskArgument.smooth==1
    origin_signature(:,1)=conv(origin_signature(:,1),fspecial('gaussian',[TaskArgument.smooth_width*2+1,1],TaskArgument.smooth_sigma),'same');
end

switch TaskArgument.normalization_type
    case 1
        origin_signature(:,[TaskArgument.normalization_feature])=(origin_signature(:,[TaskArgument.normalization_feature])-repmat(mean(origin_signature(:,[TaskArgument.normalization_feature])),size(origin_signature,1),1))./(repmat(std(origin_signature(:,[TaskArgument.normalization_feature])),size(origin_signature,1),1));
    case 2
        origin_signature(:,[TaskArgument.normalization_feature])=(origin_signature(:,[TaskArgument.normalization_feature])-repmat(mean(origin_signature(:,[TaskArgument.normalization_feature])),size(origin_signature,1),1));
end

if TaskArgument.angle_normalization==1
    signature_dx_dy=zeros(size(origin_signature,1),2);
    signature_dx_dy(2:end,:)=origin_signature(2:end,1:2)-origin_signature(1:end-1,1:2);
    mean_theta=atan(signature_dx_dy(:,2)./signature_dx_dy(:,1));
    mean_theta(signature_dx_dy(:,1)==0)=pi/2;
    origin_signature_theta=mean(mean_theta);
    origin_signature(:,1:2)=origin_signature(:,1:2)*[cos(origin_signature_theta) sin(origin_signature_theta);-sin(origin_signature_theta) cos(origin_signature_theta)];
end
%genarate local feature vector
%1 x   -> X coordinate sequence.
%2 y   -> Y coordinate sequence.
%3 dx
%4 dy
%5 pressure   -> Pressure coordinate sequence.
%6 dp
%7 arg1  -> Pen Azimuth coordinate sequence.
%8 arg2  -> Pen Elevation coordinate sequence.
%9 darg1
%10 darg2
%11 theta=arctan(dy/dx)
%12 speed=(dx^2+dy^2)^0.5
%13 rho=log(speed/d(theta))
%14 alpha=((d(speed))^2+(speed*d(theta))^2)^0.5
signature=zeros(size(origin_signature,1),20);
signature(:,1:2)=origin_signature(:,1:2);
if TaskArgument.derivative==1
    signature(2:end,3:4)=origin_signature(2:end,1:2)-origin_signature(1:end-1,1:2);
elseif TaskArgument.derivative==2
    denominator=2*(sum([1:TaskArgument.gamma].^2));
    for temp_index=1:TaskArgument.gamma
        signature(TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma,3:4)=...
            signature(TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma,3:4)+...
        temp_index* signature([TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma]+temp_index,1:2)-...
        temp_index* signature([TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma]-temp_index,1:2);
    end
    signature(TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma,3:4)=...
        signature(TaskArgument.gamma+1:size(signature,1)-TaskArgument.gamma,3:4)/denominator;
end

if size(origin_signature,2)==4 || size(origin_signature,2)==6
    signature(:,5)=origin_signature(:,4);
    signature(:,6)=[0;origin_signature(2:end,4)-origin_signature(1:end-1,4)];
end

if size(origin_signature,2)==6
    signature(:,7:8)=origin_signature(:,5:6);
end

signature(:,11)=atan(signature(:,4)./signature(:,3));
signature(signature(:,4)==0,11)=pi/2;
signature(:,12)=(signature(:,3).^2+signature(:,4).^2).^0.5;
temp_diff_theta=[0;signature(2:end,11)-signature(1:end-1,11)];
signature(:,13)=log(signature(:,12)./temp_diff_theta);
signature(signature(:,12)==0,13)=0;
signature(temp_diff_theta==0,13)=0;
signature(:,14)=([0;signature(2:end,12)-signature(1:end-1,12)].^2+(signature(:,12).*temp_diff_theta).^2).^0.5;

end