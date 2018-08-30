function imgn=clip(imagen)
%Crops a black letter with white background.
%Example:
% imagen=imread('metal.bmp');
% imgn=clip(imagen);
% subplot(2,1,1);imshow(imagen);title('INPUT IMAGE')
% subplot(2,1,2);imshow(~imgn);title('OUTPUT IMAGE')
if ~islogical(imagen)
    imagen=im2bw(imagen,0.99);
end
a=~imagen;
[f c]=find(a);
lmaxc=max(c);lminc=min(c);
lmaxf=max(f);lminf=min(f);
imgn=a(lminf:lmaxf,lminc:lmaxc);%Crops image

