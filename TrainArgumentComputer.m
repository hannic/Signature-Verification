function [TrainArgument]=TrainArgumentComputer(TrainSignature,TaskArgument)

distance_matrix=zeros(3,5,5);
dtw_result_matrix=cell(5,5);
distance_vector=zeros(3,10);

TrainArgument.sum_Mahalanobis_matrix=zeros(length(TaskArgument.select_feature));
TrainArgument.optionfun=zeros(1,1+TaskArgument.iterations);


dtw_argument.dis_type=1;
dtw_argument.dtw_type=TaskArgument.dtw_type_train;
dtw_argument.slope=TaskArgument.slope;
dtw_argument.select_feature=TaskArgument.select_feature;
dtw_argument.distance=TaskArgument.distance;
dtw_argument.DTW_feature=TaskArgument.DTW_feature;

if TaskArgument.Mah_type~=2
    dtw_argument.mahalanobis_covariance_matrix_inv=diag(ones(1,length(TaskArgument.select_feature)));
    for i=1:5
        for j=i+1:5
            dtw_result=DTWCompare(cell2mat(TrainSignature(i)),cell2mat(TrainSignature(j)),dtw_argument);
            dtw_result_matrix(i,j)={dtw_result};
            distance_matrix(1,i,j)=dtw_result.distance;
            distance_matrix(2,i,j)=dtw_result.mean_distance_len;
            distance_matrix(3,i,j)=dtw_result.mean_distance_sum_len;
            if  TaskArgument.distance==2
                TrainArgument.sum_Mahalanobis_matrix=TrainArgument.sum_Mahalanobis_matrix+dtw_result.sum_mah_dis;
                TrainArgument.optionfun(1)=TrainArgument.optionfun(1)+dtw_result.optionfun;
            end
        end
    end
end
if TaskArgument.distance==2
    for iterations_count=1:TaskArgument.iterations
        if TaskArgument.Mah_type==3 || TaskArgument.Mah_type==4
            TrainArgument.sum_Mahalanobis_matrix_dif=zeros(length(TaskArgument.select_feature));
            for i=6:length(TrainSignature)
                for j=1:5
                    dtw_result=DTWCompare(cell2mat(TrainSignature(i)),cell2mat(TrainSignature(j)),dtw_argument);
                    TrainArgument.sum_Mahalanobis_matrix_dif=TrainArgument.sum_Mahalanobis_matrix_dif+dtw_result.sum_mah_dis;
                end
            end
        elseif TaskArgument.Mah_type==5
            GetPointMahalanobisMatrix(TrainSignature,TaskArgument,dtw_result_matrix);
        end
        
        switch TaskArgument.Mah_type
            case 1
                temp_matrix=TrainArgument.sum_Mahalanobis_matrix;
            case 3
                temp_matrix=(TrainArgument.sum_Mahalanobis_matrix_dif\TrainArgument.sum_Mahalanobis_matrix)/TrainArgument.sum_Mahalanobis_matrix_dif;
            case 4
                temp_matrix=TrainArgument.sum_Mahalanobis_matrix-TrainArgument.sum_Mahalanobis_matrix_dif*TaskArgument.alpha;
        end
        
        if TaskArgument.Mah_type==1 || TaskArgument.Mah_type==3 || TaskArgument.Mah_type==4
            TrainArgument.mahalanobis_covariance_matrix_inv=inv(temp_matrix/ (det(temp_matrix) ^ ((1/(length(TaskArgument.select_feature))))));
        elseif TaskArgument.Mah_type==2
            TrainArgument.mahalanobis_covariance_matrix_inv=TaskArgument.mahalanobis_covariance_matrix_inv;
        end
        
        
        
        dtw_argument.dis_type=2;
        if TaskArgument.Mah_type_diag==1
            temp_martix=TrainArgument.mahalanobis_covariance_matrix_inv.*diag(ones(1,length(TrainArgument.mahalanobis_covariance_matrix_inv)));
            TrainArgument.mahalanobis_covariance_matrix_inv=inv(temp_martix)/(det(inv(temp_martix))^(1/length(temp_martix)));
        end
        dtw_argument.mahalanobis_covariance_matrix_inv=TrainArgument.mahalanobis_covariance_matrix_inv;
        TrainArgument.sum_Mahalanobis_matrix=0;
        for i=1:5
            for j=i+1:5
                dtw_result=DTWCompare(cell2mat(TrainSignature(i)),cell2mat(TrainSignature(j)),dtw_argument);
                dtw_result_matrix(i,j)={dtw_result};
                distance_matrix(1,i,j)=dtw_result.distance;
                distance_matrix(2,i,j)=dtw_result.mean_distance_len;
                distance_matrix(3,i,j)=dtw_result.mean_distance_sum_len;
                if  TaskArgument.distance==2
                    TrainArgument.sum_Mahalanobis_matrix=TrainArgument.sum_Mahalanobis_matrix+dtw_result.sum_mah_dis;
                    TrainArgument.optionfun(iterations_count+1)=TrainArgument.optionfun(iterations_count+1)+dtw_result.optionfun;
                end
            end
        end
    end
