global chosen_gray;

I = imread('kotek.jpg');
I = im2double(I);
%a=imadjust(I,[0 0.7]);
fig = figure(1);
imshow(I);
[chosen_region, coords] = imcrop(I);
chosen_gray = rgb2gray(chosen_region);
c = uicontrol('Parent',fig,'style','slider','units','normalized','position',[0,0,0.1,1.0]);
c.Callback = @plotSlid;

figure(2)
tmp = imshow(chosen_gray);


   



function plotSlid(src,event)
    global chosen_gray;
    a = get(src,'value')
    kontrast = max(max(chosen_gray)) - min(min(chosen_gray));
    tmp_gray=chosen_gray*a;
    figure(2);
    imshow(tmp_gray);
    
end


% function out = imadjust1(varargin)
% 
% %Parse inputs and initialize variables
% [img,imageType,lowIn,highIn,lowOut,highOut,gamma] = ...
%     parseInputs(varargin{:});
% 
% validateLowHigh(lowIn,highIn,lowOut,highOut);
% gamma = validateGamma(gamma,imageType);
% 
% if ~isfloat(img) && numel(img) > 65536
%     % integer data type image with more than 65536 elements
%     out = adjustWithLUT(img,lowIn,highIn,lowOut,highOut,gamma);
% 
% else
%     classin = class(img);
%     classChanged = false;
%     if ~isa(img,'double')
%         classChanged = true;
%         img = im2double(img);
%     end
% 
%     if strcmp(imageType, 'intensity')
%         out = adjustGrayscaleImage(img,lowIn,highIn,lowOut,highOut,gamma);
%     elseif strcmp(imageType, 'indexed')
%         out = adjustColormap(img,lowIn,highIn,lowOut,highOut,gamma);
%     else
%         out = adjustTruecolorImage(img,lowIn,highIn,lowOut,highOut,gamma);
%     end
%     
%     if classChanged
%         out = images.internal.changeClass(classin,out);
%     end
% end
% end
