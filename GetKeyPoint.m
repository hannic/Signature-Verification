function [result]=GetKeyPoint(signature,argument)
result.KeyPoint=zeros(1);
if strcmp(argument.keyPointMethod,'inflection')
    for i=2:size(signature,1)-1
        if ( (signature(i,2)>signature(i-1,2) && signature(i,2)>signature(i+1,2)) || ...
                (signature(i,2)<signature(i-1,2) && signature(i,2)<signature(i+1,2)) || ...
                (signature(i,1)>signature(i-1,1) && signature(i,1)>signature(i+1,1)) || ...
                (signature(i,1)<signature(i-1,1) && signature(i,1)<signature(i+1,1)) )
            result.KeyPoint=[result.KeyPoint i];
            
        end
    end
elseif strcmp(argument.keyPointMethod,'PenupPendown')
    for i=2:size(signature,1)-1
        if (signature(i-1,4)~=0 && signature(i+1,4)==0)
            result.KeyPoint=[result.KeyPoint i];
        end
    end
elseif strcmp(argument.keyPointMethod,'random')
    result.rand_vector=randperm(size(signature,1));
    
elseif strcmp(argument.keyPointMethod,'fixed')
    for i=1:argument.fixedLength:size(signature,1)-1
        result.KeyPoint=[result.KeyPoint i];
    end
elseif strcmp(argument.keyPointMethod,'MinStd')
elseif strcmp(argument.keyPointMethod,'angleMethod')
    signature_angle=zeros(size(signature,1),1);
    for i=argument.angle_width+1:size(signature,1)-argument.angle_width
        vector_ilm=signature(i-argument.angle_width,1:2)-signature(i,1:2);
        vector_ium=signature(i+argument.angle_width,1:2)-signature(i,1:2);
        signature_angle(i)=acos((vector_ilm*vector_ium')/((sum(vector_ilm.^2)^0.5)*(sum(vector_ium.^2)^0.5)));
    end
    angle_dif_1=[0;signature_angle(2:end,:)-signature_angle(1:end-1,:)];
    angle_dif_2=[0;angle_dif_1(2:end,:)-angle_dif_1(1:end-1,:)];
    index1=signature_angle<argument.angle_threshold;
    index2=zeros(size(signature,1),1);
    for i=2:size(signature,1)-1
    if signature_angle(i)<signature_angle(i-1) && signature_angle(i)<signature_angle(i+1)
        index2(i)=1;
    end
    end
    
    index3=index1&index2;
    
%     subplot(2,1,1)
%     plot(signature_angle);
%     hold on;
    temp_index=1:size(signature,1);
%     plot(temp_index(index3), signature_angle(index3,:),'*r');
%     
%     subplot(2,1,2)
%     plot(signature(:,1),signature(:,2));
%     hold on;
%     plot(signature(index3,1),signature(index3,2),'*r');
    
    result.KeyPoint=temp_index(index3);
    
 end



result.KeyPoint=[result.KeyPoint,size(signature,1)];

if length(result.KeyPoint)~=1
    result.KeyPoint(1)=[];
end