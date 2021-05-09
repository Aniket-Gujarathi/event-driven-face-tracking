image = double(importdata('data_template.txt'));
imwrite(image, 'im.jpg');
imshow(imread('im.jpg'));