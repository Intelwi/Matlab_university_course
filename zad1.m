I = imread('kotek.jpg');
validate(I)

I = im2double(I);
I1 = rgb2gray(I);
[y, x]=size(I1);
values = zeros(100,1);

for prog = 0.01:0.01:1
    I2 = I1>prog;
    I(:,:,1) = I2;
    I(:,:,3) = ~I2;
    I(:,:,2) = 0;
    
    imshow(I)
    counter=sum(I2(:))
    values=[counter;values(1:end-1)];
end

figure
plot((0.01:0.01:1),fliplr(values))

function validate(img)
    assert(ndims(img)==3 && size(img,3)==3, 'Not proper number of dimensions.')
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'},{});% RGB image
end