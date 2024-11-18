% Nouvelle matrice intrinsèque
K = [2744.05164535405, 0, 1500.17494433615;
     0, 2744.88655372905, 1990.40349740957;
     0, 0, 1]

% Nouveaux points d'image (sous-ensemble)
imagePoints = [
    0.6885e+03, 1.8840e+03, 1;
    0.6889e+03, 2.1052e+03, 1;
    0.6887e+03, 2.3218e+03, 1;
    0.6881e+03, 2.5342e+03, 1;
    0.6871e+03, 2.7429e+03, 1;
    0.6861e+03, 2.9480e+03, 1;
    0.9178e+03, 1.8912e+03, 1;
    0.9156e+03, 2.1103e+03, 1;
    0.9131e+03, 2.3250e+03, 1;
    0.9102e+03, 2.5357e+03, 1
];

% Points mondiaux
worldPoints = [
    0, 0, 1;
    0, 25, 1;
    0, 50, 1;
    0, 75, 1;
    0, 100, 1;
    0, 125, 1;
    25, 0, 1;
    25, 25, 1;
    25, 50, 1;
    25, 75, 1;
    % Ajoutez d'autres points si nécessaire pour correspondre
];

% Vérification du nombre de points
numPoints = size(worldPoints, 1);
if size(imagePoints, 1) ~= numPoints
    error('Le nombre de points mondiaux et de points d''image doit être le même.');
end

A = [];
for i = 1:numPoints
    X = worldPoints(i, 1);
    Y = worldPoints(i, 2);

    u = imagePoints(i, 1);
    v = imagePoints(i, 2);

    A = [A;
        -X, -Y, -1, 0, 0, 0, u*X, u*Y, u;
        0, 0, 0, -X, -Y, -1, v*X, v*Y, v];
end

[~, ~, V] = svd(A);
h = V(:, end);
H = reshape(h, 3, 3)';

% Normalisation de la matrice H
H = H / H(3, 3)

% Calcul de RT
RT = inv(K) * H
Re1= RT(:,1);
Re2= RT(:,2);
Te = RT(:,3);
Re3 = cross(Re1,Re2);

alpha = (nthroot(det([Re1,Re2,Re3]),4));
R1 = Re1/alpha;
R2 = Re2/alpha;
R3 = Re3/alpha^2;

R = [R1,R2,R3]
T = Te/alpha 
RT = cat(2,R,T)

P = alpha*K*RT
