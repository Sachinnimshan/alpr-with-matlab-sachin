function img_r=same_dim(imagen_g)
%Example:
% imagen_g=imread('a_reducir.bmp');
% img_r=same_dim(imagen_g);
% subplot(2,1,1);imshow(imagen_g);title('Image m x n')
% subplot(2,1,2);imshow(img_r);title('Image 42 x 24')

img_r=imresize(imagen_g,[42 24]);
