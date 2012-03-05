clc
clear
close all

%the path of task fille folder
AllTaskArgument.task_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Task/1';
%the path of  result folder
AllTaskArgument.result_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Result/DTW_1_6_feature/';

%the path of signature folder
AllTaskArgument.data_path='';
%the type of signature database
% 1 ESRA
% 2 MCYT
AllTaskArgument.data_type=2;
%the iteration times when learning Mahalanobis distance,define 1
AllTaskArgument.iterations=1;
%the datat normalization type  in preprocess
% 1 (data-mean(data))/std(data)
% 2 (data-mean(data))
AllTaskArgument.normalization_type=2;
AllTaskArgument.normalization_feature=[1 2];
% define 0,
% 0 not use diag in Mahalanobis matrix
% 1 use the  diag in Mahalanobis matrix
AllTaskArgument.Mah_type_diag=0;
%the type of distance in DTW algorithm
% 1 Euclidean distance
% 2 Mahalanobis distance
AllTaskArgument.distance=1;
%the type of DTW algorithm
%define 2
% 1 the variant of standard DTW alogorithm,from <identity authentication using improved online signature verification method >
% 2 the standard DTW algorithm,http://en.wikipedia.org/wiki/Dynamic_time_warping
AllTaskArgument.dtw_type_train=2;
AllTaskArgument.dtw_type_test=2;   
%the argument for compute locality constraint
AllTaskArgument.slope=4;
% type of computer the matrix in Mahalanobis distance
% 1,use 5 train signature /per people train the matrix
% 2,use AllTaskArgument.per of all signature to train matrix
% 3,use 5 genuine_signatures/user 2 forgeries/user train the matrix  MDV_RT
% 4,use 5 genuine_signatures/user 2 forgeries/user train the matrix  MDV_ST
AllTaskArgument.Mah_type=1;
% when set AllTaskArgument.Mah_type==4,is the alpha value in MDV_ST
AllTaskArgument.alpha=0.01;
%the feature used in Euclidean distance
AllTaskArgument.DTW_feature=2:5;
%the feature used in Mahalanobis distance
AllTaskArgument.select_feature=2:5;
%is removed hidden strokes
% 0 not removed it
% 1 removed it
AllTaskArgument.hidden=0;

AllTaskArgument.keyPointMethod='fixed';
AllTaskArgument.fixedLength=10;
AllTaskArgument.phaseWeightmethod=4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:6
    feature_combntns=combntns(1:6,i);
    for j=1:size(feature_combntns,1)
        if feature_combntns(j,1)==1 && size(feature_combntns(j,:),2)==1
            continue;
        end
        AllTaskArgument.DTW_feature=feature_combntns(j,:);
        AllTaskArgument.result_path=[AllTaskArgument.result_path num2str(feature_combntns(j,:))];
        run_task(AllTaskArgument);
        
%         index=index+1;
    end
end


