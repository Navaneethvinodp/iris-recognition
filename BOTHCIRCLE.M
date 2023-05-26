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

%PATTERN

clc;
clear;
%set base directory of irisBasis directory
irisDir = 'E:\Project-M.Tech\Final Code\IrisBasisAll';
destDir = 'E:\Project-M.Tech\Final Code\IrisBasisPattern';
clc;
T=[];
irisFiles = dir(irisDir);
    for i=1:size(irisFiles,1)
        if not(strcmp(irisFiles(i).name,'.')|strcmp(irisFiles(i).name,'..'))
            irisFileName = [irisDir, '\', irisFiles(i).name];
            F=imread(irisFileName);
            G=im2double(F);
            P=[];
                for j=1:size(F,2)
                    P = [P G(j,:)];
                end
                P=[P str2num(irisFiles(i).name(1:3))];
                T=[T;P];
                irisFileName[size(P) size(T)]
        end
    end[destDir,'\abc.mat']
save 'destDir' T
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
%%%================%%%
%PATTERN MATCHING
clc;
clear;
%set base directory of irisBasis directory
irisDir = 'E:\Project-M.Tech\Final Code\IrisBasisAll';
clc;
T=[];
irisFiles = dir(irisDir);
for i=1:size(irisFiles,1)
if not(strcmp(irisFiles(i).name,'.')|strcmp(irisFiles(i).name,'..'))
irisFileName = [irisDir, '\', irisFiles(i).name];
F=imread(irisFileName);
G=im2double(F);
%perform singular value decomposition
xpattern=svd(G);
P=[xpattern' str2num(irisFiles(i).name(1:3))];
T=[T;P];
irisFileName
[size(P) size(T)]
end
end
save('irisBasisSDV','T','-ASCII'); 




load('irisBasisSDV','-ascii');
irisBasisSDV
%get only first 3 dimensions'
nclasses=1;
size(irisBasisSDV)
TS=[irisBasisSDV(1,1:3) irisBasisSDV(1,41)];
%TS=[T(1:nclasses*7,1:3) T(1:nclasses*7,41)];
%display TS (full dataset)
TS
%display scatter points
scatter3(TS(:,1),TS(:,2),TS(:,3),8,TS(:,4),'filled');
%pause;
%form training set with the first 5 instances of each class
Training=[];
for i=1:nclasses
Training=[Training;TS(1,:)];
end;
scatter3(Training(:,1),Training(:,2),Training(:,3),8,Training(:,4),'filled');
%form the pattern matrix (patterns in columns - no class information)
P=Training';
P=P(1,:);
%get class column
targetTr=Training(:,4);
%convert sequential numbered classes to power of two:
% class 1 = 1
% class 2 = 2
% class 3 = 4
targetDec=2.^(targetTr-1);
%convert decimal to binary
% class 1 = 001
% class 2 = 010
% class 3 = 100
targetBin=dec2bin(targetDec);
%separate in columns
targetClass=[];
for i=1:nclasses
targetClass=[targetClass double(str2num(targetBin(:,i)))];
end;
%transpose
T=targetClass';
%----------------------------------------------------------- training
S1 = 300; % Number of neurons in the first hidden layer - changes according to test

S2 = nclasses; % Number of neurons in the output layer
net=newff(minmax(P),[S1 S2],{'logsig' 'logsig'}, 'traingda');
%setup network parameters
net.trainFcn = 'traingda'; % Training function type
net.trainParam.lr = 0.1; % Learning rate
net.trainParam.lr_inc = 1.05; % Increment of a learning rate
net.trainParam.show = 300; % Frequency of progress displays (in epochs).
net.trainParam.epochs = 50000; % Maximum number of epochs to train.
net.trainParam.goal = 0.0000005; % Mean-squared error goal.
net.trainParam.min_grad=0.000000001;
net=init(net);
net=train(net,P,T);
inter=sim(net,P);
%find out winner class
[Y,I]=max(inter);
%pause;
%----------------------------------------------------------- simulation
%form testing set with the remaining 2 instances of each class
Test=[];
for i=1:nclasses
Test=[Test;TS((i*7)-1:(i*7),:)];
end;
scatter3(Test(:,1),Test(:,2),Test(:,3),8,Test(:,4),'filled');
%form the pattern matrix (patterns in columns - no class information)
P=Test';
P=P(1:3,:);
%get class column
targetTs=Test(:,4);
%convert sequential numbered classes to power of two:
% class 1 = 1
% class 2 = 2
% class 3 = 4
targetDec=2.^(targetTs-1);
%convert decimal to binary
% class 1 = 001
% class 2 = 010
% class 3 = 100
targetBin=dec2bin(targetDec);
%separate in columns
targetClass=[];
for i=1:nclasses
targetClass=[targetClass double(str2num(targetBin(:,i)))];
end;
%transpose
T=targetClass';
%perform network simulation
a=sim(net,P);
%find out winner class
[Y,I]=max(a);
I=I';
c=nclasses-I;
res=log2(2.^c)+1;
match=[targetTs res targetTs-res];
%correctly classified patterns in percentage - 100%=perfect match
class=(size(find(match(:,3)==0),1)/size(targetTs,1))*100