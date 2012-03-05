function varargout = analysis_gui(varargin)
% ANALYSIS_GUI MATLAB code for analysis_gui.fig
%      ANALYSIS_GUI, by itself, creates a new ANALYSIS_GUI or raises the existing
%      singleton*.
%
%      H = ANALYSIS_GUI returns the handle to a new ANALYSIS_GUI or the handle to
%      the existing singleton*.
%
%      ANALYSIS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSIS_GUI.M with the given input arguments.
%
%      ANALYSIS_GUI('Property','Value',...) creates a new ANALYSIS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analysis_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analysis_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analysis_gui

% Last Modified by GUIDE v2.5 10-Mar-2011 13:23:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analysis_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @analysis_gui_OutputFcn, ...
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


% --- Executes just before analysis_gui is made visible.
function analysis_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analysis_gui (see VARARGIN)

% Choose default command line output for analysis_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analysis_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analysis_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.signature_1_name handles.signature_1_path]=uigetfile('*.txt');
set(handles.text1,'String',handles.signature_1_name);
handles.signature_1=importdata([handles.signature_1_path  handles.signature_1_name]);
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.signature_2_name handles.signature_2_path]=uigetfile('*.txt');
set(handles.text2,'String',handles.signature_2_name);
handles.signature_2=importdata([handles.signature_2_path handles.signature_2_name]);
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [sig_dis,path1,path2,dis_matrix,len,signature_1_speed,signature_2_speed,signature_1_dxdy,signature_2_dxdy]
[handles.sig_dis,handles.path1,handles.path2,handles.dis_matrix,handles.len,handles.signature_1_speed,handles.signature_2_speed,handles.signature_1_dxdy,handles.signature_2_dxdy]=DTWCompare(handles.signature_1,handles.signature_2);

set(handles.text3,'String',handles.sig_dis);

handles.signature_1_nor=handles.signature_1;
handles.signature_1_nor(:,1:2)=handles.signature_1(:,1:2)-repmat(min(handles.signature_1(:,1:2)),length(handles.signature_1),1)+repmat([100 100],length(handles.signature_1),1);
handles.signature_2_nor=handles.signature_2;
handles.signature_2_nor(:,1:2)=handles.signature_2(:,1:2)-repmat(min(handles.signature_2(:,1:2)),length(handles.signature_2),1)+repmat([100 100],length(handles.signature_2),1);
handles.signature_2_nor(:,2)=handles.signature_2_nor(:,2)+repmat(max(handles.signature_2_nor(:,2))+100,length(handles.signature_2_nor),1);


axes(handles.axes1);
cla reset
% plot(handles.signature_1(:,1),handles.signature_1(:,2),'r',handles.signature_2(:,1),handles.signature_2(:,2),'g');
% hold on
% for i=1:30:handles.len
%     line([handles.signature_1(handles.path1(i),1) handles.signature_2(handles.path2(i),1)],[handles.signature_1(handles.path1(i),2) handles.signature_2(handles.path2(i),2)]);
% end

plot(handles.signature_1_nor(:,1),handles.signature_1_nor(:,2),'r',handles.signature_2_nor(:,1),handles.signature_2_nor(:,2),'g');
hold on
for i=1:30:handles.len
    line([handles.signature_1_nor(handles.path1(i),1) handles.signature_2_nor(handles.path2(i),1)],[handles.signature_1_nor(handles.path1(i),2) handles.signature_2_nor(handles.path2(i),2)]);
end


axes(handles.axes2)
cla reset
plot(handles.dis_matrix(sub2ind(size(handles.dis_matrix),handles.path1(1:handles.len),handles.path2(1:handles.len))))

axes(handles.axes3)
plot(1:handles.len,handles.signature_1_speed(handles.path1(1:handles.len)),'r',1:handles.len,handles.signature_2_speed(handles.path2(1:handles.len)),'b');
legend('signature1','signature2');

axes(handles.axes4)
plot(1:handles.len,handles.signature_1_dxdy(handles.path1(1:handles.len),1),'r',1:handles.len,handles.signature_2_dxdy(handles.path2(1:handles.len),1),'b');

axes(handles.axes5)
plot(1:handles.len,handles.signature_1_dxdy(handles.path1(1:handles.len),2),'r',1:handles.len,handles.signature_2_dxdy(handles.path2(1:handles.len),2),'b');


if size(handles.signature_1,2)==4
    axes(handles.axes6)
    plot(handles.signature_1(handles.path1(1:handles.len),4)-handles.signature_2(handles.path2(1:handles.len),4));
    
    axes(handles.axes7)
    plot(1:handles.len,handles.signature_1(handles.path1(1:handles.len),4),'r',1:handles.len,handles.signature_2(handles.path2(1:handles.len),4),'b');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
