function [PSNR] = PSNRCAL(or_image,re_image)
mse = (double(or_image)-double(re_image)).^2 ;
mse = mean(mse(:))  ; 
PSNR = 10*log10(255.^2/mse)  ; 
end 