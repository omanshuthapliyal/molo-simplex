%% Example with 2^n extreme points of the simplex all being efficient
% Testing parameters 2 from :
% https://www.lamsade.dauphine.fr/~projet_cost/ALGORITHMIC_DECISION_THEORY/pdf/Ehrgott/HanLecture2_ME.pdf

clear;
clc;

p = 5;
C = [eye(p); - eye(p)];
A = C;
b = ones(size(A,1),1);
C = [C, zeros(size(C,1))];
A = [A, eye(size(C,1))];