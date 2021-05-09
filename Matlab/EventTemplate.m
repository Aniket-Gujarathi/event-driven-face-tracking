clc;
clear;
close all;

% read reference image
image = imread('3_2.jpg');

%convert to grayscale
I = rgb2gray(image);
[Ir, Ic] = size(I)
figure(1);
imshow(I);

%read the template image
template = imread('template.jpg');
figure(2);
imshow(template);

%convert to grayscale
T = rgb2gray(template);
%binarize the image
T = ~im2bw(T);
[Tr, Tc] = size(T);
figure(3);
imshow(T);

%Initialize the size and the deviation of the inverted gaussian
hsize = 5;
sigma = 3;

%Inverted gaussian
ng = NegGaussian(hsize, sigma);
%resizing to the size of the template
ng = imresize(ng, size(T));
%dispay the gaussian surface
figure(5);
surf(ng);
%dispay as an image
figure(6);
imagesc(ng);

%T = edge(T, 'sobel', 0.38);
temp = ng;

for r = 1 : Tr
    for c = 1 : Tc
        if (T(r, c) == 1)
            temp(r, c) = 1.0;    
        end    
    end
end

%imtool(temp);
%size(temp)

for r = 1 : Tr
    for c = 1 : Tc
        if(temp(r, c) >= -0.55 && temp(r, c) ~= 1)
            temp(r, c) = 0;
        end
    end
end

imtool(temp);
[tr, tc] = size(temp)
Convert2txt(temp);
