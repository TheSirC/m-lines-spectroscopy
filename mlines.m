function [] = mlines (theta,m)
format long;

% Paramètres fixes
theta = deg2rad(theta); % Conversion en radians
lambda = 632.8e-9; % Longueur d'onde du laser
pas = 703.2e-9; % Pas du réseau
neff = sin(theta) + lambda/pas; % Condition du réseau
nc = 1; % Indice du superstrat (Air)
ns = 1.4570; % Indice du substrat (Silice)

% Équations d'onde du guide d'onde pour les modes TE et TM
% X(1) correspond à l'indice du guide
% X(2) correspond à l'épaisseur du guide

F = @(X)([m * pi - X(2) * (2 * pi / lambda) * sqrt(X(1)^2-neff^2)...
         + atan(sqrt((neff^2 - nc^2)/(X(1)^2 - neff^2)))...
         + atan(sqrt((neff^2 - ns^2)/(X(1)^2 - neff^2))), ... % Modes TE
         m * pi - X(2) * (2 * pi / lambda) * sqrt(X(1)^2-neff^2)...
         + atan((X(1) / nc)*sqrt((neff^2 - nc^2)/(X(1)^2 - neff^2)))...
         + atan((X(1) / nc)*sqrt((neff^2 - ns^2)/(X(1)^2 - neff^2)))... % Modes TM
         ]);
% Résolution numérique
x0 = [1e-9; 1e-9]; % D�part de la simulation num�rique
X = fsolve(F, x0);
Y =[neff,X(1),X(2)];
sprintf('Pour le mode %d,\n indice:%g\n épaisseur:%g\n\n',m,X(1),abs(X(2)))

end