end
% PlotTrainStd(TrainSignature,dtw_result_matrix,TaskArgument);

for k=1:3
    distance_vector_index=1;
    for i=1:length(distance_matrix)
        for j=1:i
            distance_matrix(k,i,j)=distance_matrix(k,j,i);
            dtw_result_matrix(i,j)=dtw_result_matrix(j,i);
        end
        for j=i+1:length(distance_matrix)
            distance_vector(k,distance_vector_index)=distance_matrix(k,i,j);
            distance_vector_index=distance_vector_index+1;
        end
    end
end

if TaskArgument.distance==2
    TrainArgument.TrainSignatureWeigthPath_1=ComputeLocalWeight(TrainSignature,dtw_result_matrix,reshape(distance_matrix(1,:,:),[5 5]),TaskArgument,TrainArgument);
    TrainArgument.TrainSignatureWeigthPath_2=ComputeLocalWeight(TrainSignature,dtw_result_matrix,reshape(distance_matrix(2,:,:),[5 5]),TaskArgument,TrainArgument);
    TrainArgument.TrainSignatureWeigthPath_3=ComputeLocalWeight(TrainSignature,dtw_result_matrix,reshape(distance_matrix(3,:,:),[5 5]),TaskArgument,TrainArgument);
end


%generate the train siganture
TrainArgument.feature=zeros(3,6);
for k=1:3
    temp_mat=reshape(distance_matrix(k,:,:),size(distance_matrix,2),size(distance_matrix,3));
    %min mean
    TrainArgument.feature(k,1)=mean(min(temp_mat(temp_mat~=0),[],2));
    %max mean
    TrainArgument.feature(k,2)=mean(max(temp_mat,[],2));
    %template mean
    TrainArgument.feature(k,3)=sum(temp_mat(sum(temp_mat,2)==min(sum(temp_mat,2)),:))/(length(TrainSignature)-1);
    %mean
    TrainArgument.feature(k,4)=mean(distance_vector(k,:));
    %std
    TrainArgument.feature(k,5)=std(distance_vector(k,:));
    %template number
    TrainArgument.feature(k,6)=find(sum(temp_mat,2)==min(sum(temp_mat,2)));
end
TrainArgument.segmentResult=cell(3,1);
TrainArgument.TrainSignaturePhaseWeigth=cell(3,1);

for k=1:3
    TrainArgument.segmentResult(k)={GetKeyPoint(cell2mat(TrainSignature(TrainArgument.feature(k,6))),TaskArgument)};
    TrainArgument.TrainSignaturePhaseWeigth(k)={ComputerPhaseWeight(TrainArgument.feature(k,6),dtw_result_matrix,TrainArgument.segmentResult(k),TaskArgument)};
end
TrainArgument.allsegmentResult=cell(3,5);
for k=1
    for i=1:5
        if i==TrainArgument.feature(k,6)
            KeyPointVector_=cell2mat(TrainArgument.segmentResult);
            KeyPointVector=KeyPointVector_.KeyPoint;
            temp_segment=zeros(size(KeyPointVector));
            for index_2=1:length(KeyPointVector)
                temp_segment(index_2)=KeyPointVector(index_2);
            end
        else
            if i<TrainArgument.feature(k,6)
                dtw_result=cell2mat(dtw_result_matrix(i,TrainArgument.feature(k,6)));
                
                KeyPointVector_=cell2mat(TrainArgument.segmentResult);
                KeyPointVector=KeyPointVector_.KeyPoint;
                temp_segment=zeros(size(KeyPointVector));
                for index_2=1:length(KeyPointVector)
                    temp_segment(index_2)=dtw_result.path1(find(dtw_result.path2==KeyPointVector(index_2),1,'last'));
                end
            else
                dtw_result=cell2mat(dtw_result_matrix(TrainArgument.feature(k,6),i));
                KeyPointVector_=cell2mat(TrainArgument.segmentResult);
                KeyPointVector=KeyPointVector_.KeyPoint;
                temp_segment=zeros(size(KeyPointVector));
                for index_2=1:length(KeyPointVector)
                    temp_segment(index_2)=dtw_result.path2(find(dtw_result.path1==KeyPointVector(index_2),1,'last'));
                end
            end
            
        end
        TrainArgument.allsegmentResult(k,i)={temp_segment};
    end
end



end


