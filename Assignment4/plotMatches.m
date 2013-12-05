function [ output_args ] = plotMatches( im1, im2, points1, points2 )

% compute the height and the width of the new image
height = max(size(im1,1), size(im2,1));
width = size(im1, 2) + size(im2, 2);

% create the sideToSide image with the new dimensions
sideToSide = zeros(height, width);

% put in im1 and im2, right next to each other.
sideToSide(1:size(im1,1), 1:size(im1,2)) = im1;
sideToSide(1:size(im2,1), size(im1, 2)+1:end) = im2;

% move the second pair of points to the side...
points2(1, :) = points2(1, :) + size(im1, 2);

% get the x and y points
pointsX = [points1(1, :), points2(1, :)];
pointsY = [points1(2, :), points2(2, :)];

% show the images
imshow(sideToSide)
hold on
%plot all the points
plot(points1(1, :), points1(2, :), 'ro')
plot(points2(1, :), points2(2, :), 'ro')
% plot the connecting lines between the points
for i = 1:size(points1, 2)
    plot([points1(1, i), points2(1, i)], [points1(2, i), points2(2, i)]);
end

hold off;


end

