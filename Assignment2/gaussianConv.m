function imOut = gaussianConv(image_path ,sigma_x ,sigma_y)

%
%   Returns a gaussian concolved image.
%

% Read original image
I = im2double(rgb2gray(imread(image_path)));

% Prepare data for calculations in both directions
Gx = gaussian(sigma_x);
Gy = gaussian(sigma_y);

% Perform convolution
imOut = conv2(Gx, Gy, I, 'same');

% Show result
imshow(imOut, []);
title('Blurred');

% built-in part:
% Perform the same task using the matlab builtin functions
G = fspecial('gaussian', max(size(Gx)), sigma_x);
imOut2 = conv2(I, G, 'same');

% Show de builtin equivalent
figure, imshow(imOut2, []);
title('Blurred by built-in method');

% Show some numerics about the difference between our solution and the
% builtin solution
disp('diff:');
sum(sum(imOut - imOut2))
mean(mean(imOut - imOut2))

% Show where the differences are.
figure, imshow(imOut - imOut2, []);

end

