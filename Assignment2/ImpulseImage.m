

% Shows a bunch of impulse images.

%Define sigma.
sigma = 20;

G = gaussian(10);
Gd = gaussianDer(G, 10);

% Create base image.
img = zeros(201,201);
img(100,100) = 1;

figure, imshow(img);

% Subplot of various order derivatives in one direction
subplot(2,3,1);
G0 = gaussian(sigma);
im0 = conv2(img, G0, 'same');
imshow(im0,[]), title('zeroth order x');

subplot(2,3,2);
im1 = ImageDerivatives(img, sigma, 'x');
imshow(im1,[]), title('first order x');

subplot(2,3,3);
im2 = ImageDerivatives(img, sigma, 'xx');
imshow(im2,[]), title('second order x');

subplot(2,3,4);
G0 = gaussian(sigma);
im0 = transpose(conv2(transpose(img), G0, 'same'));
imshow(im0,[]), title('zeroth order y');

subplot(2,3,5);
im1 = ImageDerivatives(img, sigma, 'y');
imshow(im1,[]), title('first order y');

subplot(2,3,6);
im2 = ImageDerivatives(img, sigma, 'yy');
imshow(im2,[]), title('second order y');


% Subplot of dirivatives in both directions
figure
subplot(1,2,1);
G0 = gaussian(sigma);
im0 = conv2(G0,G0, img, 'same');
imshow(im0,[]), title('zeroth order xy');

subplot(1,2,2);
im1 = ImageDerivatives(img, sigma, 'xy');
imshow(im1,[]), title('first order xy');



