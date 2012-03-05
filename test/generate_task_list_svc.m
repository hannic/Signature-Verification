clc;
clear;
close all;
task_path='/home/ksl/SVC/task';
data_path1='/home/ksl/SVC/Task1';
for i=1:40
    fid=fopen([task_path '/' num2str(i) '.txt'],'w');
    for j=1:5:20
        fprintf(fid,'[%d]\n',(j+4)/5);
        fprintf(fid,'[TRAIN]\n');
        for m=j:j+4
            fprintf(fid,'%s/U%dS%d.TXT\n',data_path1,i,m);
        end
        fprintf(fid,'[TEST]\n');
        for m=1:j-1
            fprintf(fid,'%s/U%dS%d.TXT\t1.1\n',data_path1,i,m);
        end
        for m=j+5:20
            fprintf(fid,'%s/U%dS%d.TXT\t1.1\n',data_path1,i,m);
        end
        for m=21:40
            fprintf(fid,'%s/U%dS%d.TXT\t0.1\n',data_path1,i,m);
        end
    end
fclose(fid);
end
