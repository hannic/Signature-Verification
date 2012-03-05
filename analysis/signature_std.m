function varargout = signature_std(varargin)
% SIGNATURE_STD MATLAB code for signature_std.fig
%      SIGNATURE_STD, by itself, creates a new SIGNATURE_STD or raises the existing
%      singleton*.
%
%      H = SIGNATURE_STD returns the handle to a new SIGNATURE_STD or the handle to
%      the existing singleton*.
%
%      SIGNATURE_STD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNATURE_STD.M with the given input arguments.
%
%      SIGNATURE_STD('Property','Value',...) creates a new SIGNATURE_STD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signature_std_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signature_std_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signature_std

% Last Modified by GUIDE v2.5 09-May-2011 08:04:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signature_std_OpeningFcn, ...
                   'gui_OutputFcn',  @signature_std_OutputFcn, ...
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


% --- Executes just before signature_std is made visible.
function signature_std_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signature_std (see VARARGIN)

% Choose default command line output for signature_std
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signature_std wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signature_std_OutputFcn(hObject, eventdata, handles) 
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
[tempalte_name template_path template_index]=uigetfile({'*.txt';'*.fpg'},'MultiSelect', 'on');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.test_name handles.test_path handles.test_index]=uigetfile({'*.txt';'*.fpg'},'MultiSelect', 'on');
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TaskArgument.data_type=2;
TaskArgument.hidden=1;
TaskArgument.iterations=1;
TaskArgument.normalization_type=1;
TaskArgument.Mah_type_diag=0;
TaskArgument.distance=1;
TaskArgument.dtw_type_train=2;
TaskArgument.dtw_type_test=3;
TaskArgument.slope=3;
TaskArgument.Mah_type=1;
TaskArgument.alpha=0.01;
TaskArgument.DTW_feature=2:5;
TaskArgument.select_feature=2:5;
TrainSignature={};
for i=1:5
    TrainSignature=[TrainSignature Signature_Read([handles.test_path cell2mat(handles.test_name(i))],TaskArgument)];
end
TrainArgument=TrainArgumentComputer(TrainSignature,TaskArgument);
axes(handles.axes1)
plot(cell2mat(TrainArgument.TrainSignatureWeigthPath_1(1)));
axes(handles.axes2)
plot(cell2mat(TrainArgument.TrainSignatureWeigthPath_1(2)));
axes(handles.axes3)
plot(cell2mat(TrainArgument.TrainSignatureWeigthPath_1(3)));
axes(handles.axes4)
plot(cell2mat(TrainArgument.TrainSignatureWeigthPath_1(4)));
axes(handles.axes5)
plot(cell2mat(TrainArgument.TrainSignatureWeigthPath_1(5)));
guidata(hObject, handles);
