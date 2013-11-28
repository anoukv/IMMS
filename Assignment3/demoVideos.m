function demoVideos(readFolder, writeFolder, extension)
    sigma = 1.0;
    Gd = gaussianDer(sigma);
    regionSizeForOpticalFlow = 7;
    sigmaHarris = 1.5;
    k = 0.04;
    isActuallyARealCornerThreshold = 0.000005;
    betterThanNeighborsLeftAndRight = 10;

    % Read image locations
    imageNames = dir(fullfile(readFolder,extension));
    imageNames = {imageNames.name}';

    % sorting
    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);

    % Initialize most recent image
    oldImage = im2double(rgb2gray(imread(fullfile(readFolder,sortedImageNames{1}))));

    % Get the initial feature locations:
    [~, r, c] = harris(oldImage, sigmaHarris, k, isActuallyARealCornerThreshold, betterThanNeighborsLeftAndRight, false);

    for i = 2:length(sortedImageNames)
        disp(i);

        newImage = im2double(rgb2gray(imread(fullfile(readFolder,sortedImageNames{i}))));
        [r, c] = getFrameTransition(oldImage, newImage, r, c, Gd, regionSizeForOpticalFlow, writeFolder, sortedImageNames{i});

        [r, c] = dropFeaturesThatArOutOfTheImage(r, c, regionSizeForOpticalFlow, size(newImage));
        oldImage = newImage;
    end

    % setting up the workspace
    imageNames = dir(fullfile(writeFolder, extension));
    imageNames = {imageNames.name}';

    % sorting
    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);

    % prepare for writing to video
    outputVideo = VideoWriter(fullfile(writeFolder,'outputVideo.avi'));
    outputVideo.FrameRate = 10;
    open(outputVideo);

    for ii = 1:length(sortedImageNames)
        img = imread(fullfile(writeFolder,sortedImageNames{ii}));
        writeVideo(outputVideo,img);
    end

    close(outputVideo);
end

function [r, c] = dropFeaturesThatArOutOfTheImage(r, c, regionSize, imageDimensions)

r_ = -ones(size(r));
c_ = -ones(size(r));

counter = 1;
for i=1:size(r,1)
    if r(i) < imageDimensions(1)-regionSize-1 && r(i) > regionSize+1
        if c(i) < imageDimensions(1)-regionSize-1 && c(i) > regionSize+1
            r_(counter) = r(i);
            c_(counter) = c(i);
            counter = counter + 1;
        end
    end
end

r = r_(1:counter-1);
c = c_(1:counter-1);

end



