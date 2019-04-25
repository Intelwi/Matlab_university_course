global coords chosen_gray chosen_region I;
scaleFactor = 0.6

I = imread('kotek.jpg');

%sprawdzenie formatu obrazka
validate(I)

I = im2double(I);

%sprawdzenie wielkosci obrazka
[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, scaleFactor);
end

fig = figure(1);

%wybranie obszaru obrazka i pobranie jego wspolrzednych
[chosen_region, coords] = imcrop(I);
coords = round(coords);
chosen_gray = rgb2gray(chosen_region);

%stworzenie suwaka
c = uicontrol('Parent',fig,'style','slider','units','normalized','position',[0,0,0.1,1.0]);
c.Callback = @plotSlid;

%obsluga suwaka
function plotSlid(src,event)
    global coords chosen_gray chosen_region I;
    
    %pobranie wartości z suwaka
    a = get(src,'value');
    
    %maksymalna jasność
    max_v = max(max(chosen_gray));
    
    %minimalna jasnośc
    min_v = min(min(chosen_gray));
    
    %kontrast
    kontrast = max_v - min_v
    tmp=(chosen_region-min_v)*a*1/kontrast;
    
    %wklejenie do obrazu
    figure(1);
    hold on;
    I(coords(2):coords(2)+coords(4)-1,coords(1):coords(1)+coords(3)-1,:) = tmp;
    imshow(I);
end

function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end
