clc
clear
close all;
result_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Result';
subfolders=GetSubfolderList(result_path,1);
min_err=zeros(1,length(subfolders));
for i=1:length(subfolders)
    cd(subfolders{i});
    result=GetROC(pwd,97,1,0,1,0);
    min_err=result.min_err;
end