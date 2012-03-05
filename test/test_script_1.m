clc
clear
AllTaskArgument.task_path='/home/ksl/MCYT_Task_4';
AllTaskArgument.data_path='';
AllTaskArgument.data_type=2;

AllTaskArgument.iterations=1;

AllTaskArgument.normalization_type=1;

AllTaskArgument.Mah_type_diag=0;
AllTaskArgument.distance=2;
AllTaskArgument.dis_type_1=1;
AllTaskArgument.dis_type_2=2;
AllTaskArgument.distance=2;

AllTaskArgument.dtw_type=2;
AllTaskArgument.slope=3;

AllTaskArgument.Mah_type=3;
AllTaskArgument.select_feature=2:5;

AllTaskArgument.type=1;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/16';
 
% run_task(AllTaskArgument);
AllTaskArgument.Mah_type=4;
AllTaskArgument.alpha=0.01;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/17';
% run_task(AllTaskArgument);

% AllTaskArgument.type=1;
AllTaskArgument.Mah_type=3;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/test';
%  run_task(AllTaskArgument);
AllTaskArgument.task_path='/home/ksl/MCYT_Task_6';
AllTaskArgument.dis_type_1=1;
AllTaskArgument.Mah_type=1;
AllTaskArgument.distance=1;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/20';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/21';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/22';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/24';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/25';
 AllTaskArgument.hidden=0;
 AllTaskArgument.DTW_feature=2:5;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/26';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/27';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/28';
 AllTaskArgument.normalization_type=2;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/30';
 AllTaskArgument.hidden=0;
 AllTaskArgument.Mah_type=4;
 AllTaskArgument.distance=2;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/31';
 AllTaskArgument.task_path='/home/ksl/MCYT_Task_5';
 AllTaskArgument.result_path='/home/ksl/MCYT_result/32';
 
 for i=2:9
 AllTaskArgument.alpha=0.01*i;
 AllTaskArgument.result_path=['/home/ksl/MCYT_result/' num2str(31+i)];
 run_task(AllTaskArgument);
 end