A=imread('templates\A.bmp');B=imread('templates\B.bmp');
C=imread('templates\C.bmp');D=imread('templates\D.bmp');
E=imread('templates\E.bmp');F=imread('templates\F.bmp');
G=imread('templates\G.bmp');H=imread('templates\H.bmp');
I=imread('templates\I.bmp');J=imread('templates\J.bmp');
K=imread('templates\K.bmp');L=imread('templates\L.bmp');
M=imread('templates\M.bmp');N=imread('templates\N.bmp');
O=imread('templates\O.bmp');P=imread('templates\P.bmp');
Q=imread('templates\Q.bmp');R=imread('templates\R.bmp');
S=imread('templates\S.bmp');T=imread('templates\T.bmp');
U=imread('templates\U.bmp');V=imread('templates\V.bmp');
W=imread('templates\W.bmp');X=imread('templates\X.bmp');
Y=imread('templates\Y.bmp');Z=imread('templates\Z.bmp');
%Number
one=imread('templates\1.bmp');  two=imread('templates\2.bmp');
three=imread('templates\3.bmp');four=imread('templates\4.bmp');
five=imread('templates\5.bmp'); six=imread('templates\6.bmp');
seven=imread('templates\7.bmp');eight=imread('templates\8.bmp');
nine=imread('templates\9.bmp'); zero=imread('templates\0.bmp');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
number=[one two three four five...
    six seven eight nine zero];
character=[letter number];
templates=mat2cell(character,42,[24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24]);
save ('templates','templates')
msgbox('Template creation successful','Template creation successful');