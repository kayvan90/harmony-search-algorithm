clc;
close all;
clear;
format long g;
addpath ../tstFcn;
%% 

costFunc = @Rastrigin;
dim     = 50;
varMin   =-5.12;
varMax   = 5.12;

% costFunc = @rosen;              
% dim      = 50;
% varMin   =-30;
% varMax   = 30;

% costFunc = @Sphere;           
% dim      = 50;
% varMin   =-100;
% varMax   = 100;

res = harmony_search(costFunc, dim, varMin, varMax, 20, 5000);
plot(res);
res(end)