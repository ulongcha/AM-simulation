function varargout = am(varargin)
% AM M-file for am.fig
%      AM, by itself, creates a new AM or raises the existing
%      singleton*.
%
%      H = AM returns the handle to a new AM or the handle to
%      the existing singleton*.
%
%      AM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AM.M with the given input arguments.
%
%      AM('Property','Value',...) creates a new AM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before am_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to am_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help am

% Last Modified by GUIDE v2.5 06-May-2019 18:51:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @am_OpeningFcn, ...
                   'gui_OutputFcn',  @am_OutputFcn, ...
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


% --- Executes just before am is made visible.
function am_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to am (see VARARGIN)

% Choose default command line output for am
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.axes1)
map1=imread('调制.jpg');
image(map1)
set(handles.axes1,'visible','off')

axes(handles.axes2)
map2=imread('解调.jpg');
image(map2)
set(handles.axes2,'visible','off')

axes(handles.axes3)
map3=imread('调制1.jpg');
image(map3)
set(handles.axes3,'visible','off')

axes(handles.axes4)
map4=imread('解调1.jpg');
image(map4)
set(handles.axes4,'visible','off')

% UIWAIT makes am wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = am_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)    %输入框范围判断
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
value = str2double(get(hObject, 'String'));   %将输入的字符串变成数字
if isnan(value)
    set(hObject, 'String', []);
    errordlg('参数无效!');
end
if or(value<500,value>1000)
    set(hObject, 'String', []);
    errordlg('超出频率变化范围','参数无效!');
end

if value>=500 && value <=1000
    set(handles.slider1,'value',value);
end


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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)  %拖动条
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'value');
set(handles.edit1,'string',num2str(val));
pushbutton1_Callback(hObject, eventdata, handles)  %调用start方法


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)  %自动变换
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = 0;

for i=500:10:1000
    set(handles.edit1,'string',num2str(i));
    pushbutton1_Callback(hObject, eventdata, handles)
    pause(0.05)
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)  %友好的交互方式
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ss=questdlg('是否确认退出？','退出程序','是，退出','否，返回程序','是，退出');
switch ss
    case '是，退出'
        delete(handles.figure1);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)    
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)  %查看当前调制解调函数
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc=str2num(get(handles.edit1,'String'));
option1=get(handles.radiobutton2,'value');
Fc=get(handles.edit1,'String');
Fs=4800;  %采样频率  
N=400;    %采样点
n=0:N-1; t=n/Fs;  %时间序列
%调制信号 
A1=1;   %调制信号振幅
f=n*Fs/N;  %频率

if (option1==0) 
    %改变载波信号
    Uct=['载波信号:uc=10*cos(2*pi*' Fc '*t)'];
    w1=2*100*pi; 
    mes=1+A1*cos(w1*t);   %100hz调制信号   
    C2=fft(mes);    %傅里叶变换
    zxc=abs(C2);         
    figure(1) 
    subplot(2,1,1); 
    plot(t,mes);
    title('调制信号:mes=1+cos(2*pi*100*t)');
    axis([0 0.035 0 2]);   
    subplot(2,1,2);  
    plot(f(1:N-1),zxc(1:N-1)); 
    title('调制信号频谱');
    axis([0 1000 0 200]);
    grid on
    %载波信号
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*fc*pi;  
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    figure(2) 
    subplot(2,1,1); 
    plot(t,Uc);
    title(Uct);
    axis([0 0.035 -10 10]);   
    subplot(2,1,2);  
    plot(f(1:N-1),cxf(1:N-1)); 
    title('载波信号频谱');
    axis([0 1000 0 2000]);
    grid on
else
    %调制信号
    Uct=['调制信号:mes=1+cos(2*pi' Fc '*t)'];
    w1=2*fc*pi; 
    mes=1+A1*cos(w1*t);   %100hz调制信号   
    C2=fft(mes);    %傅里叶变换
    zxc=abs(C2);         
    figure(1) 
    subplot(2,1,1); 
    plot(t,mes);
    title(Uct);
    axis([0 0.035 0 2]);   
    subplot(2,1,2);  
    plot(f(1:N-1),zxc(1:N-1)); 
    title('调制信号频谱');
    axis([0 1000 0 200]);
    grid on
    %载波信号
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*1000*pi;  
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    figure(2) 
    subplot(2,1,1); 
    plot(t,Uc);
    title('载波信号:uc=10*cos(2*pi*1000*t)');
    axis([0 0.035 -10 10]);   
    subplot(2,1,2);  
    plot(f(1:N-1),cxf(1:N-1)); 
    title('载波信号频谱');
    axis([0 1500 0 2000]);
    grid on
