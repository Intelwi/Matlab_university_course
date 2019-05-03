scaleFactor = 0.6

I = imread('kotek.jpg');

%sprawdzenie formatu obrazka
validate(I)

I = im2double(I);

%sprawdzenie wielkosci obrazka
[y, x]=size(I);
if(x>2750 && y>770) 
    I = imresize(I, scaleFactor);
end

I1 = rgb2gray(I);
values = zeros(100,1);
i=1;

%petla
for prog = 0.01:0.01:1
    
    %progowanie
    I2 = I1>prog;
    
    %świateczne kolory ?
    I(:,:,1) = I2;
    I(:,:,3) = ~I2;
    I(:,:,2) = 0;
    
    imshow(I)
    
    %zliczanie jedynek
    counter=sum(I2(:));
    values(i) = counter;
    %values=[counter;values(1:end-1)];
    i=i+1;
end

figure
plot((0.01:0.01:1),values)

function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end