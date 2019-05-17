function varargout = ThresholdAndCropGUI(varargin)
% ThresholdAndCropGUI MATLAB code for ThresholdAndCropGUI.fig
%      ThresholdAndCropGUI, by itself, creates a new ThresholdAndCropGUI or raises the existing
%      singleton*.
%
%      H = ThresholdAndCropGUI returns the handle to a new ThresholdAndCropGUI or the handle to
%      the existing singleton*.
%
%      ThresholdAndCropGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ThresholdAndCropGUI.M with the given input arguments.
%
%      ThresholdAndCropGUI('Property','Value',...) creates a new ThresholdAndCropGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ThresholdAndCropGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ThresholdAndCropGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ThresholdAndCropGUI

% Last Modified by GUIDE v2.5 08-Jun-2017 21:11:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ThresholdAndCropGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ThresholdAndCropGUI_OutputFcn, ...
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


% --- Executes just before ThresholdAndCropGUI is made visible.
function ThresholdAndCropGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ThresholdAndCropGUI (see VARARGIN)

% Choose default command line output for ThresholdAndCropGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes ThresholdAndCropGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ThresholdAndCropGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function setGlobalImg(val)
% This is a black and white image that is loaded initially.
global globalImage;
globalImage = val;

function r = getGlobalImg
global globalImage;
r = globalImage;

function setVidReader(val)
% This is a black and white image that is loaded initially.
global vidReader;
vidReader = val;

function r = getVidReader
global vidReader;
r = vidReader;

function setCrops(val)
% This is a black and white image that is loaded initially.
global crops;
crops = val;

function cr = getCrops(val)
% This is a black and white image that is loaded initially.
global crops;
cr = crops;


% --- Executes during object creation, after setting all properties.
%function image1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image1
%axes(hObject)
%display("HELLO??");
%x = imread('bowelpic2.png');
%x = rgb2gray(x);
%setGlobalImg(x);
%x = im2bw(x,0.5);
%x = imfill(x,'holes');
%x = bwareaopen(x, 10000);
%y = handles;
%axes(handles.image1);
%display("read picture");
%imshow(x);


function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold as text
%        str2double(get(hObject,'String')) returns contents of threshold as a double

% Get the threshold from the box.
thresh = str2num(get(hObject,'String'));

if (thresh <0)
    thresh = 0;
    set(handles.threshold,'String',num2str(thresh));
elseif (thresh>1)
    thresh = 1;
    set(handles.threshold,'String',num2str(thresh));
end

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));
        
% Set the threshold to be equal to whatever the slider value is.
set(handles.slider2, 'value', thresh);

% Update the image.
img = updateImage(thresh, minsz);

% Show the image.
imshow(img);




% --- Executes on button press in showImage.
%function showImage_Callback(hObject, eventdata, handles)
% hObject    handle to showImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.threshold, 'String', num2str(0.76));
%x = imread('bowelpic2.png');
%x = rgb2gray(x);
%y = str2double(get(handles.threshold,'String'));
%x = im2bw(x, str2double(get(handles.threshold,'String')));
%x = imfill(x,'holes');
%x = bwareaopen(x, 10000);
%imshow(x);
%axes(handles.image1);
%imshow(x, 'parent',handles.image1);
%if (get(hObject,'Value') == get(hObject,'Max'))
%	display('Selected');
%else
%	display('Not selected');
%end

%button_state = get(hObject,'Value');
%if button_state == get(hObject,'Max')
 %   x = imread('bowelpic2.png');
  %  x = rgb2gray(x);
   % x = im2bw(x, str2double(get(handles.threshold,'String')));
    %x = imfill(x,'holes');
    %x = bwareaopen(x, 10000);
%end



% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%x = imread('bowelpic2.png');
%x = rgb2gray(x);

% Get the threshold from the slider.
thresh = get(hObject,'value');

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Set the threshold to be equal to whatever the slider value is.
set(handles.threshold, 'string', thresh);

% Update the image.
img = updateImage(thresh, minsz);

% Show the image.
imshow(img);



function img = updateImage(threshold, size)
x = im2bw(getGlobalImg(), threshold);
x = imfill(x,'holes');
x = imcrop(x, getCrops());
img = bwareaopen(x, size);



% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
display("Create threshold");



function minSize_Callback(hObject, eventdata, handles)
% hObject    handle to minSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minSize as text
%        str2double(get(hObject,'String')) returns contents of minSize as a double

% Get the threshold from the slider.
thresh = get(handles.slider2,'value');

