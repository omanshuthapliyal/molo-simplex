%% Collimator parameters
width = 4; %[in]
height = 4; %[in]
jaw_w = 0.5; %[each jaw's width in in]
precision = 0.5;
X_mask = zeros(width/0.5, height/precision);
for i = 1:size(X_mask,1)
    xx = -(0.5*width) + i*jaw_w - jaw_w/2;
    for j = 1:size(X_mask,2)
        % Check if inside the circle or not
        yy = -(0.5*height) + j*precision - precision/2;
        is_interior = (xx^2 + yy^2 < 1);
        if is_interior
            X_mask(i,j) = 1;
        end
    end
end
X_mask = X_mask';
% coord = coord';
% imagesc(X_mask);
% title('Collimator jaw opening')
% hold on
% thet = linspace(0,2*pi);
% xc = (jaw_w*width)*cos(thet) + 0.5*width/jaw_w + jaw_w;
% yc = (precision*height*4)*sin(thet) + 0.5*height/precision + precision;
% plot(xc, yc, 'r');

A = jaw_w * precision;

%% Calculating the absoprtion for each pixel in X_mask
% direction = 1, 2, 3 for directions A, B, C, respectively
col_params = [A, F, width, height, jaw_w, precision];
J_A = dosageMatrix(X_mask, 1, params,col_params);
J_B = dosageMatrix(X_mask, 2, params,col_params);
J_C = dosageMatrix(X_mask, 3, params,col_params);