end
    
 

% --- Executes on button press in pushbutton1.  
function pushbutton1_Callback(hObject, eventdata, handles)  %主程序
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
fc=str2num(get(handles.edit1,'String'));
option=get(handles.radiobutton1,'value');
option1=get(handles.radiobutton2,'value');
Fc=num2str(fc);
if(option==0 && option1==0)
    Uct=['10*cos(2*pi*' Fc '*t)'];
    set(handles.text4,'String',Uct);
    %载波信号
    Fs=3400;
    N=400;
    n=0:N-1;t=n/Fs;
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*fc*pi;  
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    %调制信号
    Fs=3400;
    N=400;
    n=0:N-1;t=n/Fs;
    A1=1;
    fm=100;
    w1=2*fm*pi; 
    mes=1+A1*cos(w1*t);   %调制信号
    C2=fft(mes);
    zxc=abs(C2);         
    %调制
    Uam=modulate(mes,fc,Fs,'am');   %AM调制
    C3=fft(Uam);
    asd=abs(C3);
    Dam=demod(Uam,fc,Fs,'am');  %解调
    C4=fft(Dam);
    wqe=abs(C4); 
    axes(handles.axes1)
    axis([0 0.035 -2 2])
    plot(t,Uam);
    set(gca, 'XLim',[0 0.035]); 
    title('AM调制后时域信号'); 
    axes(handles.axes2)
    plot(f(1:N-1),asd(1:N-1));
    set(gca, 'YTick',[0,100,200,300] );
    set(gca, 'YLim',[0 300]);
    set(gca, 'XLim',[300 1200]); 
    set(gca, 'XTick',[400,600,800,1000,1200] );
    title('AM调制后频域信号');
    grid on
    axes(handles.axes3)
    plot(t,Dam);
    title('AM解调后时域信号');
    axis([0 0.035 0 1]); 
    axes(handles.axes4)
    plot(f(1:N-1),wqe(1:N-1)),grid;
    title('AM解调后频域信号'); 
    axis([0 1000 0 100])
elseif(option==1 && option1==0)
    Uct=['10*cos(2*pi*' Fc '*t)'];
    set(handles.text4,'String',Uct);
    %载波信号
    Fs=3400;
    N=400;
    n=0:N-1;t=n/Fs;
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*fc*pi;  
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    %调制信号
    Fs=3400;
    N=400;
    n=0:N-1;t=n/Fs;
    A1=1;
    fm=100;
    w1=2*fm*pi; 
    mes=1+A1*cos(w1*t);   %调制信号
    C2=fft(mes);
    zxc=abs(C2);         
    %调制
    Uam=modulate(mes,fc,Fs,'am');   %AM调制
    C3=fft(Uam);
    asd=abs(C3);
    Dam=demod(Uam,fc,Fs,'am');  %解调
    C4=fft(Dam);
    wqe=abs(C4); 
    %加噪声
    k=awgn(Uam,0.5);    %加噪声，信噪比为0.5
    pp=fft(k); 
    zs=abs(pp); 
    %加噪声后解调
    qaz=demod(k,fc,Fs,'am'); %解调
    wsx=fft(qaz);
    edc=abs(wsx);
    axes(handles.axes1)
    plot(t,k); 
    set(gca, 'YTick',[-3,-2,-1,0,1,2,3] ); 
    set(gca, 'YLim',[-3 3]);
    set(gca, 'XLim',[0 0.1]); 
    set(gca, 'XTick',[0,0.02,0.04,0.06,0.08,0.1] );    
    title('加噪声AM调制后时域信号'); 
    axes(handles.axes2)
    plot(f(1:N-1),zs(1:N-1));
    set(gca, 'YTick',[0,100,200,300] );
    set(gca, 'YLim',[0 300]); 
    set(gca, 'XLim',[300 1200]); 
    set(gca, 'XTick',[400,600,800,1000,1200] );
    title('加噪声AM调制后频域信号'); 
    grid on; 
    axes(handles.axes3)
    plot(t,qaz);
    title('加噪声AM解调后时域信号');
    axis([0 0.1 -0.5 1.5])
    axes(handles.axes4)
    plot(f(1:N-1),edc(1:N-1));
    title('加噪声AM解调后频域信号'); 
    axis([0 1000 0 100])
    grid on;
