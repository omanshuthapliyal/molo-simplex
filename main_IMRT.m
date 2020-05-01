%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  DESCRIPTION OF CODE COMPONENTS
% main_IMRT.m : calls other scripts to setup the IMRT problem
% |
% |-- setup.m : sets up the parameters for matrices C, A, and b
% | |
% | |-- collimator.m : sets up collimator parameters
% |    |
% |    |-- dosageMatrix.m : function to calculate matrices J's
% |
% |-- phase1.m : finds the first BFS
% |   |
% |   |-- simplex.m : Simplex algorithm implementation
% |       |          [SIMPLEX.M taken from Github and cited]
% |       |-- rsimplex.m 
% |       |-- pivot.m      [dependent functions]
% |       |-- findMinRation.m 
% |
% |-- phase2.m : constructs first efficient BFS
% |
% |-- phase3.m : generate efficient BFSs
% |
% main_v2.m : 
% Validates the MultiObjective Simplex solver from Phase I, 
% Phase II, and Phase III against the recommended problem with 2^n 
% efficient solutions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
% clc;

setup;

C = J_A + J_B + J_C;
Aeq = C;
b = [s_n; s_o; d_t];
Aeq = [Aeq ; zeros(1,size(Aeq,2))];
Aeq = [Aeq, eye(4)];
Aeq(3,end-1) = -1;
Aeq(3,end) = 1;
Aeq(4,:) = [];
C = [C, zeros(3,4)];

%% Phase 1
% generate first BFS
[m, n] = size(Aeq);
[x_0, fval] = phase1(Aeq,b);
x_0 = x_0(1:n);

%% Phase 2
% construct first efficient BFS
[x_star, B] = phase2(x_0, Aeq, b, C);
S1 = [];
S1 = [S1, B];           % Set of unprocessed bases
S2 = [];                % Set of efficient bases

%% Phase 3
% generate efficient BFS of MOLO
verbose = false;
[S1, S2] = phase3(S1, S2, C, Aeq, b, verbose);
disp(['Found ', num2str(size(S2, 2)), ' efficient bases for the MOLP']);


%% Checking for constraint violation
disp('-------------------------------------------------');
disp('Checking Efficient Solution');
disp('-------------------------------------------------');

ind = randi(size(S2,2));
Basis = S2(:,ind);
BB = Aeq(:,Basis);
xStar = zeros(size(Aeq,2),1);
xStar(Basis) = BB\b;
disp('Efficient x* is : ');
xStar'
cost = C * xStar;
disp(['Dosage to the normal tissue [must be <= ', num2str(s_n), 'cGy] : ']);
disp([num2str(cost(1)),' [cGy]']);
disp(['Dosage to the OAR tissue [must be <= ', num2str(s_o), 'cGy] : ']);
disp([num2str(cost(2)),' [cGy]']);
disp(['Dosage to the tumor [must be >= ', num2str(d_t), 'cGy] : ']);
disp([num2str(cost(3)),' [cGy]']);
