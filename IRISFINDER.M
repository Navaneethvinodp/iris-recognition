%IRISFINDER.M
function [right_x,right_y,left_x,left_y]=irisfinder(imagename)
% USE: [rx,ry,lx,ly]=irisfinder(imagename)
% Arguments: imagename: is the input image of an human iris
% Purpose:
% perform image segmentation and finds the edgepoints of
% the iris at the horizontal line that crosses the center
% of the pupil
% Example: [rx,ry,lx,ly]=irisfinder('image.bmp')
% rx and ry is the edge point of the iris on the right side
% lx and ly is the edge point of the iris on the left side
%read bitmap

F=imread('cc.bmp');
%find pupil center and radius
[cx,cy,rx,ry]=pupilfinder(F);
% Apply linear contrast filter
D=double(F);
G=uint8(D*1.4-20);
%obtain the horizontal line that passes through the iris center
l=G(cy,:);
margin = 10;
% Right side of the pupil
R=l(cx+rx+margin:size(l,2));
[right_x,avgs]=findirisedge(R);

right_x=cx+rx+margin+right_x;
right_y=cy;
% Left side of the pupil
L=l(1:cx-rx-margin);
L=fliplr(L);
[left_x,avgs]=findirisedge(L);
left_x=cx-rx-margin-left_x;    left_y=cy;
%%%======%%%

%CIRCLE

function H=circle(center,radius,NOP,style)
%---------------------------------------------------------------------------------------------
% H=CIRCLE(CENTER,RADIUS,NOP,STYLE)
% This routine draws a circle with center defined as
% a vector CENTER, radius as a scaler RADIS. NOP is 
% the number of points on the circle. As to STYLE,
% use it the same way as you use the rountine PLOT.
% Since the handle of the object is returned, you
% use routine SET to get the best result.
%
%   Usage Examples,
%
%   circle([1,3],3,1000,':'); 
%   circle([2,4],2,1000,'--');
%---------------------------------------------------------------------------------------------

if (nargin <3),
 error('Please see help for INPUT DATA.');
elseif (nargin==3)
    style='b-';
end;
THETA=linspace(0,2*pi,NOP);
RHO=ones(1,NOP)*radius;
[X,Y] = pol2cart(THETA,RHO);
X=X+center(1);
Y=Y+center(2);
H=plot(X,Y,style);
axis square;
%%%==============%%%%%
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