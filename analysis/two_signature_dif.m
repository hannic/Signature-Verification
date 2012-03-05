function varargout = two_signature_dif(varargin)
% TWO_SIGNATURE_DIF MATLAB code for two_signature_dif.fig
%      TWO_SIGNATURE_DIF, by itself, creates a new TWO_SIGNATURE_DIF or raises the existing
%      singleton*.
%
%      H = TWO_SIGNATURE_DIF returns the handle to a new TWO_SIGNATURE_DIF or the handle to
%      the existing singleton*.
%
%      TWO_SIGNATURE_DIF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_SIGNATURE_DIF.M with the given input arguments.
%
%      TWO_SIGNATURE_DIF('Property','Value',...) creates a new TWO_SIGNATURE_DIF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_signature_dif_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_signature_dif_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_signature_dif

% Last Modified by GUIDE v2.5 12-May-2011 14:13:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @two_signature_dif_OpeningFcn, ...
    'gui_OutputFcn',  @two_signature_dif_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before two_signature_dif is made visible.
function two_signature_dif_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_signature_dif (see VARARGIN)

% Choose default command line output for two_signature_dif
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_signature_dif wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_signature_dif_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[signature_name path]=uigetfile({'*.fpg','*.txt'});
set(handles.text1,'String',['RED:' signature_name]);

handles.TaskArgument.data_type=2;
handles.TaskArgument.hidden=1;
handles.TaskArgument.iterations=1;
handles.TaskArgument.normalization_type=1;
handles.TaskArgument.Mah_type_diag=0;
handles.TaskArgument.distance=1;
handles.TaskArgument.dtw_type_train=2;
handles.TaskArgument.dtw_type_test=2;
handles.TaskArgument.slope=3;
handles.TaskArgument.Mah_type=1;
handles.TaskArgument.alpha=0.01;
handles.TaskArgument.DTW_feature=2:5;
handles.TaskArgument.select_feature=2:5;
handles.TaskArgument.dis_type=1;
handles.TaskArgument.dtw_type=2;

handles.signature1=Signature_Read([path signature_name],handles.TaskArgument);
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[signature_name path]=uigetfile({'*.fpg','*.txt'});
set(handles.text2,'String',['BLUE:' signature_name]);

handles.signature2=Signature_Read([path signature_name],handles.TaskArgument);
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.DTW_result=DTWCompare(handles.signature1,handles.signature2,handles.TaskArgument);
handles.signature1(:,1)=handles.signature1(:,1)-min(handles.signature1(:,1))+50;
handles.signature1(:,2)=handles.signature1(:,2)-min(handles.signature1(:,2))+50;
handles.signature2(:,1)=handles.signature2(:,1)-min(handles.signature2(:,1))+50;
handles.signature2(:,2)=handles.signature2(:,2)-min(handles.signature2(:,2))+50+max(handles.signature1(:,2));
% axes()
plot(handles.axes1,handles.signature1(:,1),handles.signature1(:,2),'r',handles.signature2(:,1),handles.signature2(:,2),'b')
axes(handles.axes1)
for i=1:20:handles.DTW_result.len
    line([handles.signature1(handles.DTW_result.path1(i),1) handles.signature2(handles.DTW_result.path2(i),1)],[handles.signature1(handles.DTW_result.path1(i),2) handles.signature2(handles.DTW_result.path2(i),2)],'Color','k');
end
%1 x   -> X coordinate sequence.
%2 y   -> Y coordinate sequence.
%3 dx
%4 dy
%5 pressure   -> Pressure coordinate sequence.
%6 dp
%7 arg1  -> Pen Azimuth coordinate sequence.
%8 arg2  -> Pen Elevation coordinate sequence.
%9 darg1
%10 darg2
%11 theta=arctan(dy/dx)
%12 speed=(dx^2+dy^2)^0.5
%13 rho=log(speed/d(theta))
%14 alpha=((d(speed))^2+(speed*d(theta))^2)^0.5
handles.data_type={'x','y','dx','dy','pressure','dp','arg1','arg2','darg1','darg2','theta','speed','rho','alpha'};
index=2;
for i=1:7
    axes_name=['handles.axes' num2str(index)];
    index=index+1;
        axes(eval(axes_name))
    plot(1:handles.DTW_result.len,handles.DTW_result.signature_1_local_feature(handles.DTW_result.path1(1:handles.DTW_result.len),i),'r',...
        1:handles.DTW_result.len,handles.DTW_result.signature_2_local_feature(handles.DTW_result.path2(1:handles.DTW_result.len),i),'b');
    title(handles.data_type(i));
