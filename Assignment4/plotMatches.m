function [ output_args ] = plotMatches( im1, im2, points1, points2 )

height = max(size(im1,1), size(im2,1));

totalWidth = size(im1, 2) + size(im2, 2);

sideToSide = zeros(height, totalWidth);

sideToSide(1:size(im1,1), 1:size(im1,2)) = im1;
sideToSide(1:size(im2,1), size(im1, 2)+1:end) = im2;

% move the second pair of points to the side...
points2(1, :) = points2(1, :) + size(im1, 2);


pointsX = [points1(1, :), points2(1, :)];
pointsY = [points1(2, :), points2(2, :)];

imshow(sideToSide)
hold on
plot(points1(1, :), points1(2, :), 'ro')
plot(points2(1, :), points2(2, :), 'ro')
for i = 1:size(points1, 2)
    plot([points1(1, i), points2(1, i)], [points1(2, i), points2(2, i)]);
end


hold off;


end

