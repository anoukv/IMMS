% stitch script
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 1000;
p = 20;

<<<<<<< HEAD
[ bestM, bestT ] = computeAffineTransformation(left, right, n, p);

bestM = inv(bestM);
=======
[ M, t ] = computeAffineTransformation(left, right, n, p);
>>>>>>> 606f197e03eb88aa884d379989c627ea5d399cea

M = inv(M);

I = transformImage(left, M, t);

subplot(1, 2, 1);
imshow(left, []);
title('left');

subplot(1, 2, 2);
imshow(right, []);
title('right');

figure, imshow(I);
title('Transformed right')