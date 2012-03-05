
clc
clear
close all

%the path of task fille folder
AllTaskArgument.task_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Task/1';
%the path of  result folder
AllTaskArgument.result_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Result/2011070700';
%the path of signature folder
AllTaskArgument.data_path='';

%the type of signature database
% 1 ESRA
% 2 MCYT
AllTaskArgument.data_type=2;

% signature verification method
% 1 DTW-base
% 2 HMM-base
AllTaskArgument.VerificationMethod=1;

%define the smooth type befine signature x y coordinates normalization
AllTaskArgument.smooth=0;
%define the width of smooth's gaussian filter
AllTaskArgument.smooth_width=1;
%define the sigma of smooth's gaussian filter
AllTaskArgument.smooth_sigma=1/3;

%the datat normalization type  in preprocess
% 1 (data-mean(data))/std(data)
% 2 (data-mean(data))
AllTaskArgument.normalization_type=1;
AllTaskArgument.normalization_feature=[1 2 4];

AllTaskArgument.angle_normalization=0;

%the iteration times when learning Mahalanobis distance,define 1
AllTaskArgument.iterations=1;

% define 0,
% 0 not use diag in Mahalanobis matrix
% 1 use the  diag in Mahalanobis matrix
AllTaskArgument.Mah_type_diag=0;

%the type of distance in DTW algorithm
% 1 Euclidean distance
% 2 Mahalanobis distance
AllTaskArgument.distance=2;

%the type of DTW algorithm
%define 2
% 1 the variant of standard DTW alogorithm,from <identity authentication using improved online signature verification method >
% 2 the standard DTW algorithm,http://en.wikipedia.org/wiki/Dynamic_time_warping
AllTaskArgument.dtw_type_train=2;
AllTaskArgument.dtw_type_test=2;   
AllTaskArgument.derivative=1;
AllTaskArgument.gamma=2;

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
AllTaskArgument.DTW_feature=3:4;

%the feature used in Mahalanobis distance
AllTaskArgument.select_feature=2:5;

%is removed hidden strokes
% 0 not removed it
% 1 removed it
AllTaskArgument.hidden=1;

AllTaskArgument.keyPointMethod='angleMethod';
AllTaskArgument.angle_width=3;
AllTaskArgument.angle_threshold=0.5*pi;

AllTaskArgument.fixedLength=10;
AllTaskArgument.phaseWeightmethod=4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    run_task(AllTaskArgument);

    
