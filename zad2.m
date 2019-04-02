I = imread('kotek.jpg');
I = im2double(I);
I = rgb2gray(I);
a=imadjust(I,[0 0.7]);
imshow(a);
   
%       figure, imshow(K
% c = uicontrol(fig,'Style','pushbutton');
% c.Callback = @plotButtonPushed;
% 
%     function plotButtonPushed(src,event)
%         bar(randn(1,5));
%     end


function out = imadjust1(varargin)

%Parse inputs and initialize variables
[img,imageType,lowIn,highIn,lowOut,highOut,gamma] = ...
    parseInputs(varargin{:});

validateLowHigh(lowIn,highIn,lowOut,highOut);
gamma = validateGamma(gamma,imageType);

if ~isfloat(img) && numel(img) > 65536
    % integer data type image with more than 65536 elements
    out = adjustWithLUT(img,lowIn,highIn,lowOut,highOut,gamma);

else
    classin = class(img);
    classChanged = false;
    if ~isa(img,'double')
        classChanged = true;
        img = im2double(img);
    end

    if strcmp(imageType, 'intensity')
        out = adjustGrayscaleImage(img,lowIn,highIn,lowOut,highOut,gamma);
    elseif strcmp(imageType, 'indexed')
        out = adjustColormap(img,lowIn,highIn,lowOut,highOut,gamma);
    else
        out = adjustTruecolorImage(img,lowIn,highIn,lowOut,highOut,gamma);
    end
    
    if classChanged
        out = images.internal.changeClass(classin,out);
    end
end
end
