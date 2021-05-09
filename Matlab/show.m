a = imread('face_template1.jpg');
[rows, columns] = size(a);
fid = fopen('data_template.txt', 'wt');
for row = 1 : rows
    fprintf(fid, '\n');
    for col = 1 : columns
        fprintf(fid, '%d ', a(row, col));
    end
end