% Get the min size (whatever was written in the box)
% at some point I should make an exception handler
try
    minsz = str2num(get(hObject,'String'));
    class(minsz)
catch 
    warning('This value has to be numerical.');
    minsz = 0;
    set(hObject,'String',num2str(minsz));
end
    

% Set the threshold to be equal to whatever the slider value is.
set(handles.threshold, 'string', thresh);

% Update the image.
img = updateImage(thresh, minsz);

% Show the image.
imshow(img);

% --- Executes during object creation, after setting all properties.
function minSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vidFrameNumber_Callback(hObject, eventdata, handles)
% hObject    handle to vidFrameNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vidFrameNumber as text
%        str2double(get(hObject,'String')) returns contents of vidFrameNumber as a double


% --- Executes during object creation, after setting all properties.
function vidFrameNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vidFrameNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function videoName_Callback(hObject, eventdata, handles)
% hObject    handle to videoName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of videoName as text
%        str2double(get(hObject,'String')) returns contents of videoName as a double


% --- Executes during object creation, after setting all properties.
function videoName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to videoName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveParameters.
function saveParameters_Callback(hObject, eventdata, handles)
% hObject    handle to saveParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


videoNm = get(handles.videoName, 'String'); % This may change - may ultimately use global variable.
videoFrmNm = get(handles.vidFrameNumber, 'String'); % This may change - may ultimately use global variable.
thresh = get(handles.threshold, 'String');
mnsz = get(handles.minSize, 'String');
%output = strcat("Video name is: ", videoNm, "\r\nVideo Frame Number is: ", videoFrmNm, "\r\nThreshold is: ", thresh, "\r\nMin size is: ", mnsz);

varname = get(handles.varName, 'String');
rect = getCrops();
startTimeMin = get(handles.min0, 'String');
endTimeMin = get(handles.min1, 'String');
incrementSec = get(handles.incSec, 'String');
xAxisLengthCM = get(handles.xAxisLength, 'String');

%[matrx, maxInMatrix, minInMatrix,x,y] = generatekymograph(v, rect, startTimeMin, endTimeMin, incrementSec, threshold, xAxisLengthCM)

output0 = strcat(varname,"vidR = VideoReader('", videoNm, "');");
output1 = strcat("[", varname, "matrx, ", varname, "max, ", varname, "min, ", varname, "x, ", varname, "y] = generatekymograph(");
output2 = strcat(varname, "vidR, [", num2str(rect), "], ", startTimeMin, ", ", endTimeMin,", ", incrementSec, ", ", thresh,", ", xAxisLengthCM, ", ", mnsz,");");


output = strcat(output0, "\r\n", output1, output2);

display(sprintf(output));



FilterSpec = '*.txt';
DialogTitle = 'Save File';
[pathstr,name,ext] = fileparts(videoNm);
DefaultName = strcat(name,'.txt');
[FileName,PathName,FilterIndex] = uiputfile(FilterSpec,DialogTitle,DefaultName);

fileID = fopen(FileName,'w');
fprintf(fileID,output);




% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',.5);


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ldr = imread('LoadingImage.png');
imshow(ldr);
display("Reading video");
videoNm = get(handles.videoName, 'String');


videoFrmNm = str2num(get(handles.vidFrameNumber, 'String'));
display("Got vid name");
display(videoNm);

v = VideoReader(videoNm);

video = read(v,videoFrmNm);
video = rgb2gray(video);

% Sets the global image to be the video image
setGlobalImg(video);

vidinf = strcat("Name: ", v.Name, "\nDuration: ", num2str(v.Duration), "\nWidth: ", num2str(v.Width), "\nHeight: ", num2str(v.Height), "\nFrameRate: ", num2str(v.FrameRate));
set(handles.VidInfo, 'String', sprintf(vidinf));

% Get the threshold from the slider.
thresh = str2num(get(handles.threshold,'String'));

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Set the threshold to be equal to whatever the slider value is.
set(handles.threshold, 'string', thresh);

% Figure out image size and set cropping parameters accordingly
x = getGlobalImg();
cropx1 = length(x(1,:));
cropy1 = length(x(:,1));
setCrops([0 0 cropx1 cropy1]);
set(handles.cropx1,'String', num2str(cropx1));
set(handles.cropy1,'String', num2str(cropy1));

% Update the image.
img = updateImage(thresh, minsz);

imshow(img);



function VidInfo_Callback(hObject, eventdata, handles)
% hObject    handle to VidInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VidInfo as text
%        str2double(get(hObject,'String')) returns contents of VidInfo as a double


