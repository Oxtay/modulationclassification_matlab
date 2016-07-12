function varargout = digital_modulation(varargin)
%DIGITAL_MODULATION 
%Author: Diego Orlando Barragán Guerrero
%diegokillemall@yahoo.com
%Private Technical University of Loja (Ecuador)
%Last Modified by GUIDE v2.5 25-Jan-2007 22:07:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digital_modulation_OpeningFcn, ...
                   'gui_OutputFcn',  @digital_modulation_OutputFcn, ...
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


% --- Executes just before digital_modulation is made visible.
function digital_modulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digital_modulation (see VARARGIN)
        hold off;
        axes(handles.axes1);
        h=[1 1 0 1 0 0 1 1 1 0];
        hold off;
        bit=[];
        for n=1:2:length(h)-1;
            if h(n)==0 & h(n+1)==1
                se=[zeros(1,50) ones(1,50)];
            elseif h(n)==0 & h(n+1)==0
                se=[zeros(1,50) zeros(1,50)];
            elseif h(n)==1 & h(n+1)==0
                se=[ones(1,50) zeros(1,50)];
            elseif h(n)==1 & h(n+1)==1
                se=[ones(1,50) ones(1,50)];
            end
            bit=[bit se];
        end
        plot(bit,'LineWidth',1.5);grid on;
        axis([0 500 -1.5 1.5]);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
        axes(handles.axes3)
        hold off;
        fc=30;
        g=[1 1 0 1 0 0 1 1 1 0]; %modulante
        n=1;
    while n<=length(g)
        if g(n)==0
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        else 
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(2)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        end
            n=n+1;
            
    end

% Choose default command line output for digital_modulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes digital_modulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = digital_modulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in random.
function random_Callback(hObject, eventdata, handles)
% hObject    handle to random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=round(rand(1,10)); %genarar bits aleatorios
ran=[a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),a(9),a(10)];
set(handles.bit1,'String',ran(1));
set(handles.bit2,'String',ran(2));
set(handles.bit3,'String',ran(3));
set(handles.bit4,'String',ran(4));
set(handles.bit5,'String',ran(5));
set(handles.bit6,'String',ran(6));
set(handles.bit7,'String',ran(7));
set(handles.bit8,'String',ran(8));
set(handles.bit9,'String',ran(9));
set(handles.bit10,'String',ran(10));

%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
handles.bits=ran;

h=handles.bits;
axes(handles.axes1)
hold off;
bit=[];
for n=1:2:length(h)-1;
    if h(n)==0 & h(n+1)==1
        se=[zeros(1,50) ones(1,50)];
    elseif h(n)==0 & h(n+1)==0
        se=[zeros(1,50) zeros(1,50)];
    elseif h(n)==1 & h(n+1)==0
        se=[ones(1,50) zeros(1,50)];
    elseif h(n)==1 & h(n+1)==1
        se=[ones(1,50) ones(1,50)];
    end
   
    bit=[bit se];
end
plot(bit,'LineWidth',1.5);grid on;
axis([0 500 -1.5 1.5]);

%*-*-*-*-*-*-*-*-*-*-*-*-
hold off;
axes(handles.axes3);
cod=get(handles.select_mod,'Value');
switch cod
%*-*-*-*Modulation ASK*-*-*-*-*-*-*-*-*
    case 1
        hold off;
        axes(handles.axes3)
        fc=30;
        g=handles.bits; %modulante
        n=1;
    while n<=length(g)
        if g(n)==0
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
%    axis([0 n*2/fc -3 3]);
        else 
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(2)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        end
            n=n+1;
    end
    
%*-*-*-*-*-*-*-Modulation OOK*-*-*-*-*-*-*-*-*-
    case 2
        hold off;
        axes(handles.axes3);
        t=0:0.001:1;
        m=1;
        fc=30;
        g=handles.bits; %modulante
        n=1;
        while n<=length(g)
            tx=(n-1)*1/length(g):0.001:n*1/length(g);
            p=(g(n))*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);
            hold on;
            axis([0 (n)*1/length(g) -1.5 1.5]);
            grid on;
            n=n+1;
        end
