clear;
dir;
%Finding closest centroids
% Load an example dataset that we will be using
load('ex7data2.mat');

% Select an initial set of centroids
K = 3; % 3 Centroids
initial_centroids = [3 3; 6 2; 8 5];

% Find the closest centroids for the examples using the initial_centroids
idx = findClosestCentroids(X, initial_centroids);
fprintf('Closest centroids for the first 3 examples: %d %d %d\n', idx(1:3))


% Compute means based on the closest centroids found in the previous part.
centroids = computeCentroids(X, idx, K);
fprintf('Centroids computed after initial finding of closest centroids: \n %f %f \n %f %f\n %f %f\n' , centroids');


%K-means on example dataset
% Load an example dataset
load('ex7data2.mat');
% Settings for running K-Means
max_iters = 10;

initial_centroids = [3 3; 6 2; 8 5];

% Run K-Means algorithm. The 'true' at the end tells our function to plot the progress of K-Means
figure('visible','on');
hold on; 
plotProgresskMeans(X, initial_centroids, initial_centroids, idx, K, 1); 
xlabel('Press ENTER in command window to advance','FontWeight','bold','FontSize',14)
[~, ~] = runkMeans(X, initial_centroids, max_iters, true);
set(gcf,'visible','off'); hold off;


%Random Initialization
K = 3;
random_init_centroids = kMeansInitCentroids(X, K);
max_iters = 10;

% Run K-Means algorithm. The 'true' at the end tells our function to plot the progress of K-Means
figure('visible','on');
hold on; 
plotProgresskMeans(X, initial_centroids, initial_centroids, idx, K, 1); 
xlabel('Press ENTER in command window to advance','FontWeight','bold','FontSize',14)
[~, ~] = runkMeans(X, initial_centroids, max_iters, true);
set(gcf,'visible','off'); hold off;

