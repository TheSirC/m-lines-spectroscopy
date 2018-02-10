## Copyright (C) 2018 Claude-Alban
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} m-lines (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Claude-Alban <sirc@Python>
## Created: 2018-02-08

function [] = mlines (theta,m)
format long;

% Paramètres fixes
theta = deg2rad(theta); % Conversion en radians
l = 632.8e-9; % Longueur d'onde du laser
lambda = 703.2e-9; % Pas du réseau
neff = sin(theta) + l/lambda; % Condition du réseau
nc = 1; % Indice du superstrat (Air)
ns = 1.4570; % Indice du substrat (Silice)

% Équations d'onde du guide d'onde pour les modes TE et TM
% X(1) correspond à l'indice du guide
% X(2) correspond à l'épaisseur du guide

f = @(X) m * pi - X(2)*(2*pi/l)*sqrt(X(1)^2 - neff^2)...
                + atan(sqrt((neff^2-nc^2)/(X(1)^2-neff^2)))...
                + atan(sqrt((neff^2-ns^2)/(X(1)^2-neff^2))); % Modes TE
g = @(X) m * pi - X(2)*(2*pi/l)*sqrt(X(1)^2 - neff^2)...
                + atan((X(1)/nc)*sqrt((neff^2-nc^2)/(X(1)^2-neff^2)))...
                + atan((X(1)/nc)*sqrt((neff^2-ns^2)/(X(1)^2-neff^2))); % Modes TM

% Résolution numérique                 
printf("Pour le mode %g\n",m);                
[resultatTE,~,~] = fsolve(f,[neff; 0],optimset("TolX",1e-10,"ComplexEqn","off","AutoScaling","on"));
[resultatTM,~,~] = fsolve(g,[neff; 0],optimset("TolX",1e-10,"ComplexEqn","off","AutoScaling","on"));

printf("Pour le mode TE,\n indice:%g\n épaisseur:%g\n\n",resultatTE(1),resultatTE(2));
printf("Pour le mode TM,\n indice:%g\n épaisseur:%g\n\n",resultatTM(1),resultatTM(2));

endfunction
