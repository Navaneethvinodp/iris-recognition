%PUPILFINDER.M

function [cx,cy,rx,ry]=pupilfinder(F)
% USE: [cx,cy,rx,ry]=pupilfinder(imagename)
% Arguments: imagename: is the input image of an human iris
% Purpose:
% perform image segmentation and finds the center and two
% (vertical and horizontal) radius of the iris pupil
% Example: [cx,cy,rx,ry]=pupilfinder('image.bmp')
% cx and cy is the position of the center of the pupil
% rx and ry is the horizontal radius and vertical radius of the pupil
G=imread('cc.bmp');
bw_70=(G>100);
bw_labeled=bwlabel(~bw_70,8);
mr=max(bw_labeled);
regions=max(mr);
for i=1:regions
[r,c]=find(bw_labeled==i);
if size(r,1) < 2500
region_size=size(r,1);
for j=1:size(c,1)
bw_labeled(r(j),c(j))=0;
end;
end;
end;
bw_pupil=bwlabel(bw_labeled,8);
%get centroid of the pupil
stats=regionprops(bw_pupil,'centroid');
ctx=stats.Centroid(1);
cty=stats.Centroid(2);
hor_center = bw_pupil(round(cty),:);
ver_center = bw_pupil(:,round(ctx));
%from the horizontal center line, get only the left half
left=hor_center(1:round(ctx));
%then flip horizontally
left=fliplr(left);
%get the position of the first pixel with value 0 (out of pupil bounds)
left_out=min(find(left==0));
%finally calculate the left pupil edge position
left_x = round(ctx-left_out);
%from the horizontal center line, get only the right half
right=hor_center(round(ctx):size(G,2));
%get the position of the first pixel with value 0 (out of pupil bounds)
right_out=min(find(right==0));
%finally calculate the left pupil edge position
right_x = round(ctx+right_out);
%adjust horizontal center and radius
rx = round((right_x-left_x)/2);
cx = left_x+rx;
%from the vertical center line, get only the upper half
top=ver_center(1:round(cty));
%then flip horizontally
top=flipud(top);
%get the position of the first pixel with value 0 (out of pupil bounds)
top_out=min(find(top==0));
%finally calculate the left pupil edge position
top_y = round(cty-top_out);
%from the vertical center line, get only the upper half
bot=ver_center(round(cty):size(G,1));
%get the position of the first pixel with value 0 (out of pupil bounds)
bot_out=min(find(bot==0));
%finally calculate the left pupil edge position
bot_y = round(cty+bot_out);
%adjust horizontal center and radius
ry = round((bot_y-top_y)/2);
cy = top_y+ry;