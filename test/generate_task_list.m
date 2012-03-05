% cd('/home/ksl/MCYT_Signature_100/')
% allSubFolders = genpath('MCYT_Signature_100/');
clc;
clear;
close all;
% path='/home/ksl/MCYT_Signature_100/';
% task_path='/home/ksl/MCYT_Task_5/';
path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Signature_100/';
task_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Task/4/';
if ispc
    pathname_separator='\';
elseif isunix
    pathname_separator='/';
end
mkdir(task_path);


subfoldersList=GetSubfolderList(path);
for i=1:length(subfoldersList)
    foldname=subfoldersList{i};
    taskfilename=[ foldname(strfind(foldname,[pathname_separator '0'])+1:end) '.txt'];
    fid=fopen([task_path taskfilename],'w');
    genuine_signature={};
    forgeries_signature={};
    files=dir([foldname pathname_separator '*.fpg']);
    for j=1:length(files)
        filename=files(j).name;
        if strfind(filename(1:strfind(filename,'.fpg')-1),'v');
            genuine_signature=[genuine_signature filename];
        else
            forgeries_signature=[forgeries_signature filename];
        end
    end
    for m=1:5:25
% m=1;
        a=randperm(length(genuine_signature));
        b=randperm(length(forgeries_signature));
        fprintf(fid,'[%d]\n',(m+4)/5);
        fprintf(fid,'[TRAIN]\n');
        for i=1:length(genuine_signature)
            if a(i)<=5
                fprintf(fid,'%s%c%s\n',foldname,pathname_separator,cell2mat(genuine_signature(i)));
            end
        end
        for i=1:length(forgeries_signature)
            if a(i)>25
                fprintf(fid,'%s%c%s\n',foldname,pathname_separator,cell2mat(forgeries_signature(i)));
            end
        end
        
        fprintf(fid,'[TEST]\n');
%         for i=1:length(genuine_signature)
%             if a(i)>5
%                 fprintf(fid,'%s%c%s\t1.1\n',foldname,pathname_separator,cell2mat(genuine_signature(i)));
%             end
%         end
%         for i=1:length(forgeries_signature)
%             if a(i)<=25
%                 fprintf(fid,'%s%c%s\t0.1\n',foldname,pathname_separator,cell2mat(forgeries_signature(i)));
%             end
%         end
    end
    fclose(fid);
end
            
            
    

