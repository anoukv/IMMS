% this is all very similar to demoAlignment()

left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 18;
p = 4;

[ M, t ] = computeAffineTransformation(left, right, n, p, false);

M = inv(M);

T = maketform('affine', [M; t']);

[x, y] = tformfwd(T,[1 size(left,2)], [1 size(left,1)]);

% xdata and ydata are the data points along which the images will be
% plottet. These are different to their size because the images move
% relative to each other.
xdata = [min(1,x(1)) max(size(right,2),x(2))];
ydata = [min(1,y(1)) max(size(right,1),y(2))];

% Perform transformation T on the left image and plot on new axes.
leftNew = imtransform(imread('left.jpg'),T,'Xdata',xdata,'YData',ydata);
% Perform the identity transformation on the right image and plot on new
% axes.
rightNew = imtransform(imread('right.jpg'), maketform('affine', [1 0 0; 0 1 0; 0 0 1]),'Xdata',xdata,'YData',ydata); 

subplot(1, 2, 1);
imshow(max(leftNew,rightNew), []);
title('Builtin');

% Reverse M again.
M = inv(M);
T = maketform('affine', [M; t']);
[rightNew, XDATA, YDATA] = imtransform(right, T);

rightNew = rightNew';

t = abs(ceil(t));

% Get the four corners of the transpositioned right image.
% Three corners are padding and the fourth is the rotated and scaled right
% image
A = zeros(t(1), t(2));
B = zeros(size(rightNew, 1), t(2));
C = zeros(t(1), size(rightNew, 2));
D = rightNew;

row1 = [A;B]';
row2 = [C;D]';

% Combine the rows.
rightTranslated = [row2; row1];

% get a copy of the left image in a larger frame.
leftResampled = zeros(size(rightTranslated));
leftResampled(1:size(left,1), 1:size(left,2)) = left;

subplot(1, 2, 2);
imshow(max(leftResampled,rightTranslated), []);
title('home made');

clear();
