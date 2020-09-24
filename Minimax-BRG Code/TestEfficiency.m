function [TestEfficiency] = TestEfficiency(Pre,Post,M0,Te1)
%*************This function is to test if a given PNS is nonblocking******
%***************Nonblockingness = 1  -->  PNS is nonblocking**************
%***************Nonblockingness = 0  -->  PNS is blocking*****************
%*************************************************************************
%*************************************************************************
[~, t] = size(Pre);
T = [1:t];

tic;
MMBRG = MinimaxBRG(Pre,Post,M0,Te1);
Time_MMBRG = toc;
if Time_MMBRG < 36000
fprintf('\n It takes %8.4f seconds to compute MMBRG!\n', Time_MMBRG);
else 
fprintf('\n MMBRG cannot be computed within 36,000 seconds!\n');
end

tic;
ExpandedBRG = Expanded_BRG(Pre,Post,M0,Te1);
Time_ExpandedBRG = toc;
if Time_ExpandedBRG < 36000
fprintf('\n It takes %8.4f seconds to compute Expanded BRG!\n', Time_ExpandedBRG);
else 
fprintf('\n Expanded BRG cannot be computed within 36,000 seconds!\n');
end

tic;
RG = BRG(Pre,Post,M0,T);
Time_RG = toc;
if Time_RG < 36000
fprintf('\n It takes %8.4f seconds to compute RG!\n', Time_RG);
else 
fprintf('\n RG cannot be computed within 36,000 seconds!\n');
end

TestEfficiency = {MMBRG; ExpandedBRG; RG};

end