function PlotTrainStd(TrainSignature,dtw_result_matrix,TaskArgument)
TrainSignatureMaxLength=0;
for i=1:size(TrainSignature,2)
    if size(cell2mat(TrainSignature(i)),1)>TrainSignatureMaxLength
        TrainSignatureMaxLength=size(cell2mat(TrainSignature(i)),1);
        MaxIndex=i;
    end
end

TrainSignatureDTW=zeros(size(TrainSignature,2),TrainSignatureMaxLength,20);

% TrainSignatureDTW(i,:)=1:TrainSignatureDTW;
if MaxIndex==1
    temp_dtw_result=cell2mat(dtw_result_matrix(1,2));
    TrainSignatureDTW(1,:,:)=temp_dtw_result.signature_1_local_feature;
else
    temp_dtw_result=cell2mat(dtw_result_matrix(1,MaxIndex));
    TrainSignatureDTW(MaxIndex,:,:)=temp_dtw_result.signature_2_local_feature;
end

for i=1:MaxIndex-1
    temp_dtw_result=cell2mat(dtw_result_matrix(i,MaxIndex));
    for j=1:TrainSignatureMaxLength
        
        temp_index=temp_dtw_result.path1(temp_dtw_result.path2==j);
        TrainSignatureDTW(i,j,:)=mean(temp_dtw_result.signature_1_local_feature(temp_index,:),1);
    end
end

for i=MaxIndex+1:size(TrainSignature,2)
    temp_dtw_result=cell2mat(dtw_result_matrix(MaxIndex,i));
    for j=1:TrainSignatureMaxLength
        temp_index=temp_dtw_result.path2(temp_dtw_result.path1 ==j);
        TrainSignatureDTW(i,j,:)=mean(temp_dtw_result.signature_2_local_feature(temp_index,:),1);
    end
end

gcf=figure;
plot_index=1;
for i=[5:6 11:14]
    subplot(3,2,plot_index);
    plot(std(TrainSignatureDTW(:,:,i)));
    plot_index=plot_index+1;
end

saveas(gcf,[TaskArgument.peopleNum '_' TaskArgument.testNum '.png'],'png');
close all;