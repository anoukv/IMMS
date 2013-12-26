function [ descriptors ] = getFeaturesForImage( location, dens, colorspace)

thisImage = imread(location);

if ndims(thisImage) ~= 3    % Not all images are coloured.
    descriptors = 0;
else
    thisImage = im2single(thisImage);
    binSize = 10;
    descriptors = zeros(0,0);
    
    if dens
        sift = @vl_dsift;
    else
        sift = @vl_sift;
    end
    
    switch colorspace
        case 'gray'
            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = desc;

        case 'RGB'
            % RGB images:
            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
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

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];
            
            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
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

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];

            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors ; desc];
            
            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = [descriptors; desc];
    end
end
end 