end


guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.x=[];
handles.y=[];
[handles.x handles.y]=ginput;


if size(handles.x,1)==1
    
    axes(handles.axes1);
    plot(handles.signature1(:,1),handles.signature1(:,2),'r',handles.signature2(:,1),handles.signature2(:,2),'b')
    for i=1:20:handles.DTW_result.len
        line([handles.signature1(handles.DTW_result.path1(i),1) handles.signature2(handles.DTW_result.path2(i),1)],...
            [handles.signature1(handles.DTW_result.path1(i),2) handles.signature2(handles.DTW_result.path2(i),2)],'Color','k');
    end
    hold on
    plot(handles.signature1(handles.DTW_result.path1(floor(handles.x(1))),1),handles.signature1(handles.DTW_result.path1(floor(handles.x(1))),2),'r*',...
        handles.signature2(handles.DTW_result.path2(floor(handles.x(1))),1),handles.signature2(handles.DTW_result.path2(floor(handles.x(1))),2),'bo')
    hold off
    index=2;
    for i=8:14
        axes_name=['handles.axes' num2str(index)];
        index=index+1;
        axes(eval(axes_name));
        plot(1:handles.DTW_result.len,handles.DTW_result.signature_1_local_feature(handles.DTW_result.path1(1:handles.DTW_result.len),i),'r',...
            1:handles.DTW_result.len,handles.DTW_result.signature_2_local_feature(handles.DTW_result.path2(1:handles.DTW_result.len),i),'b');
        hold on;
        plot(floor(handles.x(1)),handles.DTW_result.signature_1_local_feature(handles.DTW_result.path1(floor(handles.x(1))),i),'r*',...
            floor(handles.x(1)),handles.DTW_result.signature_2_local_feature(handles.DTW_result.path2(floor(handles.x(1))),i),'bo');
        title(handles.data_type(i));
        hold off;
    end
elseif mod(size(handles.x,1),2)==0
    
    axes(handles.axes1)
    plot(handles.signature1(:,1),handles.signature1(:,2),'r',handles.signature2(:,1),handles.signature2(:,2),'b')
    for i=1:20:handles.DTW_result.len
        line([handles.signature1(handles.DTW_result.path1(i),1) handles.signature2(handles.DTW_result.path2(i),1)],...
            [handles.signature1(handles.DTW_result.path1(i),2) handles.signature2(handles.DTW_result.path2(i),2)],'Color','k');
    end
    hold on
    for i=1:2:size(handles.x,1)-1
        plot(handles.signature1(handles.DTW_result.path1(floor(handles.x(i)):ceil(handles.x(i+1))),1),handles.signature1(handles.DTW_result.path1(floor(handles.x(i)):ceil(handles.x(i+1))),2),'r',...
            handles.signature2(handles.DTW_result.path2(floor(handles.x(i)):ceil(handles.x(i+1))),1),handles.signature2(handles.DTW_result.path2(floor(handles.x(i)):ceil(handles.x(i+1))),2),'b','Linewidth',4);
    end
    hold off
    
    
    index=2;
    
    for j=8:14
        
        axes_name=['handles.axes' num2str(index)];
        index=index+1;
        axes(eval(axes_name));
        plot(1:handles.DTW_result.len,handles.DTW_result.signature_1_local_feature(handles.DTW_result.path1(1:handles.DTW_result.len),j),'r',...
            1:handles.DTW_result.len,handles.DTW_result.signature_2_local_feature(handles.DTW_result.path2(1:handles.DTW_result.len),j),'b');
        hold on
        for i=1:2:size(handles.x,1)-1
            plot(floor(handles.x(i)):ceil(handles.x(i+1)),handles.DTW_result.signature_1_local_feature(handles.DTW_result.path1(floor(handles.x(i)):ceil(handles.x(i+1))),j),'r',...
                floor(handles.x(i)):ceil(handles.x(i+1)),handles.DTW_result.signature_2_local_feature(handles.DTW_result.path2(floor(handles.x(i)):ceil(handles.x(i+1))),j),'b','LineWidth',4);
        end
        hold off
        title(handles.data_type(i));
    end
    
    
end
guidata(hObject,handles);
