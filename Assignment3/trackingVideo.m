function trackingVideo()

sigma = 1.5;
Gd = gaussianDer(sigma);
regionSizeForOpticalFlow = 7;

if 0
    getInitialCornerPoints(1);
else
    % Read image locations
    workingDir = 'person_toy';
    imageNames = dir(fullfile(workingDir,'*.jpg'));
    imageNames = {imageNames.name}';

    % sorting
    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);

    % Open video writer
    outputVideo = VideoWriter(fullfile(workingDir,'trackingVideo.avi'));
    open(outputVideo);

    % Initialize most recent image
    oldImage = im2double(rgb2gray(imread(fullfile(workingDir,sortedImageNames{1}))));

    % Get the initial feature locations:
    [r, c] = getInitialCornerPoints(oldImage, Gd, regionSizeForOpticalFlow);

    for i = 2:length(sortedImageNames)
        newImage = im2double(rgb2gray(imread(fullfile(workingDir,sortedImageNames{i}))));
        
        [r, c] = getFrameTransition(oldImage, newImage, r, c, Gd, regionSizeForOpticalFlow);
        
        oldImage = newImage;
    end

    close(outputVideo);
end

end

function [r, c] = getFrameTransition(im1, im2, r, c, Gd, regionSizeForOpticalFlow)
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

%f = figure('visible','off'), 
figure, imshow(im2,[]), hold on, quiver(c, r, Vx, Vy), plot(c, r, 'ro'), hold off;



transitionSpeed = 0.18;
c = c + Vx * transitionSpeed;
r = r + Vy * transitionSpeed;

end

function [r, c] = getInitialCornerPoints(im1, Gd, regionSizeForOpticalFlow)

sigma = 1.5;
Gd = gaussianDer(sigma);
k = 0.04;
isActuallyARealCornerThreshold = 0.000005;
betterThanNNeighborsLeftAndRight = 10;

im1 = im2double(rgb2gray(imread('person_toy/00000001.jpg')));
im2 = im2double(rgb2gray(imread('person_toy/00000002.jpg')));

[~, r, c] = harris(im1, sigma, k, isActuallyARealCornerThreshold, betterThanNNeighborsLeftAndRight);
nPoints = size(r,1);

disp('Number of corners: ');
disp(nPoints);

% figure, imshow(im1,[]), hold on, plot(c, r, 'ro'), hold off;
% imshow(im1-im2,[])

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

figure,
imshow(im1-im2,[]), hold on, quiver(c, r, Vx, Vy), plot(c, r, 'ro'), hold off;

end

function [v1, v2] = opticalFlowForPoints(x, y, Ix, Iy, It, regionSize)

IxR = Ix(x-regionSize:x+regionSize, y-regionSize:y+regionSize);
IyR = Iy(x-regionSize:x+regionSize, y-regionSize:y+regionSize);
ItR = It(x-regionSize:x+regionSize, y-regionSize:y+regionSize);

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