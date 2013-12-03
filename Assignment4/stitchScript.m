% stitch script
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 1000;
p = 20;

[ bestM, bestT ] = computeAffineTransformation(left, right, n, p);

bestM = inv(bestM);

T = maketform('affine', [bestM(1,1), bestM(1,2); bestM(2,1), bestM(2,2); -bestT']);


subplot(1, 2, 1);
imshow(left, []);
title('left');
subplot(1, 2, 2);
imshow(right, []);
title('right');

figure, imshow(imtransform(right, T));
title('Transformed right')