elseif(option==0 && option1==1)
    Uct=['1+cos(2*pi*' Fc '*t)'];
    set(handles.text4,'String',Uct);
    %载波信号
    Fs=4800;
    N=400;
    n=0:N-1;t=n/Fs;
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*1000*pi;   %载波信号频率固定1000hz
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    %调制信号
    Fs=4800;
    N=400;
    n=0:N-1;t=n/Fs;
    A1=1;
    fm=fc;
    w1=2*fm*pi; 
    mes=1+A1*cos(w1*t);   %调制信号
    C2=fft(mes);
    zxc=abs(C2);
    %调制
    Uam=modulate(mes,1000,Fs,'am');   %AM调制，频率固定1000hz
    C3=fft(Uam);
    asd=abs(C3);
    Dam=demod(Uam,1000,Fs,'am');  %解调，频率固定1000hz
    C4=fft(Dam);
    wqe=abs(C4); 
    axes(handles.axes1)
    axis([0 0.035 -2 2])
    plot(t,Uam);
    set(gca, 'XLim',[0 0.035]); 
    title('AM调制后时域信号'); 
    axes(handles.axes2)
    plot(f(1:N-1),asd(1:N-1));
    set(gca, 'YTick',[0,100,200,300] );
    set(gca, 'YLim',[0 300]);
    set(gca, 'XLim',[0 2000]); 
    title('AM调制后频域信号');
    grid on
    axes(handles.axes3)
    plot(t,Dam);
    title('AM解调后时域信号');
    axis([0 0.035 0 1]); 
    axes(handles.axes4)
    plot(f(1:N-1),wqe(1:N-1)),grid;
    title('AM解调后频域信号'); 
    axis([0 1000 0 100])
elseif(option==1 && option1==1)
    Uct=['1+cos(2*pi*' Fc '*t)'];
    set(handles.text4,'String',Uct);
    %载波信号
    Fs=4800;
    N=400;
    n=0:N-1;t=n/Fs;
    A0=10;  %载波信号振幅
    f=n*Fs/N;
    w0=2*1000*pi;   %载波信号频率固定1000hz
    Uc=A0*cos(w0*t);     %载波信号
    C1=fft(Uc);     %傅里叶变换
    cxf=abs(C1);
    %调制信号
    Fs=4800;
    N=400;
    n=0:N-1;t=n/Fs;
    A1=1;
    fm=fc;
    w1=2*fm*pi; 
    mes=1+A1*cos(w1*t);   %调制信号
    C2=fft(mes);
    zxc=abs(C2);         
    %调制
    Uam=modulate(mes,1000,Fs,'am');   %AM调制，频率固定1000hz
    C3=fft(Uam);
    asd=abs(C3);
    Dam=demod(Uam,1000,Fs,'am');  %解调，频率固定1000hz
    C4=fft(Dam);
    wqe=abs(C4); 
    %加噪声
    k=awgn(Uam,0.5);    %加噪声，信噪比为0.5
    pp=fft(k); 
    zs=abs(pp); 
    %加噪声后解调
    qaz=demod(k,1000,Fs,'am'); %解调，频率固定1000hz
    wsx=fft(qaz);
    edc=abs(wsx);
    axes(handles.axes1)
    plot(t,k); 
    set(gca, 'YTick',[-3,-2,-1,0,1,2,3] ); 
    set(gca, 'YLim',[-3 3]);
    set(gca, 'XLim',[0 0.08]); 
    title('加噪声AM调制后时域信号'); 
    axes(handles.axes2)
    plot(f(1:N-1),zs(1:N-1));
    set(gca, 'YTick',[0,100,200,300] );
    set(gca, 'YLim',[0 300]); 
    set(gca, 'XLim',[0 2000]); 
    title('加噪声AM调制后频域信号'); 
    grid on; 
    axes(handles.axes3)
    plot(t,qaz);
    title('加噪声AM解调后时域信号');
    axis([0 0.08 -0.5 1.5])
    axes(handles.axes4)
    plot(f(1:N-1),edc(1:N-1));
    title('加噪声AM解调后频域信号'); 
    axis([0 1000 0 100])
    grid on;
end



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4
