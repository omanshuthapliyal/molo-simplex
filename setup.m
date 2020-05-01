% Uncomment to run the final version
% inputFlag = false;
prompt = 'Do you want to enter user defined parameters ? [0/1] \n';
inputFlag = input(prompt);

%% Geometry of the problem
% This contains independent parameters that the user is not allowed to
% alter
% axis lengths of tumor
ax_t = [1;1;1];
V_t = 4*pi*ax_t(1)*ax_t(2)*ax_t(3)/3;
% axis of OARs (A, B, and C along columns 1, 2 & 3)
ax_o = [[1;0.5;2] , [0.5;0.5;0.5], [0.5;1/3;0.25]];
V_o = [0;0;0]';
for i = 1:3
    V_o(i) = 4*pi*ax_o(1,i)*ax_o(2,i)*ax_o(3,i)/3;
end
% normal tissue: assumed to be height 2 [in]
V_n = pi*10*5*2;

%% User define-able parameters
if inputFlag
    disp('Collimator parameters:');
    prompt = 'Enter radiation, F [J in^-2 s^-1]:';
    F = input(prompt); 
    
    disp('Density parameters:');
    prompt = 'Enter normal tissue density, mu_n [kg in^-3]:';
    mu_n = input(prompt);
    prompt = 'Enter OAR density, mu_o [kg in^-3]:';
    mu_o = input(prompt);
    prompt = 'Enter tumor density, mu_t [kg in^-3]:';
    mu_t = input(prompt);
    
    disp('Absorption parameters:');
    prompt = 'Enter normal tissue absorption coefficient, alpha_n [in^-1]:';
    alpha_n = input(prompt);
    prompt = 'Enter OAR absorption coefficient, alpha_o [in^-1]:';
    alpha_o = input(prompt);
    prompt = 'Enter tumor tissue absorption coefficient, alpha_t [in^-1]:';
    alpha_t = input(prompt);
    
    disp('Dosage levels:')
    prompt = 'Enter safe dosage level for normal tissue, s_n [c-Gy]';
    s_n = input(prompt);
    prompt = 'Enter safe dosage level for OAR, s_o [c-Gy]';
    s_o = input(prompt);
    prompt = 'Enter min dosage for tumor, d_t [c-Gy]';
    d_t = input(prompt);
else
    % Default parameters;
    disp('Loading default parameters . . .');
%     disp('Radiation, F [J in^-2 s^-1]: ');
    F = 10;
%     disp('Density parameters [kg in^-3]: :');
    mu_n = 17.2;
    mu_o = 20.1;
    mu_t = 27 ;
%     disp('Absorption coefficients [in^-1]: ');
    alpha_n = 0.1;
    alpha_o = 0.15;
    alpha_t = 0.7;
%     disp('Dosage levels [cGy]: ')
    s_n = 0.2;
    s_o = 0.1;
    d_t = 1.05;
end

%% Collimator stuff
params = [mu_n, mu_o, mu_t, alpha_n, alpha_o, alpha_t, F,... 
    s_n, s_o, d_t, V_n, V_o(1), V_o(2), V_o(3), V_t];
collimator;