% --- Executes during object creation, after setting all properties.
function VidInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VidInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

x = imread('bowelpic2.png');
x = rgb2gray(x);
setGlobalImg(x);
x = im2bw(x,0.5);
x = imfill(x,'holes');
x = bwareaopen(x, 10000);
cropx1 = length(x(1,:));
cropy1 = length(x(:,1));
setCrops([0 0 cropx1 cropy1]);

%set(handles.cropx1,'String', num2str(cropx1));
%set(handles.cropy1,'String', num2str(cropy1));

display("read picture");
imshow(x);



% --- Executes during object creation, after setting all properties.
function cropx0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cropx0_Callback(hObject, eventdata, handles)
% hObject    handle to cropx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
crops0 = getCrops();

cropx0 = str2num(get(hObject,'String'));
crops1 = [cropx0 crops0(2) crops0(3) crops0(4)];
setCrops(crops1);

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Get the threshold from the slider.
thresh = get(handles.slider2,'value');

img = updateImage(thresh, minsz);

imshow(img);


function cropy0_Callback(hObject, eventdata, handles)
% hObject    handle to cropy0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cropy0 as text
%        str2double(get(hObject,'String')) returns contents of cropy0 as a double
crops0 = getCrops();

cropy0 = str2num(get(hObject,'String'));

crops1 = [crops0(1) cropy0 crops0(3) crops0(4)];
setCrops(crops1);

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Get the threshold from the slider.
thresh = get(handles.slider2,'value');

img = updateImage(thresh, minsz);

imshow(img);


% --- Executes during object creation, after setting all properties.
function cropy0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropy0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cropx1_Callback(hObject, eventdata, handles)
% hObject    handle to cropx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cropx1 as text
%        str2double(get(hObject,'String')) returns contents of cropx1 as a double
% Hints: get(hObject,'String') returns contents of cropy0 as text
%        str2double(get(hObject,'String')) returns contents of cropy0 as a double
crops0 = getCrops();

cropx1 = str2num(get(hObject,'String'));

glimg = getGlobalImg();
maxlength = length(glimg(1,:));
if (cropx1 > maxlength) 
    cropx1 = maxlength;
    set(handles.cropx1,'String', num2str(maxlength));
end    

crops1 = [crops0(1) crops0(2) cropx1 crops0(4)];
setCrops(crops1);

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Get the threshold from the slider.
thresh = get(handles.slider2,'value');

img = updateImage(thresh, minsz);

imshow(img);

% --- Executes during object creation, after setting all properties.
function cropx1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cropy1_Callback(hObject, eventdata, handles)
% hObject    handle to cropy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cropy1 as text
%        str2double(get(hObject,'String')) returns contents of cropy1 as a double
crops0 = getCrops();

cropy1 = str2num(get(hObject,'String'));

glimg = getGlobalImg();
maxlength = length(glimg(:,1));
if (cropy1 > maxlength) 
    cropy1 = maxlength;
    set(handles.cropy1,'String', num2str(maxlength));
end    

crops1 = [crops0(1) crops0(2) crops0(3) cropy1];
setCrops(crops1);

% Get the min size (whatever was written in the box)
minsz = str2num(get(handles.minSize,'String'));

% Get the threshold from the slider.
thresh = get(handles.slider2,'value');

img = updateImage(thresh, minsz);

imshow(img);


% --- Executes during object creation, after setting all properties.
function cropy1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min0_Callback(hObject, eventdata, handles)
% hObject    handle to min0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min0 as text
%        str2double(get(hObject,'String')) returns contents of min0 as a double


% --- Executes during object creation, after setting all properties.
function min0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min1_Callback(hObject, eventdata, handles)
% hObject    handle to min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min1 as text
%        str2double(get(hObject,'String')) returns contents of min1 as a double


% --- Executes during object creation, after setting all properties.
function min1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function varName_Callback(hObject, eventdata, handles)
% hObject    handle to varName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varName as text
%        str2double(get(hObject,'String')) returns contents of varName as a double


% --- Executes during object creation, after setting all properties.
function varName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incSec_Callback(hObject, eventdata, handles)
% hObject    handle to incSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of incSec as text
%        str2double(get(hObject,'String')) returns contents of incSec as a double


% --- Executes during object creation, after setting all properties.
function incSec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to incSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xAxisLength_Callback(hObject, eventdata, handles)
% hObject    handle to xAxisLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xAxisLength as text
%        str2double(get(hObject,'String')) returns contents of xAxisLength as a double


% --- Executes during object creation, after setting all properties.
function xAxisLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xAxisLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
