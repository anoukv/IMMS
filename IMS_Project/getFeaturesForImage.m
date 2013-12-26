function [ descriptors ] = getFeaturesForImage( location, dens, colorspace)

thisImage = imread(location);

if ndims(thisImage) ~= 3    % Not all images are coloured.
    descriptors = 0;
else
    thisImage = im2single(thisImage);
    binSize = 10;
    descriptors = zeros(0,0);
    
    if dens
        sift = vl_dsift;
    else
        sift = vl_sift;
    end
    
    switch colorspace
        case 'gray'
            [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            descriptors = desc;

        case 'RGB'
            % RGB images:
            [~, desc] = sift(thisImage(:,:,1), 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(thisImage(:,:,2), 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(thisImage(:,:,3), 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];
            
        case 'rgb'
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

            [~, desc] = sift(r, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(g, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(b, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

        case 'opp'
            % Opponent space:
            % rgb images:
            R = thisImage(:,:,1);
            G = thisImage(:,:,2);
            B = thisImage(:,:,3);

            O1 = (R - G) / sqrt(2);
            O2 = (R + G - 2 * B) / sqrt(6);
            O3 = (R + G + B) / sqrt(3);

            [~, desc] = sift(O1, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(O2, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors ; desc];

            [~, desc] = sift(O3, 'Step', binSize/2, 'Size', binSize);
            descriptors = [descriptors; desc];
    end
end
end 


