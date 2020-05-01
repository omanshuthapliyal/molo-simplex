function [S1, S2] = phase3(S1, S2, C, A, b, verbose)
[m, n] = size(A);
disp('-------------------------------------------------')
disp('PHASE III')
disp('-------------------------------------------------')
ind = [1:n]';

while ~isempty(S1)
    disp('    3.1. Picking a random basis from S1')
    i = randi(size(S1,2));    % Picking random bases B_prime from S1
    B = S1(:,i);
    S1(:,i) = [];
    S2 = [S2, B];
    N = setdiff(ind, B);
    A_ = A(:,B) \ A;
    b_ = A(:,B) \ b;
%     C_bar = C - C(:,B) * A_;
%     R = C_bar(:,N);
    R = C(:,N) - C(:,B) * inv(A(:,B)) * A(:,N);
    EN = N;     % Preparing set of efficient NBV indices
    for i = 1:numel(N)
        j = N(i);
        if(verbose)
            disp('        3.2. Checking if x_j is efficient')
        end
        % Check if x_j is an efficient NBV
%         R_j = C_bar(:,j);
        R_j = R(:,i);
        n_v = size(R,1);
        A_v = [eye(n_v), R, -R_j];
        b_v = zeros(n_v,1);
        f_v = -[ones(n_v,1); zeros(size(R,2)+1,1)]; % REMEMBER THIS IS A MAX PROBLEM
        [v_star, f_v_star] = simplex(0, f_v, A_v, b_v, 0);
        if f_v_star ~= 0
            if(verbose)
                disp('             3.2.1 x_j is inefficient !')
            end
            EN = setdiff(EN, j);
        end
    end
    for k = 1:numel(EN)
        j = EN(k);
        for ii = 1:numel(B)
           i = B(ii);
           B_ = union(setdiff(B, i), j);
           flag_1 = det(A(:,B_)) ~= 0;  % flag_1 checks for feasible basis
           if flag_1
               flag_1 = flag_1 & all( (A(:,B_) \ b) >= 0);
           end
           whole = [S1, S2];
           flag_2 = true;
           bool = ismember(whole, B_);  % Check if B_ is in S1 union S2
           flag_2 = any(all(bool, 1));    % 
           if (~flag_2 & flag_1)    % flag_2 = false <=> B not in S1 union S2
               S1 = [S1, B_];
           end
        end
    end
end
