sigma = 1.5;
k = 0.04;
threshold = 0.000005;

% what is this n for? assignment doesn't specify anything about window
n = 12;

im1 = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
im2 = im2double(rgb2gray(imread('person_toy/00000002.jpg')));

[H, r, c] = harris(im1, sigma, k, threshold, n);


regionSize = 1;

[Vx, Vy] = opticalFlow(im1, im2, regionSize, sigma);

for x = 1:size(r)
    for y = 1:size(c)
        cornerCoordinates = [r(x), c(y)]
    end
end

