%We will use PCA for dimensional reduction

%Example dataset
% Initialization
clear;
% The following command loads the dataset. You should now have the variable X in your environment
load ('ex7data1.mat');

% Visualize the example dataset
figure;
plot(X(:, 1), X(:, 2), 'bo');
xlabel("x1 data points");
ylabel('x2 data points');
title('Visualizing data set');
axis([0.5 6.5 2 8]); axis square;

% Before running PCA, it is important to first normalize X
[X_norm, mu, ~] = featureNormalize(X);

% Run PCA
[U, S] = pca(X_norm);

% Draw the eigenvectors centered at mean of data. These lines show the directions of maximum variations in the dataset.
hold on;
drawLine(mu, mu + 1.5 * S(1,1) * U(:,1)', '-k', 'LineWidth', 2);
drawLine(mu, mu + 1.5 * S(2,2) * U(:,2)', '-k', 'LineWidth', 2);
title('Visualizing 2D dataset with PCA applied and u vector');
hold off;
fprintf('Top eigenvector U(:,1) = %f %f \n', U(1,1), U(2,1));

%Dimensnioanlity Reduction with PCA
% Project the data onto K = 1 dimension
K = 1;
Z = projectData(X_norm, U, K);
fprintf('Projection of the first example: %f\n', Z(1));

%Reconstructing an approximation of the data
X_rec  = recoverData(Z, U, K);
fprintf('Approximation of the first example: %f %f\n', X_rec(1, 1), X_rec(1, 2));

%Visualizing the projections
%  Plot the normalized dataset (returned from pca)
figure;
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
title('Normalized and Projected data after PCA');
axis([-4 3 -4 3]); axis square
%  Draw lines connecting the projected points to the original points
hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off

%% Face Image data set
%  Load Face dataset
load ('ex7faces.mat')
%  Display the first 100 faces in the dataset
close all;
figure;
displayData(X(1:100, :));
title('Original');

%To run PCA on face dataset, we first normalize the dataset by subtracting
%the mean of each feature from the data matrix X.
%After PCA, we will obtain the principal components of the dataset. 
%Each principal component is a vector of length n (n = 1024).
%We can visualize each of them into a 32x32 matrix, that corresponds to the
%pixels in original dataset.
[X_norm, ~, ~] = featureNormalize(X);

% Run PCA
[U, ~] = pca(X_norm);

% Visualize the top 36 eigenvectors found
figure;
displayData(U(:, 1:36)');
title('Post compression');

K = 100;
Z = projectData(X_norm, U, K);

fprintf('The projected data Z has a size of: %d x %d\n', size(Z));


%To understand what is lost in dimension reduction, we can recover the data
%using only the projected dataset.
X_rec  = recoverData(Z, U, K);

% Display normalized data
figure;
subplot(1, 2, 1);
displayData(X_norm(1:100,:));
title('Original faces');
axis square;

% Display reconstructed data from only k eigenfaces
subplot(1, 2, 2);
displayData(X_rec(1:100,:));
title('Recovered faces');
axis square;