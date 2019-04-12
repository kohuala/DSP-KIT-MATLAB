% POLE-ZERO REAL TIME INTERACTIVE GUI
% Author: Guan, Huihua

function varargout = justsliders(varargin)
% JUSTSLIDERS MATLAB code for justsliders.fig
%      JUSTSLIDERS, by itself, creates a new JUSTSLIDERS or raises the existing
%      singleton*.
%
%      H = JUSTSLIDERS returns the handle to a new JUSTSLIDERS or the handle to
%      the existing singleton*.
%
%      JUSTSLIDERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JUSTSLIDERS.M with the given input arguments.
%
%      JUSTSLIDERS('Property','Value',...) creates a new JUSTSLIDERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before justsliders_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to justsliders_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help justsliders

% Last Modified by GUIDE v2.5 01-Oct-2016 22:30:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @justsliders_OpeningFcn, ...
                   'gui_OutputFcn',  @justsliders_OutputFcn, ...
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


% --- Executes just before justsliders is made visible.
function justsliders_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to justsliders (see VARARGIN)

% Choose default command line output for justsliders
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes justsliders wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = justsliders_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
% RADIUS
function slider1_Callback(hObject, eventdata, handles)
sliderValOne=get(handles.slider1, 'Value');
set(handles.edit1, 'String', num2str(sliderValOne));

% Get angle from user
getAngle = get(handles.slider2, 'Value');

% Set up the transfer function 
% Set up a= [1 a1 a2] and b=1

b=1;
a1= -2*sliderValOne*cos(getAngle);
a2= sliderValOne^2;
a= [1 a1 a2];

% Plot pole zero diagram
%%set(handles.axes1, 'zdata', zplane(b,a));
ax1= handles.axes1;
%plot(ax1, zplane(b,a));
zplane(b,a,ax1);
axis([-1.1 1.1 -1.1 1.1])


% Plot impulse response
x=[1 zeros(1,100-1)];
n=1:100;
y=filter(b,a,x);
%plot(handles.axes2,n,y);
ax2= handles.axes2;
plot(ax2,n, y);

 % Plot magnitude frequency response
[H,om]=freqz(b,a);
f=om/(2*pi);
%plot(handles.axes3, f, abs(H));
ax3=handles.axes3;
plot(ax3, f, abs(H));


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
% ANGLE
function slider2_Callback(hObject, eventdata, handles)
sliderValTwo=get(handles.slider2, 'Value');
set(handles.edit2,'String',num2str(sliderValTwo));

% GET RADIUS
getRadius = get(handles.slider1, 'Value');
% set up a= [1 a1 a2] and b=1
b=1;
a1= -2*getRadius*cos(sliderValTwo);
a2= getRadius^2;
a= [1 a1 a2];

% Plot pole zero diagram
%set(handles.axes1, 'zdata', zplane(b,a));
ax1= handles.axes1;
%plot(ax1, zplane(b,a));
zplane(b,a, ax1);
axis([-1.1 1.1 -1.1 1.1])
% plot impulse response
x=[1 zeros(1,100-1)];
n=1:100;
y=filter(b,a,x);
%%set(handles.axe2, 'ydata',y);
ax2= handles.axes2;
plot(ax2,n, y);
%axes(handles.axes2);
%plot(n,y);

% Plot magnitude frequency response
[H,om]=freqz(b,a);
f=om/(2*pi);
plot(handles.axes3,f, abs(H));

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
editVal1=get(handles.slider1, 'Value');
set(handles.edit1, 'String', num2str(editVal1));

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
editVal2=get(handles.slider2, 'Value');
set(handles.edit2, 'String', num2str(editVal2));

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
