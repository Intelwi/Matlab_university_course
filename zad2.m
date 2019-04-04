global coords chosen_gray chosen_region I;

I = imread('kotek.jpg');
I = im2double(I);
%a=imadjust(I,[0 0.7]);
fig = figure(1);
[chosen_region, coords] = imcrop(I);
coords = uint16(coords);
chosen_gray = rgb2gray(chosen_region);
c = uicontrol('Parent',fig,'style','slider','units','normalized','position',[0,0,0.1,1.0]);
c.Callback = @plotSlid;



   
function plotSlid(src,event)
    global coords chosen_gray chosen_region I;
    a = get(src,'value');
    max_v = max(max(chosen_gray));
    min_v = min(min(chosen_gray));
    kontrast = max_v - min_v
    tmp=(chosen_region-min_v)*a*1/kontrast;
    figure(1);
    hold on;
    I(coords(2):coords(2)+coords(4)-1,coords(1):coords(1)+coords(3)-1,:) = tmp;
    imshow(I);
    
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
