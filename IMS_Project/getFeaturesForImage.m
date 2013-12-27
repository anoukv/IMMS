function [ descriptors ] = getFeaturesForImage( location, dens, colorspace)
% read the image, if necessary leave out non-colored images (we cannot use
% these, because we also want to do for example rgbSIFT). 
thisImage = imread(location);

if ndims(thisImage) ~= 3    % Not all images are coloured.
    descriptors = 0;
else
    thisImage = im2single(thisImage);
    binSize = 10;
    descriptors = zeros(0,0);
    
    % determine which sift we are going to use
    if dens
        sift = @vl_dsift;
    else
        sift = @vl_sift;
    end
    
    % rgb images:
    R = thisImage(:,:,1);
    G = thisImage(:,:,2);
    B = thisImage(:,:,3);
    switch colorspace
        case 'gray'
            if dens
                [~, desc] = sift(rgb2gray(thisImage), 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(rgb2gray(thisImage));
            end
            descriptors = desc';

        case 'caps_rgb'
            % RGB images:
            if dens
                [~, desc] = sift(R, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(R);
            end
            descriptors = [descriptors ; desc'];

            if dens
                [~, desc] = sift(G, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(G);
            end
            descriptors = [descriptors ; desc'];

            if dens
                [~, desc] = sift(B, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(B);
            end
            descriptors = [descriptors ; desc'];
            
        case 'rgb'
            S = R + G + B;

            r = R ./ S;
            g = G ./ S;
            b = B ./ S;

            r(isnan(r)) = 0;
            g(isnan(g)) = 0;
            b(isnan(b)) = 0;

            if dens
                [~, desc] = sift(r, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(r);
            end
            descriptors = [descriptors; desc'];

            if dens
                [~, desc] = sift(g, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(g);
            end
            descriptors = [descriptors ; desc'];
            
            if dens
                [~, desc] = sift(b, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(b);
            end
            descriptors = [descriptors ; desc'];

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
                [~, desc] = sift(O1, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(O1);
            end
            descriptors = [descriptors ; desc'];

            if dens
                [~, desc] = sift(O2, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(O2);
            end
            descriptors = [descriptors ; desc'];
            
            if dens
                [~, desc] = sift(O3, 'Step', binSize/2, 'Size', binSize);
            else
                [~, desc] = sift(O3);
            end
            descriptors = [descriptors; desc'];
    end
    descriptors = descriptors';
end

end 


