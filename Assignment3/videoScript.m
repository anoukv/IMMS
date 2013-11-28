workingDir = 'videoImages';
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';

% sorting
imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);

[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);

outputVideo = VideoWriter(fullfile(workingDir,'lego.avi'));
outputVideo.FrameRate = 10;
open(outputVideo);

for ii = 1:length(sortedImageNames)
    img = imread(fullfile(workingDir,sortedImageNames{ii}));

    writeVideo(outputVideo,img);
end

close(outputVideo);

