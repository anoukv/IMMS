sigma = 1.5;
k = 0.04;
threshold = 0.00005;

% what is this n for? assignment doesn't specify anything about window
n = 12;

I = im2double(rgb2gray(imread('shapes.png')));
harris(I, sigma, k, threshold, n);