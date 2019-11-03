function [ indH1,valH1,indH2,valH2,indH3,valH3 ] = produce_H( S1,S2,S3 )
%% insert matlab toolbox
addpath('ann_mwrapper');
addpath('mex');
%% Generate data
%data
for i=1:3
    if i==1
        Data1=S1.Data1;
        Data2=S1.Data2;
    else if i==2
            Data1=S2.Data1;
            Data2=S2.Data2;
        else
            Data1=S3.Data1;
            Data2=S3.Data2;
        end
    end
    P1=Data1;
    P2=Data2;
    [n1,nF1]=size(Data1);
    [n2,nF2]=size(Data2);

    %% 3rd Order Tensor
    flag=1;
    [t1,t2,nT1,nT2] = Generate_tuples(P1,P2,nF1,nF2,flag);%1:Oliver,2:ours,3:ochs

    %generate features
    t1=int32(t1);
    t2=int32(t2);
    if i==1
        [feat11,feat22] = mexComputeFeature_angle_distance_sample1(P1,P2,int32(t1),int32(t2),'simple');
    else if i==2
          [feat11,feat22] = mexComputeFeature_angle_distance_sample2(P1,P2,int32(t1),int32(t2),'simple');
        else
            [feat11,feat22] = mexComputeFeature_angle_distance_sample3(P1,P2,int32(t1),int32(t2),'simple');
        end
    end
    feat1=feat11(1:3,:);%angle information
    feat2=feat22(1:3,:);%angle information
    %number of nearest neighbors used for each triangle (results can be bad if too low)
    nNN=1000;

    %find the nearest neighbors
    clear inds
    [inds, dists] = annquery(feat2, feat1, nNN, 'eps', 10);

    %build the tensor
    tmp=repmat(1:nT1,nNN,1);
    inds=int32(inds);
    indH = t1(:,tmp(:))' + t2(:,inds(:))'*nF1;
    valH = exp(-dists(:)/mean(dists(:)));
    if i==1
        indH1=indH;
        valH1=valH;
    else if i==2
            indH2=indH;
            valH2=valH;
        else
            indH3=indH;
            valH3=valH;
        end
    end

end

end

