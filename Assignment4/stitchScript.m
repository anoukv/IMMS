% stitch script 
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 18;
p = 4;

[ M, t ] = computeAffineTransformation(left, right, n, p);

M = inv(M);
t = -t;

I = transformImage(left, M, t);

subplot(1, 2, 1);
imshow(left, []);
title('left');

subplot(1, 2, 2);
imshow(right, []);
title('right');

figure, imshow(I);
title('Transformed right')