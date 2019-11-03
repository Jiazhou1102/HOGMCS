function W=produce_random_prior_W(S1,percentage)
%Data1 prior
% Generate prior matrix
W=zeros(S1.nF1);
N=floor(percentage*40);
temp=1:40;
R=randperm(length(temp));
modul=temp(R(1:N));
W(modul,modul)=1;

N=floor(percentage*30);
temp=41:70;
R=randperm(length(temp));
modul=temp(R(1:N));
W(modul,modul)=1;

N=floor(percentage*30);
temp=71:100;
R=randperm(length(temp));
modul=temp(R(1:N));
W(modul,modul)=1;

N=floor(percentage*30);
temp=101:130;
R=randperm(length(temp));
modul=temp(R(1:N));
W(modul,modul)=1;