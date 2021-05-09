% create an inverted 2D gaussian

%size of kernel
hsize = 31;
sigma = 5;
ind = -floor(hsize / 2) : floor(hsize / 2);
[u, v] = meshgrid(ind, ind);
% Gaussian function
h = (exp(-(u.^2 + v.^2) / sigma^2)) / (2 * pi * sigma^2);
% to normalize and invert the gaussian
h = -h / sum(h(:));
%dispay the surface
figure(1);
surf(h);
%dispay as an image
figure(2);
imagesc(h);