function [ fitness_hist, bestSolution ] = ...
    harmony_search(costfunction, dim, var_min, var_max, HMSize, numberOfIterations)
disp('HS optimization...');
%% initialize:
fitness_hist = zeros();
% HMSize = 10;
HMCR = .9;
PAR = .15;
HarmonyDimension = dim;
HM = zeros(HMSize, HarmonyDimension);
HMCost = zeros(1, HMSize);
FW=0.02*(var_max - var_min);
FW_damp=0.99;
% init harmony memory:
for i=1:HMSize
    HM(i, :)  = unifrnd(var_min, var_max, 1, dim);
    HMCost(i) = costfunction(HM(i,:));
end

%% Main loop:
for itr = 1: numberOfIterations
    new_harmony = unifrnd(var_min, var_max, HMSize, dim);
    new_HMCost = zeros(1, HMSize);
    for har = 1:HMSize
        for d = 1:dim
            if rand <= HMCR
                idx = randi([1 HMSize]);
                new_harmony(har, d ) = HM(idx, d);
                if rand <= PAR
                    new_harmony(har, d) = new_harmony(har, d) + randn() * FW;
                    % check limitations:
                    new_harmony(har, d) = max(min(new_harmony(har, d), var_max), var_min);
                end
            end
        end
        new_HMCost(har) = costfunction(new_harmony(har, :));
    end
    % selection and replacement:
    HM = [HM; new_harmony];
    HMCost = [HMCost new_HMCost];
    [HMCost, sort_idx] = sort(HMCost);
    HM = HM(sort_idx,:);
    HM = HM(1:HMSize, :);
    HMCost = HMCost(1:HMSize);
    fitness_hist(itr) = HMCost(1);
    disp(['Iteration ' num2str(itr) ': Best Cost = ' num2str(HMCost(1))]);

    
    % update damp factor:
    FW = FW * FW_damp;
end
[ ~, index ] = min( HMCost );
bestSolution = HM(index,:);
end

