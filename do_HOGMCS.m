function [X_X1,X_X2,X_X3]=do_HOGMCS(indH1,valH1,indH2,valH2,indH3,valH3,D,lambda,nF1,nF2)
%Initialize the symmetric matrix X, y, Q1 and Q2
X=1/nF2*ones(nF1*nF2,3);
X1=1/nF2*ones(nF1*nF2,3);
Z=1/nF2*ones(nF1*nF2,3);
Z_temp=1/nF2*ones(nF1*nF2,3);
mu1=1;
mu2=0.3;
Q1=1/nF2*ones(nF1,3);
Q2=1/nF2*ones(nF1*nF2,3);
I=eye(nF1*nF2,nF1*nF2);
I=sparse(I);
%%
indH1=indH1+1;%VS move to Matlab,the index should be added 1;
indH2=indH2+1;
indH3=indH3+1;
indH(:,:,1)=indH1;
indH(:,:,2)=indH2;
indH(:,:,3)=indH3;
valH(:,1)=valH1;
valH(:,2)=valH2;
valH(:,3)=valH3;
%%
J=3;
t=1;
er1=1;
T=30;
X_temp1=X1;
while t<T && er1>0.005
    tic;
    % Subproblem1
    for j=1:J
        k=1;
        er=1;
        while k<100 && er>0.01
            X_temp=X1;
            for i=1:length(indH(:,1,j))
                X_temp(indH(i,1,j),j)=X_temp(indH(i,1,j),j)+valH(i,j)*X(indH(i,2,j),j)*X(indH(i,3,j),j);
                X_temp(indH(i,2,j),j)=X_temp(indH(i,2,j),j)+valH(i,j)*X(indH(i,1,j),j)*X(indH(i,3,j),j);
                X_temp(indH(i,3,j),j)=X_temp(indH(i,3,j),j)+valH(i,j)*X(indH(i,1,j),j)*X(indH(i,2,j),j);
            end
            X_temp(:,j)=(mu1*(D*D')+mu2*I)\(X_temp(:,j)-mu1*D*Q1(:,j)+mu2*Z(:,j)+mu2*Q2(:,j));
            X_temp(:,j)=X_temp(:,j)/sqrt(X_temp(:,j)'*X_temp(:,j));           
            er = norm(X(:,j)-X_temp(:,j), 'fro' );
            X(:,j)=X_temp(:,j);
            k=k+1;
        end
    end
    %Subproblem2
    for j=1:J
        Z_temp(:,j)=X(:,j)-Q2(:,j);        
    end
    if size(X,2)>2
        Z_temp=reshape(Z_temp,size(Z_temp,1),1,size(Z_temp,2));
        [Z,~]=flsa(Z_temp,lambda(2));
        Z_temp=reshape(Z_temp,size(Z_temp,1),size(Z_temp,3));
        Z=reshape(Z,size(Z,1),size(Z,3));
    else
        [Z,~]=flsa_2c(Z_temp,lambda(2));
    end
    
    if lambda(1)>100
        lam1=max(length(X(:,1))*0.5/1.1^t,lambda(1));
        for j=1:J
            Z(:,j)=soft(Z(:,j),fix(lam1));
        end
    else
        lam1=lambda(1);
        for j=1:J
            Z(:,j)=soft1(Z(:,j),fix(lam1));
        end
    end

    %Subproblem3
    Q1=Q1+D'*X;
    Q2=Q2+Z-X;
    
    for j=1:J
       er1 = er1+ norm(X(:,j)-X_temp1(:,j), 'fro' );
    end
    er1=er1/3;
    X_temp1=X;
    mu1=mu1*1.5;
    mu2=mu2*1.2;
    mu1=min(mu1,10000);
    mu2=min(mu2,10000);
    Ttime=toc;
    fprintf('iter=%d,Time=%f\n',t,Ttime);  
    t=t+1;
end
X_X1=reshape(X(:,1),nF1,nF2);
X_X2=reshape(X(:,2),nF1,nF2);
X_X3=reshape(X(:,3),nF1,nF2);           
end

function [zf,zhat]=flsa_2c(x,lam)
dx=(x(:,1)-x(:,2))/2;
dx=sign(dx).*min(abs(dx),lam);
zf(:,1)=x(:,1)-dx;zf(:,2)=x(:,2)+dx;
zhat=zf;
end

function z=soft(x,lambda)
n=size(x,1);
temp=sort(abs(x),'descend');
th=temp(lambda+1,:);
z=sign(x).*max(abs(x)-repmat(th,n,1),0);
nz=sqrt(sum(z.^2));
z=z./repmat(nz,n,1);
end

function z=soft1(x,lambda)
n=size(x,1);
z=sign(x).*max(abs(x)-lambda,0);
nz=sqrt(sum(z.^2));
z=z./repmat(nz,n,1);
end




