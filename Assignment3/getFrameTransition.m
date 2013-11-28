function [r, c] = getFrameTransition(im1, im2, r, c, Gd, regionSizeForOpticalFlow, imageFolder, imageName)

nPoints = size(r,1);

Vx = zeros(nPoints,1);
Vy = zeros(nPoints,1);

for x = 1:nPoints
    [v1, v2] = opticalFlowForPoints(r(x), c(x), im1, im2, regionSizeForOpticalFlow, Gd);
    Vx(x) = v1;
    Vy(x) = v2;
end

f = figure('visible','off');
imshow(im2,[]), hold on, quiver(c, r, Vx, Vy), plot(c, r, 'ro'), hold off;
print(f, '-r80', '-dtiff', strcat(imageFolder, imageName));
close(f);

transitionSpeed = 1.1;
c = c + Vx * transitionSpeed;
r = r + Vy * transitionSpeed;

end