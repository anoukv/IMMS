% This script calls the necessary functions to create tracking videos of
% the person_toy and the pingpong image sequences

% the videos are saved in the (new) directories as described in
% 'writeFolder'

sigma = 1.0;
regionSizeForOpticalFlow = 7;
sigmaHarris = 1.5;
k = 0.04;
isActuallyARealCornerThreshold = 0.000005;
betterThanNeighborsLeftAndRight = 10;

readFolder = 'person_toy';
writeFolder = 'videoImagesPinpong/';
extension = '*.jpg';
mkdir 'videoImagesPinpong/';

demoVideos(readFolder, writeFolder, extension, sigma, regionSizeForOpticalFlow, sigmaHarris, k, isActuallyARealCornerThreshold, betterThanNeighborsLeftAndRight)


readFolder = 'pingpong';
writeFolder = 'videoImagesPingpong/';
extension = '*.jpeg';
mkdir 'videoImagesPingpong/';

demoVideos(readFolder, writeFolder, extension, sigma, regionSizeForOpticalFlow, sigmaHarris, k, isActuallyARealCornerThreshold, betterThanNeighborsLeftAndRight)