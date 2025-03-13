%-------------------------------------------------------------------------
% University of Da Nang - College of Science and Technology
% Faculty                    : Electronic and Telecomunication Engineering
% Student's Name             : Thang Tran 
% Major                      : Computer Engineering
% Specialization subjects    : Image Processing
% Date                       : 03-02-2025
%-------------------------------------------------------------------------
% input  image        : rbg 8 bit image 
% source input image  : lossless image from kodim source
% output image        : interpolation image using method of Alleys proposal
% -------------------------------------------------------------------------
function [re_image] = alleys_algorithm(I) 
mosaic_image = zeros(size(I(:,:,1))) ;    % mosaic image 
mosaic_image(1:2:end,1:2:end) = I(1:2:end,1:2:end,1) ; % red channel
mosaic_image(2:2:end,2:2:end) = I(2:2:end,2:2:end,3) ; % blue channel
mosaic_image(1:2:end,2:2:end) = I(1:2:end,2:2:end,2) ; % green channel
mosaic_image(2:2:end,1:2:end) = I(2:2:end,1:2:end,2) ; % green channel 
mosaic_image = double(mosaic_image) ;
F_L = [
    -2  3  -6  3  -2;
     3  4   2  4   3;
    -6  2  48  2  -6;
     3  4   2  4   3;
    -2  3  -6  3  -2
] / 64 ; 
% luminance =conv2( mosaic image,FL) 
luminance = conv2(mosaic_image,F_L,"same") ;
% extracting mul_chronominance
mul_chro = mosaic_image - luminance ;
r_mul_img = zeros(size(mosaic_image)) ; 
bl_mul_img = zeros(size(mosaic_image)) ;
gr_mul_img  = zeros(size(mosaic_image)) ; 
% red color   
r_mul_img(1:2:end,1:2:end)   = mul_chro(1:2:end,1:2:end) ; 
% blue color 
bl_mul_img(2:2:end,2:2:end) = mul_chro(2:2:end,2:2:end) ; 
% green color 
gr_mul_img(1:2:end,2:2:end) = mul_chro(1:2:end,2:2:end); 
gr_mul_img(2:2:end,1:2:end) = mul_chro(2:2:end,1:2:end) ; 
% Interpolation 
% 3*3 kernel
F_r_b = [1 2 1;2 4 2;1 2 1]/4 ; % for blue and red channel
F_g = [0 1 0;1 4 1;0 1 0]/4 ;   % for green channel 
% convolution ,we use zeros padding 
% red channel convolution 
inter_r_img = conv2(r_mul_img,F_r_b,'same') ; 
% green channel convolution 
inter_g_img = conv2(gr_mul_img,F_g,'same') ; 
% blue channel 
inter_b_img = conv2(bl_mul_img,F_r_b,'same') ;
re_image(:,:,1) = inter_r_img(:,:) + luminance(:,:)  ; 
re_image(:,:,2) = inter_g_img(:,:) + luminance(:,:)  ;
re_image(:,:,3) = inter_b_img(:,:) + luminance(:,:)  ;
re_image = uint8(re_image) ;  % reconstruction image
end