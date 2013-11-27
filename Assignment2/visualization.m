% visualization of the gradient and magnitude



% Define script parameters
sigma  = 1;
img = 'zebra.png';

% Calculate magnitude and orientation
[magnitude, orientation] = gradmag(img,sigma);

% Show magnitude
imshow(magnitude, []), title('result');

% Show magnitude with arows
figure, 
imshow(magnitude, []), title('result');
hold on; 
quiver(magnitude .* cos(orientation), magnitude .* sin(orientation));

% Show orientation in colors
figure,
imshow(orientation ,[-pi,pi]); 
colormap(hsv);
colorbar;


% The following statements build a 3x3 subplot.
% It contains images of the binary magnitude for sigmas {1, 5, 10} and
% thresholds {0.025, 0.02, 0.013}
sigma  = 1;
subplot(3,3,1);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.025;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 1, threshold = 0.025');

subplot(3,3,2);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.02;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 1, threshold = 0.02');

subplot(3,3,3);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.013;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 1, threshold = 0.013');

sigma  = 5;
subplot(3,3,4);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.025;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 5, threshold = 0.025');

subplot(3,3,5);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.02;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 5, threshold = 0.02');

subplot(3,3,6);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.013;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 5, threshold = 0.013');

sigma  = 10;
subplot(3,3,7);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.025;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 10, threshold = 0.025');

subplot(3,3,8);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.02;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 10, threshold = 0.02');

subplot(3,3,9);
[magnitude, orientation] = gradmag(img,sigma);
threshold = 0.013;
magnitude2 = magnitude > threshold;
imshow(magnitude2, []), title('sigma = 10, threshold = 0.013');
