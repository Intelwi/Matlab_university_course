I = imread('PCB1.jpg');
I = im2double(I);

[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, 0.6);
end

I = rgb2gray(I);
I1 = imbinarize(I);
I2=I1;
CC = bwconncomp(I1);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
I1(CC.PixelIdxList{idx}) = 0;
% BW1 = bwareafilt(I,1);%najwiekszy obszar
% [rows,cols] = find(BW1);%punkty najwiekszego obszaru
% I1= regionfill(I1,rows,cols);
% stats = regionprops(I, 'Area');
% B = max([stats.Area]);

fig = figure(1);
imshow(I);
figure(2)
imshow(I1)
figure(3);
imshow(I2);

