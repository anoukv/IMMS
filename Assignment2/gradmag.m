function [magnitude, orientation] = gradmag(img,sigma)
%
% Returns a magnitude and an edge orientation matrix for a given image
%

% Read image and prepare convolution data
img = im2double(rgb2gray(imread(img)));
G = gaussian(sigma);
Gd = gaussianDer(G, sigma);

% Calculate magnitude in both directions separately.
magX = conv2(img, Gd, 'same');
magY = transpose(conv2(transpose(img), Gd, 'same'));

% Find sum magnitude and orientation
magnitude = sqrt(magX.^2 + magY.^2);
orientation = atan2(magY, magX);

end

