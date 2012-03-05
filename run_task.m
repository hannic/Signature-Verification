function run_task(AllTaskArgument)
if ispc
    AllTaskArgument.pathname_separator='\';
elseif isunix
    AllTaskArgument.pathname_separator='/';
end

mkdir(AllTaskArgument.result_path);
task_lists=dir([AllTaskArgument.task_path AllTaskArgument.pathname_separator '*.txt']);


if AllTaskArgument.Mah_type==2;        
    TrainArgument=GetAllSignatureMahalanobisMartix(AllTaskArgument);
    AllTaskArgument.Mahalanobis_Covariance_Matrix_inv=TrainArgument.Mahalanobis_Covariance_Matrix_inv;
end

for i=1:length(task_lists)
    AllTaskArgument.task_filename=[AllTaskArgument.task_path AllTaskArgument.pathname_separator task_lists(i).name];
    AllTaskArgument.result_filename=[AllTaskArgument.result_path AllTaskArgument.pathname_separator task_lists(i).name];
    run_task_file(AllTaskArgument);

end
end
