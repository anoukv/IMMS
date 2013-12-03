im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img2.pgm'));
n = 10;
p = 10;

subplot(1, 2, 1);
imshow(im1, []);
title('im1');
subplot(1, 2, 2);
imshow(im2, []);
title('im2');

[ bestM, bestT ] = computeAffineTransformation(im1, im2, n, p);

% because we are going from 2 to 1
bestM = inv(bestM);
bestT = -bestT;

I = transformImage(im2, bestM, bestT);
%T = maketform('affine', [bestM(1,1), bestM(1,2); bestM(2,1), bestM(2,2); -bestT']);

figure, imshow(I);
title('Transformed im1');

figure, imshow(im2), hold on, imshow(I), hold off;

