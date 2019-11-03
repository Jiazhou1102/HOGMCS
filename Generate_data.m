function [S1,S2,S3]=Generate_data(S1,S2,S3,param)
% Groud truth of matching matrices
S1.TX=zeros(S1.nF1,S1.nF2);
S2.TX=zeros(S2.nF1,S2.nF2);
S3.TX=zeros(S3.nF1,S3.nF2);
%create S1

S1.Data1(1:15,71:100)=55;
S1.Data1(16:30,71:100)=55;
S1.Data1(31:45,71:100)=55;
S1.Data1(46:60,71:100)=39;
S1.Data1(1:20,41:70)=41;
S1.Data1(21:40,41:70)=37;
S1.Data1(41:60,41:70)=43;
S1.Data1(1:30,1:40)=49;
S1.Data1(31:60,1:40)=51;
S1.Data1(1:10,101:130)=45;
S1.Data1(11:50,101:130)=53;
S1.Data1(51:60,101:130)=45;

S1.Data2(1:15,81:100)=55;
S1.Data2(16:30,81:100)=55;
S1.Data2(31:45,81:100)=55;
S1.Data2(46:60,81:100)=39;
S1.Data2(1:20,41:60)=41;
S1.Data2(21:40,41:60)=37;
S1.Data2(41:60,41:60)=43;
S1.Data2(1:30,1:40)=49;
S1.Data2(31:60,1:40)=51;
S1.Data2(1:10,61:80)=45;
S1.Data2(11:50,61:80)=53;
S1.Data2(51:60,61:80)=45;


%create S2
S2.Data1(1:22,71:100)=55;
S2.Data1(23:45,71:100)=55;
S2.Data1(46:68,71:100)=55;
S2.Data1(69:90,71:100)=39;
S2.Data1(1:30,41:70)=41;
S2.Data1(31:60,41:70)=37;
S2.Data1(61:90,41:70)=43;
S2.Data1(1:45,1:40)=49;
S2.Data1(46:90,1:40)=51;
S2.Data1(1:15,101:130)=45;
S2.Data1(16:75,101:130)=53;
S2.Data1(76:90,101:130)=45;

S2.Data2(1:22,61:80)=55;
S2.Data2(23:45,61:80)=55;
S2.Data2(46:68,61:80)=55;
S2.Data2(69:90,61:80)=39;
S2.Data2(1:30,81:100)=41;
S2.Data2(31:60,81:100)=37;
S2.Data2(61:90,81:100)=43;
S2.Data2(1:45,1:40)=49;
S2.Data2(46:90,1:40)=51;
S2.Data2(1:15,41:60)=45;
S2.Data2(16:75,41:60)=53;
S2.Data2(76:90,41:60)=45;
%create S3
S3.Data1(1:30,71:100)=55;
S3.Data1(31:60,71:100)=55;
S3.Data1(61:90,71:100)=55;
S3.Data1(91:120,71:100)=39;
S3.Data1(1:40,41:70)=41;
S3.Data1(41:80,41:70)=37;
S3.Data1(81:120,41:70)=43;
S3.Data1(1:60,1:40)=49;
S3.Data1(61:120,1:40)=51;
S3.Data1(1:20,101:130)=45;
S3.Data1(21:100,101:130)=53;
S3.Data1(101:120,101:130)=45;

S3.Data2(1:30,41:60)=55;
S3.Data2(31:60,41:60)=55;
S3.Data2(61:90,41:60)=55;
S3.Data2(91:120,41:60)=39;
S3.Data2(1:40,61:80)=41;
S3.Data2(41:80,61:80)=37;
S3.Data2(81:120,61:80)=43;
S3.Data2(1:60,1:40)=49;
S3.Data2(61:120,1:40)=51;
S3.Data2(1:20,81:100)=45;
S3.Data2(21:100,81:100)=53;
S3.Data2(101:120,81:100)=45;

%% initialize ground ture
S1.TX(1:40,1:40)=1;
S1.TX(41:70,41:60)=1;
S1.TX(71:100,81:100)=1;
S1.TX(101:130,61:80)=1;
S1.Share_X(1:40,1:40)=1;
S1.Share_X(41:130,41:100)=0;
S1.Individual_X(1:40,1:40)=0;
S1.Individual_X(41:70,41:60)=1;
S1.Individual_X(71:100,81:100)=1;
S1.Individual_X(101:130,61:80)=1;

S2.TX(1:40,1:40)=1;
S2.TX(41:70,81:100)=1;
S2.TX(71:100,61:80)=1;
S2.TX(101:130,41:60)=1;
S2.Share_X(1:40,1:40)=1;
S2.Share_X(41:130,41:100)=0;
S2.Individual_X(1:40,1:40)=0;
S2.Individual_X(41:70,81:100)=1;
S2.Individual_X(71:100,61:80)=1;
S2.Individual_X(101:130,41:60)=1;

S3.TX(1:40,1:40)=1;
S3.TX(41:70,61:80)=1;
S3.TX(71:100,41:60)=1;
S3.TX(101:130,81:100)=1;
S3.Share_X(1:40,1:40)=1;
S3.Share_X(41:130,41:100)=0;
S3.Individual_X(1:40,1:40)=0;
S3.Individual_X(41:70,61:80)=1;
S3.Individual_X(71:100,41:60)=1;
S3.Individual_X(101:130,81:100)=1;

%% Generate data with different noise
S1.Data1=S1.Data1+randn(S1.n1,S1.nF1)*2;
S2.Data1=S2.Data1+randn(S2.n1,S2.nF1)*2;
S3.Data1=S3.Data1+randn(S3.n1,S3.nF1)*2;
S1.Data2=S1.Data2+randn(S1.n2,S1.nF2)*2;
S2.Data2=S2.Data2+randn(S2.n2,S2.nF2)*2;
S3.Data2=S3.Data2+randn(S3.n2,S3.nF2)*2;

S1.Data2=S1.Data2+normrnd(0,param.sigma,S1.n2,S1.nF2);
S2.Data2=S2.Data2+normrnd(0,param.sigma,S2.n2,S2.nF2);
S3.Data2=S3.Data2+normrnd(0,param.sigma,S3.n2,S3.nF2);
S1.Data2=abs(S1.Data2);
S2.Data2=abs(S2.Data2);
S3.Data2=abs(S3.Data2);
