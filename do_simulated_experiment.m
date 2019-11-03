
clear all; close all; clc;
disp('************************ simulated experiment ************************'); disp(' ');

%%

%size of samples in Subtype(1,2,3) data.
Data.S1.n1=60;
Data.S1.n2=60;
Data.S2.n1=90;
Data.S2.n2=90;
Data.S3.n1=120;
Data.S3.n2=120;
%size of features in Subtype(1,2,3) data.
Data.S1.nF1=130;
Data.S1.nF2=100;
Data.S2.nF1=130;
Data.S2.nF2=100;
Data.S3.nF1=130;
Data.S3.nF2=100;
%value of lambda 
Data.lambda=[0.013;0.0005];%3400
%size of data1(gene) and data2(miRNA)
Data.S1.Data1=zeros(Data.S1.n1,Data.S1.nF1);
Data.S1.Data2=zeros(Data.S1.n2,Data.S1.nF2);
Data.S2.Data1=zeros(Data.S2.n1,Data.S2.nF1);
Data.S2.Data2=zeros(Data.S2.n2,Data.S2.nF2);
Data.S3.Data1=zeros(Data.S3.n1,Data.S3.nF1);
Data.S3.Data2=zeros(Data.S3.n2,Data.S3.nF2);
Data.savePath='';
Data.savePath='result_file_noise';
Data.mark=1;
do_experiment_with_noise(Data);
