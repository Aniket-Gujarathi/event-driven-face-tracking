clc;
clear;
close all;

% read reference image
image = imread('1_8.jpg');

%convert to grayscale
I = rgb2gray(image);
[Ir, Ic] = size(I);
figure(1);
imshow(I);

%read the template image
template = imread('template.jpg');
figure(2);
imshow(template);

%convert to grayscale
T = rgb2gray(template);
[Tr, Tc] = size(T);
figure(3);
imshow(T);

%Apply normalised cross correlation on the template and the image
R = normxcorr2(T, I);

%find the maximum point from the correlation
[r, c] = find(R == max(R(:)));

%Account for the offset
r_index = r - size(template, 1) + 1;
c_index = c - size(template, 2) + 1;

%Draw a rectangle around the ROI
RGB = insertShape(image, 'rectangle', [c_index r_index Tc Tr], 'LineWidth', 3);
figure(4);
imshow(RGB);
