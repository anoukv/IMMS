% the parameters
sigma = 0.8;
k = 0.04;
threshold = 0.00005;
Gd = gaussianDer(sigma);
n = 10;
regionSize = 5;
transitionSpeed = 0.75;

% read im1 and im2 (just for testing)
im1 = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
im2 = im2double(rgb2gray(imread('person_toy/00000002.jpg')));

% compute Ix, Iy, It
Ix = conv2(im1, Gd, 'same');
Iy = transpose(conv2(transpose(im1), Gd, 'same'));
It = im1 - im2;

% find Harris stuff.
[H, r, c] = harris(im1, sigma, k, threshold, n, false);

Vx = zeros(size(r));
Vy = zeros(size(c));

newR = zeros(size(r));
newC = zeros(size(c));

for x = 1:size(r)
    [vx, vy] = opticalFlowPixel(im1, im2, r(x), c(x), regionSize, sigma);
    Vx(x) = vx;
    Vy(x) = vy;
    newR(x) = floor(r(x) + vx * transitionSpeed);
    newC(x) = floor(c(x) + vy * transitionSpeed);
end

%imshow(im1, []), hold on, plot(c, r, 'o'), quiver(c, r, Vx, Vy), hold off;
figure, imshow(im2, []), hold on, plot(newC, newR, 'o'), hold off;

