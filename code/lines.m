function [fl re]=lines(aa)
%Divide text in lines.
aa=clip(aa);
r=size(aa,1);
for s=1:r
    if sum(aa(s,:))==0
        nm=aa(1:s-1,1:end);%First line matrix
        rm=aa(s:end,1:end);%Remain line matrix
        fl=~clip(~nm);
        re=~clip(~rm);
        %*-*-*Uncomment lines below to see the result*-*-*-*-
        %         subplot(2,1,1);imshow(fl);
        %         subplot(2,1,2);imshow(re);
        break
    else
        fl=~aa;%Only one line.
        re=[];
    end
end