

% --- Initialisation de la vidéo ---
videoReader = VideoReader('C.mp4'); % Remplacez par le nom de votre vidéo
objectFrame = readFrame(videoReader);

% --- Sélection manuelle des points initiaux ---
figure;
imshow(objectFrame);
%title('Cliquez sur 4 points d\'intérêt dans l\'image');
[x_old, y_old] = ginput(4);
objectRegion = [x_old, y_old];

% --- Initialisation du tracker ---
tracker = vision.PointTracker('MaxBidirectionalError', 1);
initialize(tracker, [x_old, y_old], objectFrame);

% --- Dimensions du cube (les coins du cube en 3D) ---
cube3D = [0, 0, 0; 1, 0, 0; 1, 1, 0; 0, 1, 0; ... % Base
          0, 0, 1; 1, 0, 1; 1, 1, 1; 0, 1, 1]';
cube3D = cube3D * 10; % Taille du cube (mise à l'échelle par 100)

% --- Création de la vidéo de sortie ---
outputVideo = VideoWriter('output C', 'MPEG-4');
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
    cube3D_h = P * [cube3D; ones(1, size(cube3D, 2))];
    cube3D_h = cube3D_h ./ cube3D_h(3, :); % Normalisation pour obtenir les coordonnées 2D

    % Affichage du cube sur l'image
    imshow(img);
    hold on;
    plot([cube3D_h(1, 1:4), cube3D_h(1, 1)], [cube3D_h(2, 1:4), cube3D_h(2, 1)], 'r-', 'LineWidth', 2); % Base
    for i = 1:4
        plot([cube3D_h(1, i), cube3D_h(1, i+4)], [cube3D_h(2, i), cube3D_h(2, i+4)], 'b-', 'LineWidth', 2); % Arêtes verticales
    end
    plot([cube3D_h(1, 5:8), cube3D_h(1, 5)], [cube3D_h(2, 5:8), cube3D_h(2, 5)], 'g-', 'LineWidth', 2); % Sommet
    hold off;

    % Enregistrement de la frame dans la vidéo
    frame = getframe(gcf);
    writeVideo(outputVideo, frame);
end

% Fermeture du fichier vidéo
close(outputVideo);
