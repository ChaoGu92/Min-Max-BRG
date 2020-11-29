function [TestEfficiency] = TestEfficiency(Pre,Post,M0,Te1)
% __________________________________________________________________________________________________________________________________
%|                                                                                                                                  |
%|   This function is to test and compare the computational efficiency between RG and minimax-BRG on specific Petri net benchmarks.   |
%|__________________________________________________________________________________________________________________________________|


[~, t] = size(Pre);
T = [1:t];

tic;
MMBRG = MinimaxBRG(Pre,Post,M0,Te1);
Time_MMBRG = toc;
if Time_MMBRG < 36000
fprintf('\n It takes %8.4f seconds to compute minimax-BRG!\n', Time_MMBRG);
[num1, ~] = size(MMBRG);
fprintf('\n The minimax-BRG contains %5.0f markings!\n', num1);
else 
fprintf('\n MMBRG cannot be computed within 36,000 seconds!\n');
end

tic;
RG = BRG(Pre,Post,M0,T);
Time_RG = toc;
if Time_RG < 36000
fprintf('\n It takes %8.4f seconds to compute RG!\n', Time_RG);
[num2, ~] = size(RG);
fprintf('\n The RG contains %5.0f markings!\n', num2);
else 
fprintf('\n RG cannot be computed within 36,000 seconds!\n');
end

TestEfficiency = {MMBRG; RG};

end