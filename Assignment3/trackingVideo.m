function trackingVideo()

sigma = 1.0;
Gd = gaussianDer(sigma);
regionSizeForOpticalFlow = 7;
imageFolder = 'videoImages/';

% Read image locations
workingDir = 'person_toy';
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';

% sorting
imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);
[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);

% Initialize most recent image
oldImage = im2double(rgb2gray(imread(fullfile(workingDir,sortedImageNames{1}))));

% Get the initial feature locations:
[r, c] = getInitialCornerPoints(oldImage, Gd, regionSizeForOpticalFlow);

for i = 2:length(sortedImageNames)
    disp(i);
    newImage = im2double(rgb2gray(imread(fullfile(workingDir,sortedImageNames{i}))));

    [r, c] = getFrameTransition(oldImage, newImage, r, c, Gd, regionSizeForOpticalFlow, imageFolder, sortedImageNames{i});

    oldImage = newImage;
end


end

function [r, c] = getFrameTransition(im1, im2, r, c, Gd, regionSizeForOpticalFlow, imageFolder, imageName)
nPoints = size(r,1);

Ix = conv2(im1, Gd, 'same');
Iy = transpose(conv2(transpose(im1), Gd, 'same'));
It = im1 - im2;

Vx = zeros(nPoints,1);
Vy = zeros(nPoints,1);

for x = 1:nPoints
    [v1, v2] = opticalFlowForPoints(r(x), c(x), Ix, Iy, It, regionSizeForOpticalFlow);
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

function [r, c] = getInitialCornerPoints(im1, Gd, regionSizeForOpticalFlow)

sigma = 1.5;
k = 0.04;
isActuallyARealCornerThreshold = 0.000005;
betterThanNNeighborsLeftAndRight = 10;

[~, r, c] = harris(im1, sigma, k, isActuallyARealCornerThreshold, betterThanNNeighborsLeftAndRight);

end

function [v1, v2] = opticalFlowForPoints(x, y, Ix, Iy, It, regionSize)

xR = round(x);
yR = round(y);

IxR = Ix(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);
IyR = Iy(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);
ItR = It(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);

v = getV(IxR, IyR, ItR);

v1 = v(1);
v2 = v(2);
        
end

function v = getV(Ix, Iy, It)

Ixvec = reshape(Ix, size(Ix, 1) * size(Ix, 2), 1);
Iyvec = reshape(Iy, size(Iy, 1) * size(Iy, 2), 1);
b = reshape(It, size(It, 1) * size(It, 1), 1);

A = [Ixvec, Iyvec];

v = pinv(A' * A) * A' * b;

end