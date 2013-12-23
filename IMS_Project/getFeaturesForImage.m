function [ descriptors ] = getFeaturesForImage( location, binSize )

thisImage = imread(location);
        
if ndims(thisImage) ~= 3    % Not all images are coloured.
    descriptors = 0;
else
    if nargin == 1
      binSize = 10;
    end
    thisImage = im2single(thisImage);

    [~, desc] = vl_dsift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);

    descriptors = zeros(1280, size(desc,2));
    DI = 0;
    % Gray image:
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;
    
    % RGB images:
    [~, desc] = vl_dsift(thisImage(:,:,1), 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(thisImage(:,:,2), 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(thisImage(:,:,3), 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;
    
    % rgb images:
    R = thisImage(:,:,1);
    G = thisImage(:,:,2);
    B = thisImage(:,:,3);
    
    S = R + G + B;
    
    r = R ./ S;
    g = G ./ S;
    b = B ./ S;
    
    r(isnan(r)) = 0;
    g(isnan(g)) = 0;
    b(isnan(b)) = 0;
        
    [~, desc] = vl_dsift(r, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(g, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(b, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;
    
    % Opponent space:
    O1 = (R - G) / sqrt(2);
    O2 = (R + G - 2 * B) / sqrt(6);
    O3 = (R + G + B) / sqrt(3);
    
    [~, desc] = vl_dsift(O1, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(O2, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
    DI = DI + 1;

    [~, desc] = vl_dsift(O3, 'Step', binSize/2, 'Size', binSize);
    descriptors(1+128*DI:128*DI+128, 1:size(desc,2)) = desc;
end

end

