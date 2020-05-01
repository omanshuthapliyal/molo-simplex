% INPUTS:

% OUTPUTS:

% This script loads test parameters and cycles through 2^n efficient
% solutions
loadParams;

%% Phase 1
% generate first BFS
[m, n] = size(A);
[x_0, fval] = phase1(A,b);
x_0 = x_0(1:n);

%% Phase 2
% construct first efficient BFS
[x_star, B] = phase2(x_0, A, b, C);
S1 = [];
S1 = [S1, B];           % Set of unprocessed bases
S2 = [];                % Set of efficient bases

%% Phase 3
% generate efficient BFS of MOLO
[S1, S2] = phase3(S1, S2, C, A, b, 1);
disp(['Found ', num2str(size(S2, 2)), ' efficient bases for the MOLP']);
