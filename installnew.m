

cd ann_mwrapper
ann_compile_mex
cd ..

%  mex mexSource/mexComputeFeature_angle_distance_sample1.cpp -output mex/mexComputeFeature_angle_distance_sample1
%  mex mexSource/mexComputeFeature_angle_distance_sample2.cpp -output mex/mexComputeFeature_angle_distance_sample2
  mex mexSource/mexComputeFeature_angle_distance_sample3.cpp -output mex/mexComputeFeature_angle_distance_sample3

 


