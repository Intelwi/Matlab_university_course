scaleFactor = 0.6
pattern = 0.2;

I = imread('PCB1.jpg');

%sprawdzenie formatu obrazka
validate(I);

I = im2double(I);

%sprawdzenie wielkosci obrazka
[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, scaleFactor);
end

%wybieranie sciezki ----------------------------------
chosen = imcrop(I);
chosen = rgb2gray(chosen);
chosen = imbinarize(chosen,0.1);
%imshow(chosen)

%odszumienie i wyliczenie ile mm ma pixel
chosen = bwareaopen(chosen, 40);
pad = regionprops(chosen,'BoundingBox');
len_in_px = min(pad.BoundingBox(3), pad.BoundingBox(4));
px_len = pattern/len_in_px;


%obrobka obrazu i znajdowanie najwiekszego konturu ---
I1 = rgb2gray(I);
I1 = imbinarize(I1,0.3);
contours = regionprops(I1,'Area','BoundingBox');
[maks, id] = max([contours.Area]);
bigBoundingBox = contours(id).BoundingBox;
xMin = ceil(bigBoundingBox(1));
xMax = xMin + bigBoundingBox(3) - 1;
yMin = ceil(bigBoundingBox(2));
yMax = yMin + bigBoundingBox(4) - 1;

%wycinanie  ----------------------------------
I1(1:yMin,1:end,:)=0;
I1(yMax:end,1:end,:)=0;
I1(1:end,1:xMin,:)=0;
I1(1:end,xMax:end,:)=0;

%odszumienie  ----------------------------------
I1 = bwareaopen(I1, 40);

%wyciecie duzego prosstokata z wektora prostokatow
BoundingBox = regionprops(I1,'Area','BoundingBox');
[maks, id] = max([BoundingBox.Area]);
BoundingBox(id) = [];
% 
% figure(2)
% imshow(I1)
% hold off

%szukanie wymiarow padow  ----------------------------------
hold on
fig = figure(1);
imshow(I);
for i=1:1:length(BoundingBox)
    xMin = ceil(BoundingBox(i).BoundingBox(1));
    len = ceil(BoundingBox(i).BoundingBox(3));
    len_real = round(px_len*len,3);
    
    yMin = ceil(BoundingBox(i).BoundingBox(2));
    height = ceil(BoundingBox(i).BoundingBox(4));
    height_real = round(px_len*height,3);
    
   rectangle('Position',[xMin yMin len height],'EdgeColor','y')
   txt = sprintf('(%g,%g)',len_real,height_real);
   text(xMin,yMin,txt,'Color','red','FontSize',10)
end


function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end
