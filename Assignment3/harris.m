function [ H, r, c ] = harris( I, sigma, k, threshold, n )
G = gaussian(sigma);
Gd = gaussianDer(sigma);

Ix = conv2(I, Gd, 'same');

% subplot(1, 2, 1);
% imshow(Ix, []);
% title('Ix');

Iy = transpose(conv2(transpose(I), Gd, 'same'));

% subplot(1, 2, 2);
% imshow(Iy, []);
% title('Iy');

Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

A = conv2(G, G, Ix2, 'same');
B = conv2(G, G, Ixy, 'same');
C = conv2(G, G, Iy2, 'same');

H = (A .* C - B .^2 ) - k * (A + C).^2;

R = zeros(size(I));

for x = n+1:size(I, 1)-n-1
    for y = n+1:size(I, 2)-n-1
        R(x, y) = isCorner(H, x, y, threshold, n);
    end
end
[r,c] = find(R);

%figure, imshow(I, []), hold on, plot(c, r, 'ro'), hold off;

end

function [ bool ] = isCorner( H, x, y, threshold, n)
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

