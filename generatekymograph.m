%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates a kymograph. 
%
% @v = the video
% @rect = specifies the area in the video that should be analyzed.
% @startTimeMin = the minute at which the kymograph should start. Decimals
% permitted.
% @endTimeMin = the minute at which the kymograph should end. May be a
% decimal.
% --- If either of the above values are negative, the program assumes user 
%     wants full video to be read.--
%
% @incrementSec = the increment (in seconds) for each line of the
% kymograph.
% @threshold = a value between 0 and 1 that specifies
% where to threshold the gut. 0.3 or 0.2 seems good for the video I 
% tested this on.
% objlargerthan ignores noncontinuous objects larger than 
% this many pix 
% 
% @xAxisLengthCM = can specify if there we know the total number of cms of bowel viewed.
% If not, the x label will just be pixels (the size of rect in the x
% dimension).
%
% Return variables: 
% @matrix = the kymograph matrix.
% @maxInMatrix = the maximum value within the matrix. 
% @minInMatrix = the minimum value within the matrix. 
% @x = the x labels.
% @y = the y labels for the graph.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [matrx, maxInMatrix, minInMatrix,x,y] = generatekymograph(v, rect, startTimeMin, endTimeMin, incrementSec, threshold, xAxisLengthCM, maxSize)
    
    % Threshold (it's best to determine this manually)
    t = threshold;
    
    % filter out objects that are too small
    objlargerthan = maxSize;

    % Show the user a picture of the gut.
    % Get the height of the picture.
    b = showframe2(v, rect, 50, t, objlargerthan);
    imshow(b)
    h = length(b(1,:));
    
    % Get frame info from the video.
    frameTotal = v.numberofframes; % Total frames
    fps = v.FrameRate; % Frames per second
    fpm = fps * 60; % Frames per minute
    framesPerIncrement = round(fps * incrementSec);

    % Determine the start and end frames. 
    % If there is no specified start or end time (if they are negative)
    % then make a kymograph out of the entire video.
    if (startTimeMin < 0 || endTimeMin < 0) 
        startFrame = 1;
        endFrame = frameTotal;
    else
        startFrame = round(fpm * startTimeMin);
        if (startFrame < 1)
            startFrame = 1;
        end
        
        endFrame = round(fpm * endTimeMin);
        if (endFrame > frameTotal)
            endFrame = frameTotal;
        end
        
    end
        
    matrx = zeros(h, exactLength(v, startTimeMin, endTimeMin, incrementSec));
    i = 1;
    for j = startFrame:framesPerIncrement:endFrame
        b2 = showframe2(v,rect,j, t,objlargerthan);
        x = sum(b2);
        length(x);
        matrx(:,i) = x;
        i = i+1;
    end
    figure; 
    
    matrx = transpose(matrx);
   
    maxInMatrix = max(max(matrx));
    minInMatrix = min(min(matrx));
    
   
    imshow(matrx);
    colormap(jet);
    if (xAxisLengthCM > 0) 
        x = linspace(0,xAxisLengthCM,10);
    else
        x = 0;
    end
    
    if (startTimeMin < 0 || endTimeMin < 0) 
        y = linspace(0, frameTotal/fpm,10);
    else 
        y = linspace(startTimeMin,endTimeMin,10);
    end
    
    imagesc(x,y,matrx)
    colorbar()

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Returns a particular frame. 
function b2 = showframe2(v, rect, framenum, threshold, o)
    video = read(v,framenum);
    i = rgb2gray(video);
    bw = im2bw(i, threshold);
    bw = imfill(bw,'holes');
    b = imcrop(bw,rect);
    b2 = bwareaopen(b, o);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%

