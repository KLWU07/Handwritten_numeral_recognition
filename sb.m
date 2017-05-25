function varargout = sb(varargin)
% SB MATLAB code for sb.fig
%      SB, by itself, creates a new SB or raises the existing
%      singleton*.
%
%      H = SB returns the handle to a new SB or the handle to
%      the existing singleton*.
%
%      SB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SB.M with the given input arguments.
%
%      SB('Property','Value',...) creates a new SB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sb

% Last Modified by GUIDE v2.5 14-Feb-2017 18:14:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sb_OpeningFcn, ...
                   'gui_OutputFcn',  @sb_OutputFcn, ...
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


% --- Executes just before sb is made visible.
function sb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sb (see VARARGIN)

% Choose default command line output for sb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dos('%SystemRoot%\system32\mspaint.exe sb.bmp');

% --- Executes on button press in jzbutton.
function jzbutton_Callback(hObject, eventdata, handles)
% hObject    handle to jzbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global jzsj
jzsj=load('CNN_5');%jzsj为加载数据
msgbox('数据加载成功','加载');
set(handles.zdbutton,'enable','on');
set(handles.jzbutton,'enable','off');

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zdbutton.
function zdbutton_Callback(hObject, eventdata, handles)
% hObject    handle to zdbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

t= timer('TimerFcn',{@timerf,handles}, 'Period', 10,'ExecutionMode','fixedDelay');
start(t)

set(handles.zdbutton,'enable','off');
set(handles.tzbutton,'enable','on');

function timerf(hObject, eventdata, handles)
global jzsj  %jzsj 加载数据
x1=imread('sb.bmp');
x1=~x1;
x1=x1';
x1=imresize(x1,1/10);
xx=[x1 x1 x1 x1 x1 x1 x1 x1 x1 x1];
xx=double(xx);
xx=reshape(xx,28,28,10);
[er, bad]  = cnntest(jzsj.cnn, xx, jzsj.yy);
if(length(bad)==10)
    set(handles.edit1,'string','无法识别');
else
    for i=1:10
       if length(find(bad==i))==0
            set(handles.edit1,'string',num2str(i-1));
       end
    end
end
axes(handles.axes1);%axes1是坐标轴的标示
imshow(~x1');

set(handles.text3,'string','正在识别中，请稍等.....');

% --- Executes on button press in tzbutton.
function tzbutton_Callback(hObject, eventdata, handles)
% hObject    handle to tzbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.t=timerfind;
stop(handles.t)
set(handles.text3,'string','         ');
set(handles.zdbutton,'enable','on');%开始识别按钮可用
set(handles.tzbutton,'enable','off');%停止识别按钮失效

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
