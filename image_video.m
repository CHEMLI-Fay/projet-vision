close all;
clear all;

% --- Chargement des paramètres fournis ---

K = 1.0e+03 * [2.7441, 0, 1.5002; ...
               0, 2.7449, 1.9904; ...
               0, 0, 0.0010];

H = 1.0e+03 * [0.0095, 0.0002, 0.6891; ...
               0.0010, 0.0096, 1.8841; ...
               0, 0, 0.0010];

RT = [0.0033, -0.0001, -0.2956, -90.3458; ...
      0.0001, 0.0032, -0.0387, -11.8328; ...
      0.0004, 0.0004, 1.0000, 305.6786];

P = 1.0e+03 * [0.0095, 0.0002, 0.0039, 0.6891; ...
               0.0010, 0.0096, 0.0053, 1.8841; ...
               0.0000, 0.0000, 0.0000, 0.0010];

R = [0.9975, -0.0370, -0.1030; ...
     0.0280, 0.9887, -0.1212; ...
     0.1075, 0.1175, 0.9873];

T = [-90.3458; -11.8328; 305.6786];

% --- Initialisation de la vidéo ---
videoReader = VideoReader('input_video.mov'); % Remplacez par le nom de votre vidéo
objectFrame = readFrame(videoReader);

% --- Sélection manuelle des points initiaux ---
figure;
imshow(objectFrame);
title('Cliquez sur 4 points d\'intérêt dans l\'image');
[x_old, y_old] = ginput(4);
objectRegion = [x_old, y_old];

% --- Initialisation du tracker ---
tracker = vision.PointTracker('MaxBidirectionalError', 1);
initialize(tracker, [x_old, y_old], objectFrame);

% --- Dimensions du cube (les coins du cube en 3D) ---
cube3D = [0, 0, 0; 1, 0, 0; 1, 1, 0; 0, 1, 0; ... % Base
          0, 0, 1; 1, 0, 1; 1, 1, 1; 0, 1, 1]';
cube3D = cube3D * 100; % Taille du cube (mise à l'échelle par 100)

% --- Création de la vidéo de sortie ---
outputVideo = VideoWriter('output_cube_video', 'MPEG-4');
open(outputVideo);

% --- Boucle principale pour traiter chaque frame ---
while hasFrame(videoReader)
    img = readFrame(videoReader); % Lire une frame
    [points, validity] = tracker(img); % Suivre les points

    % Vérification de la validité des points
    if sum(validity) < 4
        warning('Trop peu de points valides pour continuer.');
        break;
    end

    % Mise à jour des points
    x_new = points(:, 1);
    y_new = points(:, 2);
    x_old = x_new;
    y_old = y_new;

    % Projection des points 3D du cube
    cube3D_h
