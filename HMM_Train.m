function  HMM_Train(TrainSignature,TaskArgument)

for  i=1:length(TrainSignature)
    temp_signature=cell2mat(TrainSignature(i));
    signature_normalization_x_y=temp_signature(:,1)-mean(temp_signature(:,1));
    signature_normalization_x_y=[signature_normalization_x_y;temp_signature(:,2)-mean(temp_signature(:,2))];
    signature_dx_dy=zeros(size(temp_signature,1),2);
    signature_dx_dy(2:end,:)=signature_normalization_x_y(2:end,:)-signature_normalization_x_y(1:end-1,:);
    mean_theta=zeros(size(temp_signature,1),1);
    mean_theta=atan(signature_dx_dy(:,2)./signature_dx_dy(:,1));
    mean_theta(signature_dx_dy(:,1)==0,:)=pi/2;
    theta_all=mean(mean_theta);
    new_x_y=[cos(theta_all) sin(theta_all);sin(theta_all) cos(theta_all)]*signature_normalization_x_y';
    
    signature_local_feature=zeros(size(temp_signature,1),6);
    signature_local_feature(:,1:2)=new_x_y';
    new_dx_dy=zeros(size(temp_signature,1),2);
    new_dx_dy(2:end,:)=signature_local_feature(2:end,1:2)-signature_local_feature(1:end-1,1:2);
    signature_local_feature(:,3)=atan(new_dx_dy(:,2)./new_dx_dy(:,1));
    signature_local_feature(new_dx_dy(:,1)==0,3)=pi/2;
    signature_local_feature(:,4)=(new_dx_dy(:,1).^2+new_dx_dy(:,2).^2).^0.5;
    new_d_theta=zeros(size(temp_signature,1),1);
    new_d_theta(2:end,:)=signature_local_feature(2:end,3)-signature_local_feature(1:end-1,3);
    
    
end
    
