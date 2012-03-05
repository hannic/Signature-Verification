clc
clear
% 
% % % run_task('/home/ksl/ESRA_dev/partition-DS2-50_1/',...
% %     '/home/ksl/ESRA_dev/result/partition-DS2-50_1_0/','/home/ksl/ESRA_dev',1,4);
% % run_task('/home/ksl/ESRA_dev/partition-DS2-50/',...
% %     '/home/ksl/ESRA_dev/result/partition-DS2-50_6/','/home/ksl/ESRA_dev',2,4);
% % run_task_file('/home/ksl/ESRA_dev/partition-DS2-50-1/US1.txt', '/home/ksl/ESRA_dev/result/partition-DS2-50-1_0/US1.txt','/home/ksl/ESRA_dev');
% % run_task('/home/ksl/ESRA_dev/partition-DS2-50-1','/home/ksl/ESRA_dev/result/partition-DS2-50-1_6','/home/ksl/ESRA_dev',1,2)
% % run_task_file('/home/ksl/ESRA_dev/partition-DS2-50-1/US9.txt','/home/ksl/ESRA_dev/result/partition-DS2-50-1_4/US9.txt','/home/ksl/ESRA_dev','/home/ksl/ESRA_dev/result/partition-DS2-50-1_4/template_file/US9.txt')
% % run_task('/home/ksl/ESRA_dev/partition-DS2-50-1_1-25','/home/ksl/ESRA_dev/result/partition-DS2-50-1_4','/home/ksl/ESRA_dev',1)
% % run_task('/home/ksl/ESRA_dev/partition-DS2-50-1_26-50','/home/ksl/ESRA_dev/result/partition-DS2-50-1_4','/home/ksl/ESRA_dev',1)
% 
% 
% AllTaskArgument.task_path='/home/ksl/ESRA_dev/partition-DS2-50-1';
% 
% AllTaskArgument.data_path='/home/ksl/ESRA_dev';
% AllTaskArgument.iterations=1;
% AllTaskArgument.normalization_type=1;
% AllTaskArgument.dis_type_1=3;
% AllTaskArgument.dis_type_2=7;
% AllTaskArgument.dtw_type=2;
% AllTaskArgument.slope=4;
% AllTaskArgument.hal_type=2;
% AllTaskArgument.hal_size=6;
% AllTaskArgument.type=1;
% 
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_11';
% % AllTaskArgument.per=0.1;
% % run_task(AllTaskArgument);
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_12';
% % AllTaskArgument.per=0.2;
% % run_task(AllTaskArgument);
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_13';
% % AllTaskArgument.per=0.3;
% % run_task(AllTaskArgument);
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_14';
% % AllTaskArgument.per=0.5;
% % run_task(AllTaskArgument);
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_15';
% % AllTaskArgument.per=0.7;
% % run_task(AllTaskArgument);
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_16';
% % AllTaskArgument.per=0.9;
% % run_task(AllTaskArgument);
% %
% %x y dx dy
% AllTaskArgument.dis_type_1=1;
% AllTaskArgument.dis_type_2=6;
% AllTaskArgument.hal_type=1;
% AllTaskArgument.hal_size=4;
% % AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_17';
% % run_task(AllTaskArgument);
% 
% AllTaskArgument.normalization_type=0;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_18';
% % run_task(AllTaskArgument);
% %y dx dy p
% AllTaskArgument.dis_type_2=10;
% % AllTaskArgument.hal_type=1;
% 
% AllTaskArgument.normalization_type=0;
% AllTaskArgument.dis_type_1=1;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_19';
% % run_task(AllTaskArgument);
% 
% AllTaskArgument.dis_type_1=2;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_20';
% run_task(AllTaskArgument);
% 
% AllTaskArgument.dis_type_1=3;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_21';
% run_task(AllTaskArgument);
% 
% 
% AllTaskArgument.normalization_type=1;
% 
% AllTaskArgument.dis_type_1=1;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_22';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=2;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_23';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=3;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_24';
% run_task(AllTaskArgument);
% 
% AllTaskArgument.normalization_type=2;
% AllTaskArgument.dis_type_2=1;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_25';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=2;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_26';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=3;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_27';
% run_task(AllTaskArgument);
% 
% 
% AllTaskArgument.normalization_type=3;
% AllTaskArgument.dis_type_2=1;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_28';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=2;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_29';
% run_task(AllTaskArgument);
% AllTaskArgument.dis_type_1=3;
% AllTaskArgument.result_path='/home/ksl/ESRA_dev/result/partition-DS2-50-1_30';
% run_task(AllTaskArgument);
% % argu.task_path='/home/ksl/esra_dev/partition-ds2-50-1';
% % argu.data_path='/home/ksl/esra_dev';
% 

