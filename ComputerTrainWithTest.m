function [Result]=ComputerTrainWithTest(TestSignature,TrainSignature,TrainArgument,TaskArgument)
% DTW_argument.normalization_type=2;
% DTW_argument.dis_type=4;
% DTW_argument.dtw_type=2;
% DTW_argument.slope=4;


switch TaskArgument.distance
    case 1
        DTW_argument.dis_type=1;
    case 2
        DTW_argument.dis_type=2;
end
DTW_argument.dtw_type=TaskArgument.dtw_type_test;
DTW_argument.slope=TaskArgument.slope;
DTW_argument.select_feature=TaskArgument.select_feature;
DTW_argument.distance=TaskArgument.distance;
DTW_argument.DTW_feature=TaskArgument.DTW_feature;


DTW_argument.allsegmentResult=TrainArgument.allsegmentResult(1,:);
DTW_argument.TrainSignaturePhaseWeigth=TrainArgument.TrainSignaturePhaseWeigth(1);

if TaskArgument.distance==2
    DTW_argument.mahalanobis_covariance_matrix_inv=TrainArgument.mahalanobis_covariance_matrix_inv;
end
dis_mat=zeros(3,length(TrainSignature));
% if TaskArgument.distance==2
% DTW_argument.TrainSignatureWeigthPath_1=TrainArgument.TrainSignatureWeigthPath_1;
% DTW_argument.TrainSignatureWeigthPath_2=TrainArgument.TrainSignatureWeigthPath_2;
% DTW_argument.TrainSignatureWeigthPath_3=TrainArgument.TrainSignatureWeigthPath_3;
% end

Result.dtw_result_vector=cell(1,5);
for i=1:length(TrainSignature)
    DTW_argument.trainSignature_index=i;
    [DTW_result]=DTWCompare(TestSignature,cell2mat(TrainSignature(i)),DTW_argument);
    Result.dtw_result_vector(i)={DTW_result};
    dis_mat(1,i)=DTW_result.distance;
    dis_mat(2,i)=DTW_result.mean_distance_len;
    dis_mat(3,i)=DTW_result.mean_distance_sum_len;
end
%%no div len
index=1;
for k=1:3
    temp_mat=reshape(dis_mat(k,:,:),size(dis_mat,2),size(dis_mat,3));
    for i=1:4
    Result.value(index)=min(temp_mat)/TrainArgument.feature(k,i);
    Result.value(index+1)=max(temp_mat)/TrainArgument.feature(k,i);
    Result.value(index+2)=mean(temp_mat)/TrainArgument.feature(k,i);
    Result.value(index+3)=temp_mat(TrainArgument.feature(k,6))/TrainArgument.feature(k,i);
    Result.value(index+4)=(min(temp_mat)-TrainArgument.feature(k,i))/TrainArgument.feature(k,5);
    Result.value(index+5)=(max(temp_mat)-TrainArgument.feature(k,i))/TrainArgument.feature(k,5);
    Result.value(index+6)=(mean(temp_mat)-TrainArgument.feature(k,i))/TrainArgument.feature(k,5);
    Result.value(index+7)=(temp_mat(TrainArgument.feature(k,6))-TrainArgument.feature(k,i))/TrainArgument.feature(k,5);
    index=index+8;
    end
    
end