%*-*-*-*-*-*-*-Modulation BPSK*-*-*-*-*-*-*-*-*-*-*-
    case 3
        axes(handles.axes3)
        hold off;
        g=handles.bits;
        fc=10;
        n=1;
    while n<=length(g)
        if g(n)==0 %0 is -1
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(-1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        else
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        end
        n=n+1;
    end
    
%*-*-*-*-*-Modulation QPSK-*-*-*-*-*
    case 4
        axes(handles.axes3)
        hold off;
        g=handles.bits;
        t=0:2*pi/99:2*pi;
        cp=[];sp=[];
        mod=[];mod1=[];
        for n=1:2:9;
            if g(n)==0 & g(n+1)==1;
                die=sqrt(2)/2*ones(1,100);
                die1=-sqrt(2)/2*ones(1,100);
            elseif g(n)==0 & g(n+1)==0;
                die=-sqrt(2)/2*ones(1,100);
                die1=-sqrt(2)/2*ones(1,100);
            elseif g(n)==1 & g(n+1)==0;
                die=-sqrt(2)/2*ones(1,100);
                die1=sqrt(2)/2*ones(1,100);
            elseif g(n)==1 & g(n+1)==1;
                die=sqrt(2)/2*ones(1,100);
                die1=sqrt(2)/2*ones(1,100);
            end
        
            c=cos(t);
            s=sin(t);
            cp=[cp die];    %Amplitude cosino
            sp=[sp die1];   %Amplitude sino
            mod=[mod c];    %cosino carrier (Q)
            mod1=[mod1 s];  %sino carrier   (I)
        end
        bpsk=cp.*mod+sp.*mod1;
        plot(bpsk,'LineWidth',1.5);grid on;
        title('QPSK modulation')
        axis([0 500 -1.5 1.5]); 

%-*-*-*-*Modulation 8PSK*-*-*-*-*-*-*-
    case    5
        axes(handles.axes3)
        hold off;
        g=[handles.bits 0 0];
        t=0:2*pi/149:2*pi;
        cp=[];sp=[];
        mod=[];mod1=[];bit=[];
for n=1:3:length(g);
    if g(n)==0 & g(n+1)==1 & g(n+2)==1
        die=cos(pi/8)*ones(1,150);
        die1=sin(pi/8)*ones(1,150);
        se=[zeros(1,50) ones(1,50) ones(1,50)];
        
    elseif g(n)==0 & g(n+1)==1 & g(n+2)==0
        die=cos(3*pi/8)*ones(1,150);
        die1=sin(3*pi/8)*ones(1,150);
        se=[zeros(1,50) ones(1,50) zeros(1,50)];
        
    elseif g(n)==0 & g(n+1)==0  & g(n+2)==0
        die=cos(5*pi/8)*ones(1,150);
        die1=sin(5*pi/8)*ones(1,150);
        se=[zeros(1,50) zeros(1,50) zeros(1,50)];
        
    elseif g(n)==0 & g(n+1)==0  & g(n+2)==1
        die=cos(7*pi/8)*ones(1,150);
        die1=sin(7*pi/8)*ones(1,150);
        se=[zeros(1,50) zeros(1,50) ones(1,50)];
        
    elseif g(n)==1 & g(n+1)==0  & g(n+2)==1
        die=cos(-7*pi/8)*ones(1,150);
        die1=sin(-7*pi/8)*ones(1,150);
        se=[ones(1,50) zeros(1,50) ones(1,50)];
        
    elseif g(n)==1 & g(n+1)==0  & g(n+2)==0
        die=cos(-5*pi/8)*ones(1,150);
        die1=sin(-5*pi/8)*ones(1,150);
        se=[ones(1,50) zeros(1,50) zeros(1,50)];
        
    elseif g(n)==1 & g(n+1)==1  & g(n+2)==0
        die=cos(-3*pi/8)*ones(1,150);
        die1=sin(-3*pi/8)*ones(1,150);
        se=[ones(1,50) ones(1,50) zeros(1,50)];
        
    elseif g(n)==1 & g(n+1)==1  & g(n+2)==1
        die=cos(-pi/8)*ones(1,150);
        die1=sin(-pi/8)*ones(1,150);
        se=[ones(1,50) ones(1,50) ones(1,50)];
        
    end
    c=cos(t);
    s=sin(t);
    cp=[cp die];    %Amplitude cosino
    sp=[sp -die1];   %Amplitude sino
    mod=[mod c];    %cosino carrier (Q)
    mod1=[mod1 s];  %sino carrier   (I)
end
bpsk=cp.*mod+sp.*mod1;

plot(bpsk,'LineWidth',1.5);grid on;
title('8PSK modulation')
axis([0 500 -1.5 1.5]); 


end


guidata(hObject, handles);

%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
% --- Executes on selection change in select_mod.
function select_mod_Callback(hObject, eventdata, handles)
% hObject    handle to select_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_mod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_mod
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
a=str2double(get(handles.bit1,'String'));
b=str2double(get(handles.bit2,'String'));
c=str2double(get(handles.bit3,'String'));
d=str2double(get(handles.bit4,'String'));
e=str2double(get(handles.bit5,'String'));
f=str2double(get(handles.bit6,'String'));
g=str2double(get(handles.bit7,'String'));
h=str2double(get(handles.bit8,'String'));
i0=str2double(get(handles.bit9,'String'));
j0=str2double(get(handles.bit10,'String'));

if (a~=0 & a~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit1,'String','X');
   error('error');
elseif (b~=0 & b~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit2,'String','X');
   
elseif (c~=0 & c~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit3,'String','X');
   
elseif (d~=0 & d~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit4,'String','X');
   
elseif (e~=0 & e~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit5,'String','X');
   
elseif (f~=0 & f~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit6,'String','X');
   
elseif (g~=0 & g~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit7,'String','X');
   
elseif (h~=0 & h~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit8,'String','X');
   
elseif (i0~=0 & i0~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit9,'String','X');
   
elseif (j0~=0 & j0~=1)
   warndlg('The value must be binary',' ERROR ');
   set(handles.bit10,'String','X');
   
end

handles.bits=[a,b,c,d,e,f,g,h,i0,j0];
%#######################################
h=handles.bits;
axes(handles.axes1)
hold off;
        bit=[];
        for n=1:2:length(h)-1;
            if h(n)==0 & h(n+1)==1
                se=[zeros(1,50) ones(1,50)];
            elseif h(n)==0 & h(n+1)==0
                se=[zeros(1,50) zeros(1,50)];
            elseif h(n)==1 & h(n+1)==0
                se=[ones(1,50) zeros(1,50)];
            elseif h(n)==1 & h(n+1)==1
                se=[ones(1,50) ones(1,50)];
            end
            bit=[bit se];
        end
        plot(bit,'LineWidth',1.5);grid on;
        axis([0 500 -1.5 1.5]);
%######################################

handles.mod=get(hObject,'Value');
mod=handles.mod;

switch mod
%-*-*-*-*-*-*-*-*-*-Modulation ASK*-*-*-*-*-*-*-*-*-*-*
    case 1
        axes(handles.axes3)
        hold off;
        fc=30;
        g=handles.bits; %modulante
        n=1;
    while n<=length(g)
        if g(n)==0
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
%    axis([0 n*2/fc -3 3]);
        else 
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(2)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        end
            n=n+1;
            
    end
    hold off
%-*-*-*-*-*-*-*-*-*-Modulation OOK*-*-*-*-*-*-*-*-*-
    case 2
        axes(handles.axes3)
        hold off;
        t=0:0.001:1;
        m=1;
        fc=30;
        g=handles.bits; %modulante
        n=1;
        while n<=length(g)
            tx=(n-1)*1/length(g):0.001:n*1/length(g);
            p=(g(n))*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);
            hold on;
            axis([0 (n)*1/length(g) -1.5 1.5]);
            grid on;
            n=n+1;
        end
        hold off