AllTaskArgument.task_path='/home/ksl/MCYT_Task_0';
AllTaskArgument.data_path='';
AllTaskArgument.data_type=2;

AllTaskArgument.iterations=1;

AllTaskArgument.normalization_type=1;

AllTaskArgument.Mah_type_diag=0;
AllTaskArgument.distance=2;
AllTaskArgument.dis_type_1=1;
AllTaskArgument.dis_type_2=6;
AllTaskArgument.distance=2;

AllTaskArgument.dtw_type=2;
AllTaskArgument.slope=4;

AllTaskArgument.Mah_type=1;
AllTaskArgument.select_feature=[1:6];

AllTaskArgument.type=1;
 AllTaskArgument.result_path='/home/ksl/MCYT_result/1';
%  run_task(AllTaskArgument);


AllTaskArgument.Mah_type=2;
AllTaskArgument.per=0.4;
AllTaskArgument.result_path='/home/ksl/MCYT_result/2';
% run_task(AllTaskArgument);

 AllTaskArgument.Mah_type=1;
 %x y dx dy
AllTaskArgument.select_feature=[1:4];
AllTaskArgument.result_path='/home/ksl/MCYT_result/3';
% run_task(AllTaskArgument); 
 %x y dx dy p
 AllTaskArgument.select_feature=[1:5];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/4';
% run_task(AllTaskArgument);
  % y dx dy p dp
 AllTaskArgument.select_feature=[2:6];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/5';
% run_task(AllTaskArgument);
 %x dx dy p
 AllTaskArgument.select_feature=[1,3:5];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/6';
% run_task(AllTaskArgument);
 % x dx dy p dp
 AllTaskArgument.select_feature=[1,3:6];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/7';
% run_task(AllTaskArgument);
 %y dx dy
 AllTaskArgument.select_feature=[2:4];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/8';
% run_task(AllTaskArgument);
 %x dx dy
 AllTaskArgument.select_feature=[1,3,4];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/9';
% run_task(AllTaskArgument);

AllTaskArgument.select_feature=[2:5];
 AllTaskArgument.result_path='/home/ksl/MCYT_result/10';
% run_task(AllTaskArgument);

AllTaskArgument.distance=1;
AllTaskArgument.result_path='/home/ksl/MCYT_result/11';
% run_task(AllTaskArgument);

AllTaskArgument.distance=2;
AllTaskArgument.Mah_type_diag=1;
AllTaskArgument.result_path='/home/ksl/MCYT_result/12';
% AllTaskArgument.task_path='/home/ksl/MCYT_Task_1';
% run_task(AllTaskArgument);

AllTaskArgument.normalization_type=3;
AllTaskArgument.Mah_type_diag=0;
AllTaskArgument.result_path='/home/ksl/MCYT_result/13';
% run_task(AllTaskArgument);

AllTaskArgument.distance=1;
AllTaskArgument.result_path='/home/ksl/MCYT_result/14';
% run_task(AllTaskArgument);
AllTaskArgument.distance=2;
AllTaskArgument.result_path='/home/ksl/MCYT_result/test';
run_task(AllTaskArgument);



 
