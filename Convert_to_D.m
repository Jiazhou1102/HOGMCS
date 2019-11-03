function outputD = Convert_to_D(nF1,nF2, W )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% W is the similar matrix 
m1=nF1;
m2=nF2;

% W convert to D
D=sparse(m1*m2,m1);
for i=1:m1
   [a1,a2]=find(W(i,:));
   n=length(a1);
   for k=1:n
       if(i==a2(k))
          for j=1:m2
              D(i+(j-1)*m1,i)=n-1;
          end
       else
           for j=1:m2
              D(a2(k)+(j-1)*m1,i)=-1;
           end
       end
   end
end
outputD=D;

end

