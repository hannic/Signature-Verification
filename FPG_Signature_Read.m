function [x,y,z,az,in,pps]=FPG_Signature_Read(filename, showXY, showWV)
%function [x,y,z,az,in,pps]=readsig(filename, showXY, showWV)
%
%PARAMETERS:
%filename -> Name of the .fpg file
%showXY   -> Set this parameter to '1' to show XY signature image (Handritten image).
%showWV   -> Set this parameter to '1' to show signature parameter waveforms.
%
%
%RESULTS:
%x   -> X coordinate sequence.             Original Range -> [0 - 12699]
%y   -> Y coordinate sequence.             Original Range -> [0 - 9649]
%z   -> Pressure coordinate sequence.      Range -> [0 - 1024]
%az  -> Pen Azimuth coordinate sequence.   Range -> [0 - 360]
%in  -> Pen Elevation coordinate sequence. Range -> [0 - 90]
%pps -> Sampling rate (Points Per Second).
%
%
%NOTE:
%In the database provided with this M-file, X and Y coordinates have been normalized
%in order to force the begining of each signature at (X,Y)=(0,0) coordinate.
%Due to this, current XY range is not the one shown above
%
%-----------------------------------------------------------------
% Area de Tratamiento de Voz y Señales (www.atvs.diac.upm.es)
% Dpto. Ing. Audiovisual y Comunicaciones
% UPM - Universidad Politecnica de Madrid
%
% Copyright ATVS. All rights reserved.
% December 2003
%-----------------------------------------------------------------

vectores=0;nvectores=0;mvector=0;res=0;fs=0;coef=0;format=0;mod=0;nc=0;
Fs=0;
f=fopen(filename,'rb');
id=fread(f,4,'char');
if (id(1)~=70)|(id(2)~=80)|(id(3)~=71)|(id(4)~=32)
   'Error: The file is not FPG'
   return
end
hsize=fread(f,1,'uint16');
ver=1;
if (hsize==48)|(hsize==60)
   ver=2;
end
%fseek(f,6,'bof');
format=fread(f,1,'uint16');
if(format==4)
	m=fread(f,1,'uint16');
	can=fread(f,1,'uint16');
	%fseek(f,2,'cof');

	Ts=fread(f,1,'uint32');
	res=fread(f,1,'uint16');
	fseek(f,4,'cof');
	coef=fread(f,1,'uint32');
	mvector=fread(f,1,'uint32');
	nvectores=fread(f,1,'uint32');
	nc=fread(f,1,'uint16');
	if ver==2
	   Fs=fread(f,1,'uint32');
	   mventana=fread(f,1,'uint32');
	   msolapadas=fread(f,1,'uint32');
	end
	fseek(f,hsize-12,'bof');
	datos = fread(f, 1, 'uint32');
	delta = fread(f, 1, 'uint32');
	ddelta = fread(f, 1, 'uint32');

	fseek(f,hsize,'bof');
	if res==8
	   string='uint8';
	elseif res==16
	   string='int16';
	elseif res==32
	   string='float32';
	else
	   string='float64';
	end

	tam_tot=nvectores*can*mvector; 
	temp=fread(f,tam_tot,string);

	h=1;
	vectores=zeros(nvectores,mvector);
	for i=1:nvectores,
	      for m=1:mvector
	         vectores(i,m)=temp(h);
	         h=h+1;
	      end   
	end
else
   vectores = zeros(0,0);
end
fclose(f);  

x = vectores(:,1);
y = vectores(:,2);
z = vectores(:,3);
az = vectores(:,4);
in = vectores(:,5);
pps = Fs;

if(showXY==1)
	figure;
	p0 = min(vectores(:, 3));
	ind_p0 = find(vectores(:, 3)==p0);
	vnan = ones(length(ind_p0), 1)*nan;
    x = vectores(:,1);
    x2 = x;
	x2(ind_p0, 1) = vnan;
    y = vectores(:,2);
    y2 = y;
	y2(ind_p0, 1) = vnan;
    alto=max(y2)-min(y2);
    ancho=max(x2)-min(x2);
    relacion=alto/ancho;
	plot(x2, y2, 'k', 'LineWidth', 2);
    grid off;
    set(gca,'YTickLabel',[])
    set(gca,'YTick',[])
    set(gca,'XTickLabel',[])
    set(gca,'XTick',[])
    %set(gcf,'Position',[200 200 200+100*relacion 300])
    set(gca,'Position',[0.05 0.05 .9 .9])
    title(filename);
    clear x2;
    clear y2;
end
clear vectores;

if(showWV==1)
	figure;
	title(filename);
	l = length(x);
	subplot(5,1,1);
	plot(x), grid on; ylabel('X');
	axis([0 l min(x) max(x)]);
	subplot(5,1,2);
	plot(y), grid on; ylabel('Y');
	axis([0 l min(y) max(y)]);
	subplot(5,1,3);
	plot(z), grid on; ylabel('Pressure');
	axis([0 l min(z) max(z)]);
	subplot(5,1,4);
	plot(az), grid on; ylabel('Azimuth');
	axis([0 l min(az) max(az)]);
	subplot(5,1,5);
	plot(in), grid on; ylabel('Elevation');
   axis([0 l min(in) max(in)]);
end