%*-*-*-*-*-*-*Modulation BPSK  -*-*-*-*-*-*-
    case 3
        axes(handles.axes3)
        hold off;
        g=handles.bits;
        fc=10;
        n=1;
    while n<=length(g)
        if g(n)==0 %0 is -1
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(-1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        else
            tx=(n-1)*0.1:0.1/100:n*0.1;
            p=(1)*sin(2*pi*fc*tx);
            plot(tx,p,'LineWidth',1.5);grid on;
            hold on;
        end
        n=n+1;
    end

%*-*-*-*-*-*-Modulation QPSK*-*-*-*-*
    case 4
        axes(handles.axes3)
        hold off;
        g=handles.bits;
        t=0:2*pi/99:2*pi;
        cp=[];sp=[];
        mod=[];mod1=[];
        for n=1:2:9;
            if g(n)==0 & g(n+1)==1;
                die=sqrt(2)/2*ones(1,100);
                die1=-sqrt(2)/2*ones(1,100);
            elseif g(n)==0 & g(n+1)==0;
                die=-sqrt(2)/2*ones(1,100);
                die1=-sqrt(2)/2*ones(1,100);
            elseif g(n)==1 & g(n+1)==0;
                die=-sqrt(2)/2*ones(1,100);
                die1=sqrt(2)/2*ones(1,100);
            elseif g(n)==1 & g(n+1)==1;
                die=sqrt(2)/2*ones(1,100);
                die1=sqrt(2)/2*ones(1,100);
            end
            c=cos(t);
            s=sin(t);
            cp=[cp die];    %Amplitude cosino
            sp=[sp die1];   %Amplitude sino
            mod=[mod c];    %cosino carrier (Q)
            mod1=[mod1 s];  %sino carrier   (I)
        end
        bpsk=cp.*mod+sp.*mod1;
        plot(bpsk,'LineWidth',1.5);grid on;
        title('QPSK modulation')
        axis([0 500 -1.5 1.5]); 
%*-*-*-*-*-*-*END QPSK-*-*-*-*-*-*-

% *-*-*-*-*-*Modulation 8psk*-*-*-*-*-*-*-
    case    5
        axes(handles.axes3)
        hold off;
        g=[handles.bits 0 0];
        t=0:2*pi/149:2*pi;
        cp=[];sp=[];
        mod=[];mod1=[];bit=[];
for n=1:3:length(g);
    if g(n)==0 & g(n+1)==1 & g(n+2)==1
        die=cos(pi/8)*ones(1,150);
        die1=sin(pi/8)*ones(1,150);
        se=[zeros(1,50) ones(1,50) ones(1,50)];
        
    elseif g(n)==0 & g(n+1)==1 & g(n+2)==0
        die=cos(3*pi/8)*ones(1,150);
        die1=sin(3*pi/8)*ones(1,150);
        se=[zeros(1,50) ones(1,50) zeros(1,50)];
        
    elseif g(n)==0 & g(n+1)==0  & g(n+2)==0
        die=cos(5*pi/8)*ones(1,150);
        die1=sin(5*pi/8)*ones(1,150);
        se=[zeros(1,50) zeros(1,50) zeros(1,50)];
        
    elseif g(n)==0 & g(n+1)==0  & g(n+2)==1
        die=cos(7*pi/8)*ones(1,150);
        die1=sin(7*pi/8)*ones(1,150);
        se=[zeros(1,50) zeros(1,50) ones(1,50)];
        
    elseif g(n)==1 & g(n+1)==0  & g(n+2)==1
        die=cos(-7*pi/8)*ones(1,150);
        die1=sin(-7*pi/8)*ones(1,150);
        se=[ones(1,50) zeros(1,50) ones(1,50)];
        
    elseif g(n)==1 & g(n+1)==0  & g(n+2)==0
        die=cos(-5*pi/8)*ones(1,150);
        die1=sin(-5*pi/8)*ones(1,150);
        se=[ones(1,50) zeros(1,50) zeros(1,50)];
        
    elseif g(n)==1 & g(n+1)==1  & g(n+2)==0
        die=cos(-3*pi/8)*ones(1,150);
        die1=sin(-3*pi/8)*ones(1,150);
        se=[ones(1,50) ones(1,50) zeros(1,50)];
        
    elseif g(n)==1 & g(n+1)==1  & g(n+2)==1
        die=cos(-pi/8)*ones(1,150);
        die1=sin(-pi/8)*ones(1,150);
        se=[ones(1,50) ones(1,50) ones(1,50)];
        
    end
    c=cos(t);
    s=sin(t);
    cp=[cp die];    %Amplitude cosino
    sp=[sp -die1];   %Amplitude sino
    mod=[mod c];    %cosino carrier (Q)
    mod1=[mod1 s];  %sino carrier   (I)
end
bpsk=cp.*mod+sp.*mod1;

plot(bpsk,'LineWidth',1.5);grid on;
title('8PSK modulation')
axis([0 500 -1.5 1.5]); 


end %end final


%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-



% --- Executes during object creation, after setting all properties.
function select_mod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


