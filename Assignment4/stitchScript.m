% stitch script 
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));

% left = im2single(imread('img1.pgm'));
% right = im2single(imread('img2.pgm'));

% subplot(1, 2, 1);
% imshow(left, []);
% title('left');
% 
% subplot(1, 2, 2);
% imshow(right, []);
% title('right');

n = 10;
p = 4;

[ M, t ] = computeAffineTransformation(left, right, n, p);

% M = inv(M);

T = maketform('affine', [M; t']);

[x, y] = tformfwd(T,[1 size(left,2)], [1 size(left,1)]);

xdata = [min(1,x(1)) max(size(right,2),x(2))];
ydata = [min(1,y(1)) max(size(right,1),y(2))];

rightNew = imtransform(imread('right.jpg'),T,'Xdata',xdata,'YData',ydata);
leftNew = imtransform(imread('left.jpg'), maketform('affine', [1 0 0; 0 1 0; 0 0 1]),'Xdata',xdata,'YData',ydata); 
size(leftNew)
size(rightNew)
imshow(max(leftNew,rightNew));