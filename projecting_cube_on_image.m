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

% --- Points 3D du cube ---
% Sommets d’un cube dans le repère 3D
cube3D = [
    0, 0, 0;  % Coin 1 (base)
    100, 0, 0;  % Coin 2 (base)
    100, 100, 0;  % Coin 3 (base)
    0, 100, 0;  % Coin 4 (base)
    0, 0, 100;  % Coin 5 (haut)
    100, 0, 100;  % Coin 6 (haut)
    100, 100, 100;  % Coin 7 (haut)
    0, 100, 100;  % Coin 8 (haut)
]';

% Ajout d'une ligne homogène pour les points 3D
cube3D_h = [cube3D; ones(1, size(cube3D, 2))];

% --- Projection des points 3D avec P ---
cube2D_h = P * cube3D_h;

% Normalisation pour obtenir des coordonnées 2D cartésiennes
cube2D = cube2D_h ./ cube2D_h(3, :);

% --- Affichage de l'image et des éléments ---
figure;
imshow(img);
hold on;

% --- Tracer les points d'origine (rouges) ---
for i = 1:n
    plot(imagePoints(i, 1), imagePoints(i, 2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
end

% --- Tracer les points transformés (bleus) ---
for i = 1:n
    plot(imagePointsTransformed(i, 1), imagePointsTransformed(i, 2), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
end

% --- Tracer le cube ---
% Base du cube (rouge)
plot([cube2D(1, 1:4), cube2D(1, 1)], [cube2D(2, 1:4), cube2D(2, 1)], 'r-', 'LineWidth', 2);

% Arêtes verticales du cube (bleues)
for i = 1:4
    plot([cube2D(1, i), cube2D(1, i+4)], [cube2D(2, i), cube2D(2, i+4)], 'b-', 'LineWidth', 2);
end

% Sommet du cube (vert)
plot([cube2D(1, 5:8), cube2D(1, 5)], [cube2D(2, 5:8), cube2D(2, 5)], 'g-', 'LineWidth', 2);

hold off;
%title('Points et cube projeté sur l\'image');

