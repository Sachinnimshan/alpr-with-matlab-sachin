function varargout = Mainwindow(varargin)
% MAINWINDOW MATLAB code for Mainwindow.fig
%      MAINWINDOW, by itself, creates a new MAINWINDOW or raises the existing
%      singleton*.
%
%      H = MAINWINDOW returns the handle to a new MAINWINDOW or the handle to
%      the existing singleton*.
%
%      MAINWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINWINDOW.M with the given input arguments.
%
%      MAINWINDOW('Property','Value',...) creates a new MAINWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mainwindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mainwindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mainwindow

% Last Modified by GUIDE v2.5 27-Aug-2018 23:32:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mainwindow_OpeningFcn, ...
                   'gui_OutputFcn',  @Mainwindow_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
if nargout
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Mainwindow is made visible.
function Mainwindow_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Mainwindow (see VARARGIN)

% Choose default command line output for Mainwindow
handles.output = hObject;
axes(handles.axes4);
imshow('logo1.jpg');


datenow=datestr(now);
set(handles.text11,'String',datenow);
% Update handles structure
guidata(hObject, handles);
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('loginbg.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


% UIWAIT makes Mainwindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Mainwindow_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btnopenimage.
function btnopenimage_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to btnopenimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[baseFileName,folder]=uigetfile('*.*','Specify an image file');
fullimageFileName=fullfile(folder,baseFileName);
axes1=imread(fullimageFileName);

axes(handles.axes1); imshow(axes1); title('{\color{cyan}ORIGINAL IMAGE}');   
axes2 = rgb2gray(axes1);
axes(handles.axes2); imshow(axes2); title('{\color{cyan}GRAYSCALE IMAGE}');
nr=medfilt2(axes2,[3 3]); axes(handles.axes12); imshow(nr); title('{\color{cyan}NOISE REMOVAL}');
level = graythresh(nr);
imagen = im2bw(nr,level);
axes(handles.axes5); imshow(imagen); title('{\color{cyan}CONVERSION TO BINARY}');
imagen = ~imagen;
imagen = bwareaopen(imagen,600);
axes(handles.axes6); imshow(imagen); title('{\color{cyan}PIXEL SELECTION > 600}');
imagen = ~imagen;
%*-*-*Filter Image Noise*-*-*-*

if length(size(imagen))==3 %RGB image
    imagen=rgb2gray(imagen);
end
imagen = medfilt2(imagen);
[f, c]=size(imagen);
imagen (1,1)=255;
imagen (f,1)=255;
imagen (1,c)=255;
imagen (f,c)=255;

%*-*-*END Filter Image Noise*-*-*-*

word=[]; %Storage matrix word from image
re=imagen;
fid = fopen('log.txt', 'at'); %Opens a text for append in order to store the number plates for log.
while 1
    [fl, re]=lines(re); %Fcn 'lines' separate lines in text
    imgn=~fl;
    axes(handles.axes7); imshow(imgn); title('{\color{cyan}EXTRACTED PLATE}'); %#ok<LAXES>
    
    %*-*Uncomment line below to see lines one by one*-*-*-*
    %imshow(fl);pause(1)
    %*-*--*-*-*-*-*-*-
    
    %Calculating connected components
    L = bwlabel(imgn);
    mx=max(max(L));
    BW = edge(double(imgn),'sobel');
    [imx,imy]=size(BW);
    for n=1:mx
        [r,c] = find(L==n);
        rc = [r c];
        [sx sy]=size(rc); 
        n1=zeros(imx,imy);
        for i=1:sx
            x1=rc(i,1);
            y1=rc(i,2);
            n1(x1,y1)=255;
        end
        
        %END Calculating connected components
        
        n1=~n1;
        n1=~clip(n1);
        img_r=same_dim(n1);%Transf. to size 42 X 24
        axes(handles.axes8); imshow(img_r);pause(1); title('{\color{cyan}EXTRACTING CHARACTERS}'); %#ok<LAXES>
        
        %*-*-*-*-*-*-*-*
        
        letter=read_letter(img_r); %img to text
        word=[word letter];  %#ok<AGROW>
        
        set(handles.text5,'String',word);
        datenow=datestr(now);
        set(handles.text7,'String',datenow);
      
    end
    
    set(handles.text12,'String',word);
    fprintf(fid,'Number Plate:-%s\nDate:-%s\n',word,date);%Write 'word' in text file (upper)
    fprintf(fid,'------------------------------------\n');
    msgbox(sprintf('Number Plate Extraction successful.\nExtracted Number plate:- %s .\nSee the log.txt file to see the stored number.',word),'Extraction Success');
        
        dbname='lprs';
        username='root';
        password='';
        driver='com.mysql.jdbc.Driver';
        dburl=['jdbc:mysql://localhost:3306/',dbname];
        javaclasspath('C:\Program Files\MATLAB\MATLAB Production Server\R2015a\java\jarext/mysql-connector-java-5.1.6-bin.jar');

        conn=database(dbname,username,password,driver,dburl);
        colnames={'Record_ID' 'Plate_Number' 'Date_Time'};
        data={'' word date};
        datainsert(conn,'recognized_plates',colnames,data)
        
        sqlquery = ['SELECT * FROM registration WHERE Plate_Number =' '''' word ''''];
        curs = exec(conn,sqlquery);
        curs = fetch(curs);
        numrows = rows(curs);
        if numrows == 0
        set(handles.text14,'BackgroundColor',[1 0 0]);
        set(handles.text14,'ForegroundColor',[0 0 0]);
        set(handles.text14,'String','PARKING NOT ALLOWED');
        else
        set(handles.text14,'BackgroundColor',[0 0 0]);
        set(handles.text14,'ForegroundColor',[0 1 0]);
        set(handles.text14,'String','PARKING ALLOWED');
        end
        word=[];%Clear 'word' variable
    %*-*-*When the sentences finish, breaks the loop*-*-*-*
    if isempty(re)  %See variable 're' in Fcn 'lines'
    break
    end
    %*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
end
fclose(fid);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text5,'String','');
set(handles.text7,'String','');
set(handles.text14,'BackgroundColor',[0 0 0]);
set(handles.text12,'String','');
set(handles.text14,'String','');


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dbname='lprs';
username='root';
password='';
driver='com.mysql.jdbc.Driver';
dburl=['jdbc:mysql://localhost:3306/',dbname];
javaclasspath('C:\Program Files\MATLAB\MATLAB Production Server\R2015a\java\jarext/mysql-connector-java-5.1.6-bin.jar');

conn=database(dbname,username,password,driver,dburl);
sqlquery = 'SELECT Name_Owner,Type,Plate_Number FROM registration';
curs = exec(conn,sqlquery);
curs = fetch(curs);
curs.Data
set(handles.uitable1, 'Data', curs.Data);


% --- Executes on button press in btnrecentrecords.
function btnrecentrecords_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to btnrecentrecords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dbname='lprs';
username='root';
password='';
driver='com.mysql.jdbc.Driver';
dburl=['jdbc:mysql://localhost:3306/',dbname];
javaclasspath('C:\Program Files\MATLAB\MATLAB Production Server\R2015a\java\jarext/mysql-connector-java-5.1.6-bin.jar');

conn=database(dbname,username,password,driver,dburl);
sqlquery = 'SELECT * FROM recognized_plates';
curs = exec(conn,sqlquery);
curs = fetch(curs);
curs.Data
set(handles.uitable8, 'Data', curs.Data);
