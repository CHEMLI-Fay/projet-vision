img = imread("A.jpeg");
n = 4;

% Points d'image à tracer (données originales)
imagePoints = [
    0.6885e+03, 1.8840e+03;
    1.5817e+03	1.9116e+03;
    0.6871e+03	2.7429e+03;
    1.5461e+03	2.7447e+03
];

% Points réels à transformer
worldPoints = [
    0, 0, 1;
    100, 0, 1;
    0, 100, 1;
    100, 100, 1
];

% Transformation des points réels en points d'image avec H
imagePointsTransformed = (H * worldPoints')';

% Normalisation pour obtenir les coordonnées cartésiennes
imagePointsTransformed(:, 1) = imagePointsTransformed(:, 1) ./ imagePointsTransformed(:, 3);
imagePointsTransformed(:, 2) = imagePointsTransformed(:, 2) ./ imagePointsTransformed(:, 3);

% Affichage de l'image
figure;
imshow(img);
hold on;

% Ajout des points d'image originaux (en rouge, avec des cercles)
for i = 1:n
    plot(imagePoints(i, 1), imagePoints(i, 2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
end

% Ajout des points transformés (en bleu, avec des croix)
for i = 1:n
    plot(imagePointsTransformed(i, 1), imagePointsTransformed(i, 2), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
end

hold off;
