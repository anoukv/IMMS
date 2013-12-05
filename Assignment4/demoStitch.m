% this is all very similar to demoAlignment()

left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 18;
p = 4;

[ M, t ] = computeAffineTransformation(left, right, n, p, false);

M = inv(M);

T = maketform('affine', [M; t']);

[x, y] = tformfwd(T,[1 size(left,2)], [1 size(left,1)]);

xdata = [min(1,x(1)) max(size(right,2),x(2))];
ydata = [min(1,y(1)) max(size(right,1),y(2))];

leftNew = imtransform(imread('left.jpg'),T,'Xdata',xdata,'YData',ydata);
rightNew = imtransform(imread('right.jpg'), maketform('affine', [1 0 0; 0 1 0; 0 0 1]),'Xdata',xdata,'YData',ydata); 

subplot(1, 2, 1);
imshow(max(leftNew,rightNew), []);
title('Builtin');

M = inv(M);
T = maketform('affine', [M; t']);
[rightNew, XDATA, YDATA] = imtransform(right, T);

rightNew = rightNew';

t = abs(ceil(t));

A = zeros(t(1), t(2));
B = zeros(size(rightNew, 1), t(2));
C = zeros(t(1), size(rightNew, 2));
D = rightNew;

row1 = [A;B]';
row2 = [C;D]';

rightTranslated = [row2; row1];

leftResampled = zeros(size(rightTranslated));
leftResampled(1:size(left,1), 1:size(left,2)) = left;

subplot(1, 2, 2);
imshow(max(leftResampled,rightTranslated), []);
title('home made');

clear();