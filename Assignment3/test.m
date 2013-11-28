% the parameters
sigma = 1.5;
k = 0.04;
threshold = 0.000005;
Gd = gaussianDer(sigma);
n = 12;

% read im1 and im2 (just for testing)
im1 = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
im2 = im2double(rgb2gray(imread('person_toy/00000002.jpg')));

% compute Ix, Iy, It
Ix = conv2(im1, Gd, 'same');
Iy = transpose(conv2(transpose(im1), Gd, 'same'));
It = im1 - im2;

[H, r, c] = harris(im1, sigma, k, threshold, n);

regionSize = 15;

%[Vx, Vy] = opticalFlow(im1, im2, regionSize, sigma);
Vx = zeros(size(r));
Vy = zeros(size(r));

for x = 1:size(r)
    for y = 1:size(c)
        cornerCoordinates = [r(x), c(y)]
        [v1, v2] = opticalFlowForPoints(x, y, Ix, Iy, It, regionSize)
        Vx(x) = v1;
        Vy(x) = v2;
    end
end

imshow(im1, []), hold on, quiver(c, r, Vx, Vy), hold off;

