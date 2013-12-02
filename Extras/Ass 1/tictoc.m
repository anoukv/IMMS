tic;
rotateImage(a, pi/6, 'linear');
linear = toc;
tic;
c = rotateImage(a, pi/6, 'nearest');
nearest = toc;
linear
nearest
linear / nearest

