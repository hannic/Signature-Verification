function run_task_file(TaskArgument)
task_file=fopen(TaskArgument.task_filename,'r');
result_file=fopen(TaskArgument.result_filename,'w');

while ~feof(task_file)
    str=fgets(task_file);
    if ~isempty(strfind(str,'[TRAIN]'))
        TrainSignature={};
        train=true;
        test=false;
    elseif ~isempty(strfind(str,'[TEST]'))
        train=false;
        test=true;
        if TaskArgument.VerificationMethod==1
            TrainArgument=TrainArgumentComputer(TrainSignature,TaskArgument);
        elseif TaskArgument.VerificationMethod==2
            HMM_argument=HMM_Train(TrainSignature,TaskArgument);
        end
        
%         for i=1:length(TrainSignature)
%             temp=GetKeyPoint(cell2mat(TrainSignature(i)),TaskArgument);
%             length(temp.KeyPoint)
%         end
    elseif str(1)=='['
        testNumber=str(2);
        TaskArgument.testNum=testNumber;
    elseif train
        signature_name=str(1:strfind(str,'.fpg')+3);
        TaskArgument.peopleNum=signature_name(end-10:end-7);
        TrainSignature=[TrainSignature,Signature_Read(signature_name,TaskArgument)];
    elseif test
        signature_name=str(1:strfind(str,'.fpg')+3);
        signature_type=str(strfind(str,'.fpg')+5:end-1);
        TestSignature=Signature_Read([TaskArgument.data_path,signature_name],TaskArgument);
%         
%         temp=GetKeyPoint(TestSignature,TaskArgument);
%         length(temp.KeyPoint)
        
        
        if TaskArgument.VerificationMethod==1
            if TaskArgument.Mah_type==2
                TaskArgument.Mahalanobis_Covariance_Matrix_inv=TaskArgument.Mahalanobis_Covariance_Matrix_inv;
            end
            %         signature_name
            [Result]=ComputerTrainWithTest(TestSignature,TrainSignature,TrainArgument,TaskArgument);
        elseif TaskArgument.VerificationMethod==2
            [Result]=HMMComputerTest(TestSignature,HMM_argument,TaskArgument);
        end
        fprintf(result_file,'%s\t%s\t%s',testNumber,signature_name,signature_type);
        for i=1:length(Result.value)
            fprintf(result_file,'\t%f',Result.value(i));
        end
        fprintf(result_file,'\n');
    end
end
fclose(task_file);
fclose(result_file);
end
