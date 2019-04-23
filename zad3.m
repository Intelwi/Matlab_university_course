scaleFactor = 0.6
px_len = 1/60;

I = imread('PCB1.jpg');
validate(I);
I = im2double(I);
[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, scaleFactor);
end

I1 = rgb2gray(I);
I1 = imbinarize(I1);

contours = regionprops(I1,'Area','BoundingBox');
[maks, id] = max([contours.Area]);
bigBoundingBox = contours(id).BoundingBox;
xMin = ceil(bigBoundingBox(1));
xMax = xMin + bigBoundingBox(3) - 1;
yMin = ceil(bigBoundingBox(2));
yMax = yMin + bigBoundingBox(4) - 1;

I1(1:yMin,1:end,:)=0;
I1(yMax:end,1:end,:)=0;
I1(1:end,1:xMin,:)=0;
I1(1:end,xMax:end,:)=0;

I1 = bwareaopen(I1, 40);

BoundingBox = regionprops(I1,'Area','BoundingBox');
[maks, id] = max([BoundingBox.Area]);
BoundingBox(id) = [];
% 
% figure(2)
% imshow(I1)
% hold off

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
    
   txt = sprintf('(%g,%g)',len_real,height_real);
   text(xMin,yMin,txt,'Color','red','FontSize',10)
   rectangle('Position',[xMin yMin len height],'EdgeColor','r')
end
% figure(2);
% rectangle('Position',[xMin yMin xMax-xMin yMax-yMin]);

function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end
