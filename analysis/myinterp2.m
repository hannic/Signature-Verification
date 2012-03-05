% image=imread('d:\S1001L01.jpg');
polar_array0=zeros(20,240);
% xo=importdata('d:\xo_opencv');
% yo=importdata('d:\yo_opencv');
for i=1:size(polar_array0,1)
    for j=1:size(polar_array0,2)
%         if xo(i,j)~=floor(xo(i,j))&&yo(i,j)~=yo(i,j)
%             xo(i,j)
%             yo(i,j)
%             floor(yo(i,j))
%             floor(xo(i,j))
%             (ceil(yo(i,j))-yo(i,j))
%             (ceil(xo(i,j))-xo(i,j))
%             image(floor(yo(i,j)),floor(xo(i,j)))*(ceil(yo(i,j))-yo(i,j))*(ceil(xo(i,j))-xo(i,j))
%             floor(yo(i,j))
%             ceil(xo(i,j))
%             ceil(yo(i,j))-yo(i,j)
%             xo(i,j)-floor(xo(i,j))
%             image(floor(yo(i,j)),ceil(xo(i,j)))*(ceil(yo(i,j))-yo(i,j))*(xo(i,j)-floor(xo(i,j)))
%             ceil(yo(i,j))
%             floor(xo(i,j))
%             (yo(i,j)-floor(yo(i,j)))
%             (ceil(xo(i,j))-xo(i,j))
%             image(ceil(yo(i,j)),floor(xo(i,j)))*(yo(i,j)-floor(yo(i,j)))*(ceil(xo(i,j))-xo(i,j))
%             ceil(yo(i,j))
%             ceil(xo(i,j))
%             (yo(i,j)-floor(yo(i,j)))
%             (xo(i,j)-floor(xo(i,j)))
%             image(ceil(yo(i,j)),ceil(xo(i,j)))*(yo(i,j)-floor(yo(i,j)))*(xo(i,j)-floor(xo(i,j)))
            polar_array0(i,j)=...
                image(floor(yo(i,j)),floor(xo(i,j)))*(ceil(yo(i,j))-yo(i,j))*(ceil(xo(i,j))-xo(i,j))+...
                image(floor(yo(i,j)),ceil(xo(i,j)))*(ceil(yo(i,j))-yo(i,j))*(xo(i,j)-floor(xo(i,j)))+...
                image(ceil(yo(i,j)),floor(xo(i,j)))*(yo(i,j)-floor(yo(i,j)))*(ceil(xo(i,j))-xo(i,j))+...
                image(ceil(yo(i,j)),ceil(xo(i,j)))*(yo(i,j)-floor(yo(i,j)))*(xo(i,j)-floor(xo(i,j)));
%         elseif xo(i,j)~=floor(xo(i,j))
%             image(uint8(yo(i,j)),floor(xo(i,j)))
%             uint8(yo(i,j))
%             floor(xo(i,j))
%             (ceil(xo(i,j))-xo(i,j))
%             image(uint8(yo(i,j)),floor(xo(i,j)))*(ceil(xo(i,j))-xo(i,j))
%             image(uint8(yo(i,j)),ceil(xo(i,j)))
%             uint8(yo(i,j))
%             ceil(xo(i,j))
%             (xo(i,j)-floor(xo(i,j)))
%             image(uint8(yo(i,j)),ceil(xo(i,j)))*(xo(i,j)-floor(xo(i,j)))
%             polar_array0(i,j)=...
%                 image(uint8(yo(i,j)),floor(xo(i,j)))*(ceil(xo(i,j))-xo(i,j))+...
%                 image(uint8(yo(i,j)),ceil(xo(i,j)))*(xo(i,j)-floor(xo(i,j)));
%         elseif yo(i,j)~=floor(yo(i,j))
%             polar_array0(i,j)=...
%                 image(floor(yo(i,j)),uint8(xo(i,j)))*(ceil(yo(i,j))-yo(i,j))+...
%                 image(ceil(yo(i,j)),uint8(xo(i,j)))*(yo(i,j)-floor(yo(i,j)));
%         else
%             polar_array0(i,j)=image(uint8(yo(i,j)),uint8(xo(i,j)));
%         end
%         
%         if polar_array0(i,j)-polar_array(i,j)>1
%            i 
%            j
%         end
            
        
    end
end


% polar_array=interp2(double(image),xo,yo);
surf(polar_array-polar_array0)