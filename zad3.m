I = imread('PCB1.jpg');
I = im2double(I);

[y x] = size(I);
if(x>2750 && y>770) 
    I = imresize(I, 0.6);
end

I = rgb2gray(I);
I = imbinarize(I);

BW1 = bwareafilt(I,1);%najwiekszy obszar
[rows,cols] = find(BW1);%punkty najwiekszego obszaru
I1= regionfill(I,rows,cols);
stats = regionprops(I, 'Area');
B = max([stats.Area]);



fig = figure(1);
imshow(I);

