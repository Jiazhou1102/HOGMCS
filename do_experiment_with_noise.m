function  do_experiment_with_noise( Data )
%DO_EXPERIMENT_WITH_NOISE Summary of this function goes here
%   Detailed explanation goes here
%% Extract all variables from Data
strNames = fieldnames(Data);
for i = 1:length(strNames), eval([strNames{i} '= Data.' strNames{i} ';']); end
%%
sign=1;
mkdir (savePath);
file_path=[savePath,'\'];
param.file_path=file_path;
index=1;
maxiter=10;
AUC_Share=zeros(2,1);
AUC_Individual1=zeros(2,1);
AUC_Individual2=zeros(2,1);
AUC_Individual3=zeros(2,1);
x=zeros(1,2);
for i=0:0.2:4%i=3 %0:0.2:4 %0.1:0.05:0.4
    param.sigma=i;% noise variance sigma
    percentageW=0.2;% prior knowledge W
    sum_AUC_our=zeros(4,1);
    for iter=1:maxiter
        [S1,S2,S3]=Generate_data(S1,S2,S3,param);%create simulated data
        if sign
        W=produce_random_prior_W(S1,percentageW); %generate prior knowledge W
        D=Convert_to_D(S1.nF1,S1.nF2,W);
        sign=0;
        end
        [ indH1,valH1,indH2,valH2,indH3,valH3 ] = produce_H( S1,S2,S3 );%generate third-order tensor

        % Run methods
        [X_X1,X_X2,X_X3]=do_HOGMCS(indH1,valH1,indH2,valH2,indH3,valH3,D,[0.013;0.0005],S1.nF1,S1.nF2);% run HOGMSI method

        % AUC of X
        X1=X_X1;
        X2=X_X2;
        X3=X_X3;
        Share_Xtmp=(abs(X1+X2)/2+abs(X1+X3)/2+abs(X2+X3)/2)-(abs(X1-X2)/2+abs(X1-X3)/2+abs(X2-X3)/2);
        [U,D1,V]=svd(Share_Xtmp);
        u=soft(U(:,1),40);
        v=soft(V(:,1),40);
        Share_X=D1(1,1)*u*v';   
        [~, ~, ~, Temp_AUC_Share]=perfcurve(S1.Share_X(:),Share_X(:), '1');
        Individual_X1=X1;
        Individual_X2=X2;
        Individual_X3=X3;
        ind_u=find(abs(u)>0);
        ind_v=find(abs(v)>0);
        Individual_X1(ind_u,ind_v)=0.001;
        Individual_X2(ind_u,ind_v)=0.001;
        Individual_X3(ind_u,ind_v)=0.001;
        [~, ~, ~, Temp_AUC_Individual1]=perfcurve(S1.Individual_X(:),Individual_X1(:), '1');
        [~, ~, ~, Temp_AUC_Individual2]=perfcurve(S2.Individual_X(:),Individual_X2(:), '1');
        [~, ~, ~, Temp_AUC_Individual3]=perfcurve(S3.Individual_X(:),Individual_X3(:), '1');  
        sum_AUC_our(1)=sum_AUC_our(1)+Temp_AUC_Share;
        sum_AUC_our(2)=sum_AUC_our(2)+Temp_AUC_Individual1;
        sum_AUC_our(3)=sum_AUC_our(3)+Temp_AUC_Individual2;
        sum_AUC_our(4)=sum_AUC_our(4)+Temp_AUC_Individual3;
    end
    x(index)=i;
    AUC_Share(index)=sum_AUC_our(1)/maxiter;
    AUC_Individual1(index)=sum_AUC_our(2)/maxiter;
    AUC_Individual2(index)=sum_AUC_our(3)/maxiter; 
    AUC_Individual3(index)=sum_AUC_our(4)/maxiter; 
    index=index+1;
end
param.file_path=file_path;
param.P1='Sigma';
plot_AUC_curve( x,AUC_Share,AUC_Individual1,AUC_Individual2,AUC_Individual3,param);
end

function z=soft(x,lambda)
n=size(x,1);
temp=sort(abs(x),'descend');
th=temp(lambda+1,:);
z=sign(x).*max(abs(x)-repmat(th,n,1),0);
end
