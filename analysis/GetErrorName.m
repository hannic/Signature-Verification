function GetErrorName(argument1,argument2,index)
cd(argument1.path);
mkdir('ERR');
mkdir('RIGHT');
files=dir('*.txt');
for i=1:size(files,1)
    temp=importdata(files(i).name);
    cd('ERR');
    for j=1:size(temp.data,1)
        far_file=fopen([num2str(index) '_far.txt'],'a');
        frr_file=fopen([num2str(index) '_frr.txt'],'a');
        if temp.data(j,1)==1.1 && temp.data(j,index+1) > argument2.threshed_1(index)
            fprintf(far_file,'%s\t%s\n',cell2mat(temp.textdata(j,1)),cell2mat(temp.textdata(j,2)));
        elseif temp.data(j,1)==0.1 && temp.data(j,index+1) < argument2.threshed_1(index)
            fprintf(frr_file,'%s\t%s\n',cell2mat(temp.textdata(j,1)),cell2mat(temp.textdata(j,2)));
        end
        fclose(far_file);
        fclose(frr_file);
    end
    cd('..');
end

for i=1:size(files,1)
    temp=importdata(files(i).name);
    cd('RIGHT')
    for j=1:size(temp.data,1)
        far_file=fopen([num2str(index) '_far.txt'],'a');
        frr_file=fopen([num2str(index) '_frr.txt'],'a');
        if temp.data(j,1)==1.1 && temp.data(j,index+1) < argument2.threshed_1(index)
            fprintf(far_file,'%s\t%s\n',cell2mat(temp.textdata(j,1)),cell2mat(temp.textdata(j,2)));
        elseif temp.data(j,1)==0.1 && temp.data(j,index+1) > argument2.threshed_1(index)
            fprintf(frr_file,'%s\t%s\n',cell2mat(temp.textdata(j,1)),cell2mat(temp.textdata(j,2)));
        end
        fclose(far_file);
        fclose(frr_file);
    end
    cd('..');
end