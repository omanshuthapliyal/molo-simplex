function [x_0, f_bar] = phase1(A, b)

% Phase 1
% generate first BFS
disp('-------------------------------------------------')
disp('PHASE I')
disp('-------------------------------------------------')
[m, n] = size(A);
% m : number of equality constraints
% n : number of decision variables x
% r : C x \in R^{r}, or, C \in R^{r \times n}

% solving LP_bar
% min 1^T z
% s.t. Ax + Iz = b
% x>=0, z>=0
[x_0, f_bar] = simplex(0, [zeros(1,n), ones(1,m)]', ...
    [A, eye(m)], b, 0);
if (f_bar > 0)
    disp('     Aborting . . .')
    error('    1.1 LP* is infeasible');
end
disp('    1.1 Found a feasible solution to MOLP')
end
