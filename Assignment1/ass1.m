function [ ] = ass1(  )

V1 = [0, 0, 1];
V2 = [1, -1, 1];
V3 = [-1, -1, 1];
V4 = [1, 1, 1];
V5 = [-1, 1, 1];

V1 = V1 / norm(V1);
V2 = V2 / norm(V2);
V3 = V3 / norm(V3);
V4 = V4 / norm(V4);
V5 = V5 / norm(V5);

V = [V1; V2; V3; V4; V5];

I1 = im2double(imread('sphere1.png'));
I2 = im2double(imread('sphere2.png'));
I3 = im2double(imread('sphere3.png'));
I4 = im2double(imread('sphere4.png'));
I5 = im2double(imread('sphere5.png'));

G = zeros(size(I1)); % this is our albedo
N = zeros(512,512,3); % this is our normal
p = zeros(512, 512);
q = zeros(512, 512);

for x = 1:size(I1,1)
    for y = 1:size(I2,2)
        
        i_xy = transpose([I1(x,y), I2(x,y), I3(x,y), I4(x,y), I5(x,y)]);
        
        % Solve g
        I = diag(i_xy, 0);
        if I == 0
            g_xy = zeros(3,1);
        else
            g_xy = (I * i_xy) \ (I * V);
        end
        
        G(x,y) = norm(g_xy);
        
        % Computing normals
        N(x, y, 1) = g_xy(1) / G(x, y);
        N(x, y, 2) = g_xy(2) / G(x, y);
        N(x, y, 3) = g_xy(3) / G(x, y);
        
        % Computing p&q
        p(x, y) = N(x, y, 1) / N(x, y, 3);
        q(x, y) = N(x, y, 2) / N(x, y, 3);
        
    end
end

% NaN's are filtered.
p(isnan(p)) = 0;
q(isnan(q)) = 0;

% Constructing the height map.
hm = zeros(512, 512);
for j = 2:size(I1,2)
    hm(j,1) = hm(j-1, 1) + q(j, 1);
end

for i = 1:size(I1,1)
    for j = 2:size(I2,2)
        hm(i,j) = hm(i,j-1) + p(i,j);
    end
end

% set a limit and do some reductions.
limit = 16;

hm = hm(1:limit:512,1:limit:512);

X = N(:, :, 1);
Y = N(:, :, 2);
Z = N(:, :, 3);

X = X(1:limit:512,1:limit:512);
Y = Y(1:limit:512,1:limit:512);
Z = Z(1:limit:512,1:limit:512);

% removing some more NaN's
X(isnan(X)) = 0;
Y(isnan(Y)) = 0;
Z(isnan(Z)) = 0;

% Plotting the normals
figure, quiver3(X,Y,Z,X,Y,Z); 

% Plotting the surface height
[X_surf, Y_surf] = meshgrid(1:limit:512, 1:limit:512);
figure, plot3(X_surf, Y_surf, -hm);

end

