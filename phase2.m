function [x_star, B] = phase2(x_0, A, b, C)

% [m, n] = size(A);
disp('-------------------------------------------------')
disp('PHASE II')
disp('-------------------------------------------------')
% zeta = [w ; u] \in R^{n + m}
f_bar = [(C*x_0) ; b];
nw = numel(C*x_0);
nu = numel(b);
% min  u^T b + w^T C x_0
% <=>  [(Cx_0)^T, b^T] * [w; u]
% s.t. A^T u + C^T w >= 0 , w >= 1
%  <=> [C^T , A^T; I, 0] [w; u] >= [0;1]
%  <=> [A_bar, -I][zeta; y] = [0;1]
%      [w;u;y] >= [1;0;0]
% y is the artificial variable
A_zeta = [C', A'; eye(nw), zeros(nw,nu)];
b_zeta = [zeros(size(C',1),1); ones(nw,1)];
[Zeta, f_opt_zeta, B] = simplex(0, f_bar, A_zeta, b_zeta, 1);

% Phase II.a.
% Finding initial BFS

% If infeasible STOP, no efficient solutions exist
% if exitflag > 0
%     error('MOLP has no Efficient Solutions')
% else
disp('    2.1 Problem is feasible . . .')
disp('    2.2 Finding optimal basis B')
w_hat = Zeta(1:nw);
% w_hat = lambda
% Find basis of the following LP
% min \hat{w}^T Cx
% s.t. Ax = b
%      x >= 0
[x_star, f_star, B] = simplex(0, (w_hat' * C)', A, b, 0);
B = B';
% Find optimal basis from the solution x_star
assert(det(A(:,B)) ~= 0, 'B is not invertible! \n Aborting . . .');
% end

end