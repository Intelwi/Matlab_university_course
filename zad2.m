global coords chosen_gray chosen_region I;

I = imread('kotek.jpg');
validate(I)
I = im2double(I);
fig = figure(1);
[chosen_region, coords] = imcrop(I);
coords = int16(coords);
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

function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end
