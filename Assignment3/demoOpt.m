im1 = im2double(rgb2gray(imread('sphere1.ppm')));
im2 = im2double(rgb2gray(imread('sphere2.ppm')));
% I1 = im2double(imread('synth1.pgm'));
% I2 = im2double(imread('synth2.pgm'));

regionSize = 1;
sigma = 1.5;

opticalFlow(im1, im2, regionSize, sigma);


