function J = dosageMatrix(X_mask, direction, params, col_params)
mu_n = params(1);
mu_o= params(2);
mu_t = params(3);
alpha_n = params(4);
alpha_o = params(5);
alpha_t= params(6);
F = params(7);
s_n = params(8);
s_o = params(9);
d_t = params(10);
V_n = params(11);
V_o(1) = params(12);
V_o(2) = params(13);
V_o(3) = params(14);
V_t = params(15);

A = col_params(1);
F = col_params(2);
width = col_params(3);
height = col_params(4);
jaw_w = col_params(5);
precision = col_params(6);

nj = numel(find(X_mask>0));
ij = 1;
for i = 1:size(X_mask,2)
    for j = 1:size(X_mask,1)
        zz = -(0.5*width) + i*jaw_w - jaw_w/2;
        yy = -(0.5*height) + j*precision - precision/2;
        if X_mask(j,i) > 0
            if direction == 1
                len_0 = 10*sqrt(1 - yy^2/25);
                len_1 = 0;
                len_2 = 0;
                if (1 - 4*yy^2 - 0.25*zz^2 ) >= 0
                    len_1 = 3 + sqrt(1 - 4*yy^2 - 0.25*zz^2 );
                    len_1 = len_1 / 2;
                    len_2 = 3 - sqrt(1 - 4*yy^2 - 0.25*zz^2 );
                    len_2 = len_2 / 2;
                end
                len_3 = sqrt(1 - zz^2 - yy^2);
            elseif direction == 2
                xx = yy*cosd(45);
                yy = yy*sind(45);
                len_0 = norm( [5*cos(asin(sind(45)+yy/10));...
                    10*sind(45)+yy]);
                len_1 = 0;
                len_2 = 0;
                if (1 - 4*(yy)^2 - 4*zz^2 ) >= 0
                    len_1 = 3 + (sqrt(1 - 4*(yy)^2 - 4*zz^2 ))/2;
                    len_2 = 3 - (sqrt(1 - 4*(yy)^2 - 4*zz^2 ))/2;
                    len_2 = len_2 / 2;
                end
                len_3 =  sqrt(1 - zz^2 - yy^2);
            elseif direction == 3
                len_0 = 5*sqrt(1 - zz^2/100);
                len_1 = 0;
                len_2 = 0;
                xx = -yy;
                if (1 - 4 * xx^2 - 16*zz^2 ) >= 0
                    len_1 = 2 +( sqrt(1 - 4 * xx^2 - 16*zz^2 ))/3;
                    len_2 = 2 -( sqrt(1 - 4 * xx^2 - 16*zz^2 ))/3;
                end
                len_3 = sqrt(1 - zz^2 - yy^2);
            end
            L = [len_0 - len_1; len_1 - len_2; len_2 - len_3; 2*len_3];
            L = abs(L);
            J_1 = F * A * exp(-alpha_n * L(1)) / (mu_n * V_n);
            J_2 = J_1 * exp(-alpha_o * L(2)) * (mu_n * V_n) / (mu_o * V_o(direction));
            J_3 = J_2 * exp(-alpha_n * L(3)) * (mu_o * V_o(direction))/ (mu_n * V_n) ;
            J_4 = J_3 * exp(-alpha_t * L(4)) * (mu_n * V_n)/ (mu_t * V_t) ;
            J_5 = J_4 * exp(-alpha_n * L(3)) * (mu_t * V_t)/ (mu_n * V_n) ;
            J_6 = J_5 * exp(-alpha_n * L(2)) * (mu_n * V_n)/ (mu_o * V_o(direction)) ;
            J_7 = J_6 * exp(-alpha_n * L(1)) * (mu_o * V_o(direction))/ (mu_n * V_n) ;
            if L(2) == 0
                J_2 = 0;
                J_6 = 0;
            end
            J(ij,:) = [J_1 + J_3 + J_7 + J_5, J_2 + J_6, J_4]';
            ij = ij + 1;
        end
    end
end
J = J';