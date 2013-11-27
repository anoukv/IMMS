function [  ] = color( imageName, colorSpace )

I = im2double(imread(imageName));

if strcmp(colorSpace, 'rgb')
    disp('rgb Color Space')
    
    % extract R G and B
    R = I(:, :, 1);
    G = I(:, :, 2);
    B = I(:, :, 3);
    
    % compute the normalized r, g, b
    r = double(R) ./ double((R + G + B));
    g = double(G) ./ double((R + G + B));
    b = double(B) ./ double((R + G + B));
    
    % show the resulting images for every channel
    subplot(1, 4, 1);
    imshow(I);
    title('Original');
    
    subplot(1, 4, 2);
    imshow(r, []);
    title('Red');
    
    subplot(1, 4, 3);
    imshow(g, []);
    title('Green');
    
    subplot(1, 4, 4);
    imshow(b, []);
    title('Blue');
    
end

if strcmp(colorSpace, 'opp')
    disp('Opponent Color Space')
    
    % extract R G and B
    R = I(:, :, 1);
    G = I(:, :, 2);
    B = I(:, :, 3);
    
    % compute the components, according to formulas in assignment
    O1 = (R - G) / sqrt(2);
    O2 = (R + G - 2 * B) / sqrt(6);
    O3 = (R + G + B) / sqrt(3);
    
    % show the resulting images for every channel
    subplot(1, 4, 1);
    imshow(I);
    title('Original');
    
    subplot(1, 4, 2);
    imshow(O1, []);
    title('O1');
    
    subplot(1, 4, 3);
    imshow(O2, []);
    title('O2');
    
    subplot(1, 4, 4);
    imshow(O3, []);
    title('O3');
end

if strcmp(colorSpace, 'HSV')
    disp('HSV Color Space')
    
    subplot(1, 4, 1);
    imshow(I);
    title('Original');
    
    % convert image to HSV
    I = rgb2hsv(I);

    % show the resulting images for every channel
    subplot(1, 4, 2);
    imshow(I(:, :, 1), []);
    title('Hue');
    
    subplot(1, 4, 3);
    imshow(I(:, :, 2), []);
    title('Saturation');
    
    subplot(1, 4, 4);
    imshow(I(:, :, 3), []);
    title('Value');

end

end

