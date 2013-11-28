% This script demos the optical flow for shpere and synth

im1 = im2double(rgb2gray(imread('sphere1.ppm')));
im2 = im2double(rgb2gray(imread('sphere2.ppm')));

regionSize = 15;
sigma = 1.5;

opticalFlow(im1, im2, regionSize, sigma, true);

im1 = im2double(imread('synth1.pgm'));
im2 = im2double(imread('synth2.pgm'));

opticalFlow(im1, im2, regionSize, sigma, true);


