function demoVideos(readFolder, writeFolder, extension, sigma, regionSizeForOpticalFlow, sigmaHarris, k, isActuallyARealCornerThreshold, betterThanNeighborsLeftAndRight)
    
    % create Gaussian Derivative filter
    Gd = gaussianDer(sigma);

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

    % loop over all images, create the new frames (i.e. images with
    % keypoints and optical flow overlayed)
    % we should also drop keypoints that are too close to the edge of the
    % image, for optical flow we need to extract a region of a certain
    % size, making it impossible for a keypoint to be too close to an edge
    for i = 2:length(sortedImageNames)
        disp(i);

        newImage = im2double(rgb2gray(imread(fullfile(readFolder,sortedImageNames{i}))));
        [r, c] = getFrameTransition(oldImage, newImage, r, c, Gd, regionSizeForOpticalFlow, writeFolder, sortedImageNames{i});

        [r, c] = dropFeaturesThatArOutOfTheImage(r, c, regionSizeForOpticalFlow, size(newImage));
        oldImage = newImage;
    end

    % setting up the workspace for writing the video
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

    % write all the previously generated images to a video file
    for ii = 1:length(sortedImageNames)
        img = imread(fullfile(writeFolder,sortedImageNames{ii}));
        writeVideo(outputVideo,img);
    end

    close(outputVideo);
end





