function [ H, r, c ] = harris( I, sigma, k, threshold, n, plotter )

% Create a Gaussian filter and Gaussian Derivative filter
G = gaussian(sigma);
Gd = gaussianDer(sigma);

% Compute Ix and Iy
Ix = conv2(I, Gd, 'same');
Iy = transpose(conv2(transpose(I), Gd, 'same'));

% Plotter method
if plotter == true
    subplot(1, 2, 1);
    imshow(Ix, []);
    title('Ix');

    subplot(1, 2, 2);
    imshow(Iy, []);
    title('Iy');
end

% Compute the squares of Ix, Iy and Ix * Iy
Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

% Compute A, B, and C (elements of the Harris matrix?)
A = conv2(G, G, Ix2, 'same');
B = conv2(G, G, Ixy, 'same');
C = conv2(G, G, Iy2, 'same');

H = (A .* C - B .^2 ) - k * (A + C).^2;

% Keep track of where we found corners
R = zeros(size(I));
for x = n+1:size(I, 1)-n-1
    for y = n+1:size(I, 2)-n-1
        R(x, y) = isCorner(H, x, y, threshold, n);
    end
end
[r,c] = find(R);

% Another plotter
if plotter == true
    figure, imshow(I, []), hold on, plot(c, r, 'ro'), hold off;
end

end

function [ bool ] = isCorner( H, x, y, threshold, n)

% First check wether the corner found is larger than the threshold
% Then check wether it is the maximum in it's (2n * 2n)+1 surrounding
% neighbors
if H(x,y) < threshold
    bool = 0;
else
    window =  H(x-n:x+n, y-n:y+n);
    maxx = max(max(window));
    if maxx == H(x,y)
        bool = 1;
    else
        bool = 0;
    end
end

end

