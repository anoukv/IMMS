function demoVideos(readFolder, writeFolder, extension)
    sigma = 1.0;
    Gd = gaussianDer(sigma);
    regionSizeForOpticalFlow = 7;
    sigmaHarris = 1.5;
    k = 0.04;
    isActuallyARealCornerThreshold = 0.000005;
    betterThanNeighborsLeftAndRight = 10;
%     readFolder = 'person_toy';
%     writeFolder = 'videoImages/';
%     extension = '*.jpg';

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

    oldImage = newImage;
    end

    % setting up the workspace
    imageNames = dir(fullfile(writeFolder,'*.jpg'));
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



