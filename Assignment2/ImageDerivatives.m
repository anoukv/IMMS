function F=ImageDerivatives(img,sigma,type)
%
%   Returns an image with a specified derivative applied to it.
%

% Prepare data
size = round(3 * sigma);
x = -size:size;

G0 = gaussian(sigma);
G1 = gaussianDer(G0, sigma);
G2 = (-sigma.^2 + x.^2)/(sigma.^4) .* G0;

% Switch on the type of derivative
switch type
    case 'x'
        F = conv2(img, G1, 'same');
    case 'y'
        F = transpose(conv2(transpose(img), G1, 'same'));
    case 'xx'
        F = conv2(img, G2, 'same');
    case 'yy'
        F = transpose(conv2(img, G2, 'same'));
    case {'xy', 'yx'}
        tmp = conv2(img, G1, 'same');
        F = transpose(conv2(transpose(tmp), G1, 'same'));
    otherwise
        throw('Invalid type.');
        
%figure, imshow(F,[]),  title(type);

end

