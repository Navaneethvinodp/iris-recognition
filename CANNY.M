%CANNY.M
f=imread('ccc.bmp');
subplot(1,2,1);
imshow(f);title('original image');
BW2=edge(f,'canny');
figure,subplot(1,2,1);imshow(f);title('original image);
imshow(BW2);title('canny edge detector image');
%%%======%%%
%BOTHCIRCLE.M
fname='cc.bmp';
F=imread(fname);
imshow(F);
colormap('gray');
imagesc(F);
hold;
[cx,cy,rx,ry]=pupilfinder(fname);
%plot horizontal line
x=[cx-rx*2 cx+rx*2];
a=cx;
b=cy;
y=[cy cy];
plot(x,y,'y');
%plot vertical line
x=[cx cx];
y=[cy-ry*2 cy+ry*2];
plot(x,y,'y');

circle([cx cy], rx, 1000, '-');
%hold;
[rx,ry,lx,ly]=irisfinder(fname)
%plot horizontal line
x=[rx-lx*2 rx+lx*2];
y=[ry ry];
plot(a,b,'y');
%plot vertical line
x=[rx rx];
y=[ry-ly*2 ry+ly*2];
plot(a,b,'y');
circle([a b], lx+10, 1000, '-');
%[IB]=irisbasis('cc.bmp',100,100,1);
%imshow(uint8(IB));
%p=uint8(IB);
%imshow(F);
%i=imcrop;
%imshow(i);
%t=i;
%imshow(t);
% load
img = im2double(imread('cc.bmp'));
% black-white image by threshold on check how far each pixel from "white"
bw = sum((1-img).^2, 3) > .5; 
% show bw image
figure; imshow(bw); title('bw image');

 %get bounding box (first row, first column, number rows, number columns)
[row, col] = find(bw);
bounding_box = [min(row), min(col), max(col) - min(col) + 1, max(row) - min(row) + 1];
 %display with rectangle
rect = bounding_box([1,4,1,3]); 
% rectangle wants x,y,w,h we have rows, columns, ... need to convert
figure; imshow(img); hold on;
rectangle('Position', rect);
I2 = imcrop(img,rect);
figure,imshow(I2);
%figure,imshow(rect),title('xyz');
%rect1 = bounding_box([1,1,1,1]);
I3=imcrop(I2,[20,60,60,50]);
figure,imshow(I3);
