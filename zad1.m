I = imread('kotek.jpg');
I = im2double(I);
I1 = rgb2gray(I);
[y, x]=size(I1);
%prog=0.5;
counter_down = 0;
values = zeros(100,1);

for prog = 0.01:0.01:1
%     for i = 1:1:y
%         for j = 1:1:x
%             value = I1(i,j);
%             if(value<prog) 
%                 I(i,j,1) = 1;
%                 I(i,j,2) = 0;
%                 I(i,j,3) = 0;
%                 counter_down=counter_down+1;
%             else
%                 I(i,j,1) = 0;
%                 I(i,j,2) = 1;
%                 I(i,j,3) = 0;
%             end
%         end
%     end

    I2 = I1>prog;
    imshow(I2)
    counter=sum(I2(:))
    values=[counter;values(1:end-1)];
end

figure
plot((0.01:0.01:1),fliplr(values))
%imshow(I2);

% c = uicontrol(fig,'Style','pushbutton');
% c.Callback = @plotButtonPushed;
% 
%     function plotButtonPushed(src,event)
%         bar(randn(1,5));
%     end