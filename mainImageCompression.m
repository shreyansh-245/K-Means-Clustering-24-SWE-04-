% K-means method is used to compress an image 
%  Load an image of a bird
A = double(imread('bird_small.png'));
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);

%Reshape the image into a Nx3 matrix where N = no. of pixels.
%Each row retains Red, Green and Blue pixel values.
X = reshape(A, img_size(1) * img_size(2), 3);

K = 16;
max_iters = 10;
initial_centroids = kMeansInitCentroids(X, K);
% Run K-Means
[centroids, ~] = runkMeans(X, initial_centroids, max_iters);

%After finding the top 16 colors to represent the image, we can now assign
%each pixel position to its closest centroid using the findClosestCentroids
%function
%Old image size = 24X128x128
%New imagesize = 128x128x4 + 16x24(dictionary size, not image)
% Find closest cluster members
idx = findClosestCentroids(X, centroids);

X_recovered = centroids(idx,:);

% Reshape the recovered image into proper dimensions
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Display the original image 
figure;
subplot(1, 2, 1);
imagesc(A); 
title('Original');
axis square

% Display compressed image side by side
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));
axis square