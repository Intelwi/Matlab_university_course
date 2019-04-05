I = imread('PCB1.jpg');
I = im2double(I);

[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, 0.6);
end

I1 = rgb2gray(I);
I1 = imbinarize(I1);


% I2=I1;
% CC = bwconncomp(I1);
% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idx] = max(numPixels);
% I1(CC.PixelIdxList{idx}) = 0;
% [rows,cols] = find(BW1);%punkty najwiekszego obszaru
% I1= regionfill(I1,rows,cols);

I2 = bwareafilt(I1,1);%najwiekszy obszar
BoundingBox = regionprops(I2,'Area','BoundingBox');
BoundingBox = BoundingBox.BoundingBox;
xMin = ceil(BoundingBox(1));
xMax = xMin + BoundingBox(3) - 1;
yMin = ceil(BoundingBox(2));
yMax = yMin + BoundingBox(4) - 1;

I1(1:yMin,1:end,:)=0;
I1(yMax:end,1:end,:)=0;
I1(1:end,1:xMin,:)=0;
I1(1:end,xMax:end,:)=0;

I1 = bwareaopen(I1, 50);

BoundingBox = regionprops(I1,'Area','BoundingBox');

hold on
fig = figure(1);
imshow(I);
for i=1:1:length(BoundingBox)
    xMin = ceil(BoundingBox(i).BoundingBox(1));
    len = ceil(BoundingBox(i).BoundingBox(3));
    yMin = ceil(BoundingBox(i).BoundingBox(2));
    height = ceil(BoundingBox(i).BoundingBox(4));
   txt = sprintf('x=%g y=%g \rightarrow',len,height);
   text(xMin,yMin,txt) 
end
% figure(2);
% rectangle('Position',[xMin yMin xMax-xMin yMax-yMin]);

