clc
clear
path='/home/ksl/matlab/MCYT_Signature_100';
subfolders=GetSubfolderList(path);
for i=8:length(subfolders)
    cd(cell2mat(subfolders(i)));
    siglist=dir('*.fpg');
    for j=1:length(siglist)
    FPG_Signature_Read(siglist(j).name,1,0);
    end
end