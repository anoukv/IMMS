% this function returns the corner coordinates for the next frame of
% the tracking video

function [r, c] = getFrameTransition(im1, im2, r, c, Gd, regionSizeForOpticalFlow, imageFolder, imageName)

% the number of corner points
nPoints = size(r,1);

% prepare variables
Vx = zeros(nPoints,1);
Vy = zeros(nPoints,1);

% compute optical flow for every point
for x = 1:nPoints
    [v1, v2] = opticalFlowForPoints(r(x), c(x), im1, im2, regionSizeForOpticalFlow, Gd);
    Vx(x) = v1;
    Vy(x) = v2;
end

% save this in an image (and save this to 'imageFolder' directory
f = figure('visible','off');
imshow(im2,[]), hold on, quiver(c, r, Vx, Vy), plot(c, r, 'ro'), hold off;
print(f, '-r80', '-dtiff', strcat(imageFolder, imageName));
close(f);

% estimate the location of the corner in the next frame
% using the results from optical flow
transitionSpeed = 1.1;
c = c + Vx * transitionSpeed;
r = r + Vy * transitionSpeed;

end