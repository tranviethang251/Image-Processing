function [bi_image] = bilinear_interpolation(I) 
% Bayer CFA 
bayer_CFA_image = zeros(size(I)) ; 
% red color 
bayer_CFA_image(1:2:end,1:2:end,1) = I(1:2:end,1:2:end,1) ; 
% blue color 
bayer_CFA_image(2:2:end,2:2:end,3) = I(2:2:end,2:2:end,3) ;
% green color 
bayer_CFA_image(1:2:end,2:2:end,2) = I(1:2:end,2:2:end,2) ; 
bayer_CFA_image(2:2:end,1:2:end,2) = I(2:2:end,1:2:end,2) ; 
% show image 
bayer_CFA_image = uint8(bayer_CFA_image); 
% 3*3 kernel
F_r_b = [1 2 1;2 4 2;1 2 1]/4 ; % for blue and red channel
F_g = [0 1 0;1 4 1;0 1 0]/4 ;   % for green channel 
% convolution ,we use zeros padding 
inter_image = zeros(size(I)) ; 
% red channel convolution 
inter_image(:,:,1) = conv2(bayer_CFA_image(:,:,1),F_r_b,'same') ; 
% green channel convolution 
inter_image(:,:,2) = conv2(bayer_CFA_image(:,:,2),F_g,'same') ; 
% blue channel 
inter_image(:,:,3) = conv2(bayer_CFA_image(:,:,3),F_r_b,'same') ; 
inter_image = uint8(inter_image) ;
bi_image   = inter_image ; 
end
