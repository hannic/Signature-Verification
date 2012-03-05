function err_stat(TaskArgument)
% result=GetROC(TaskArgument.result_path,97,1,0,1,0);
% temp_err=result.far1_mid+result.frr1_mid;
% temp_index=find(temp_err==min(temp_err));
% index=temp_index(1);
% mkdir([TaskArgument.result_path '/ERR_1/']);
cd([TaskArgument.result_path '/RIGHT/']);
% files=dir('*.txt');
% for i=1:length(files)
% file_name(1)={[num2str(index) '_far.txt']};
% file_name(2)={[num2str(index) '_frr.txt']};
files=dir('*.txt');
% mkdir(num2str(index));
for i=1:2
    temp=importdata(files(i).name);
%     cd(num2str(index));
    for j=1:length(temp)
        temp_str=cell2mat(temp(j));
        err_sig_num=temp_str(1);
        err_sig_name=temp_str(strfind(temp_str,'/'):end);
        err_Signature=Signature_Read(err_sig_name,TaskArgument);
        person_num=err_sig_name(end-10:end-7);
        person_file=fopen([TaskArgument.task_path '/' person_num '.txt'],'r');
        while ~feof(person_file)
            str=fgets(person_file);
            if ~isempty(strfind(str,'[TRAIN]'))
                TrainSignature={};
                train=true;
                test=false;
            elseif ~isempty(strfind(str,'[TEST]'))
                train=false;
                test=true;
                if TaskArgument.testNum==err_sig_num
                    TrainArgument=TrainArgumentComputer(TrainSignature,TaskArgument);
                    result=ComputerTrainWithTest(err_Signature,TrainSignature,TrainArgument,TaskArgument);
                    plot_err_stat(result,err_Signature,err_sig_num,err_sig_name,TrainSignature);
                end
            elseif str(1)=='['
                testNumber=str(2);
                TaskArgument.testNum=testNumber;
            elseif train
                signature_name=str(1:strfind(str,'.fpg')+3);
                TaskArgument.peopleNum=signature_name(end-10:end-7);
                TrainSignature=[TrainSignature,Signature_Read(signature_name,TaskArgument)];
            elseif test
            end
        end
    end
%     cd('..');
end
end

