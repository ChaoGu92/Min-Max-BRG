function [Nonblockingness] = Nonblockingness(Pre,Post,M0,Te1,w,k)

% __________________________________________________________________________________________________________________________________
%|                                                                                                                                  |
%|                         This function is to verify the nonblockingness of specific Petri net systems.                            |
%|__________________________________________________________________________________________________________________________________|


tic;
MMBRG = MinimaxBRG(Pre,Post,M0,Te1);
Time_MMBRG = toc;

tic;
[Dnf] = Dnf0914(Pre,Post,Te1,MMBRG,w,k);
Time_Dnf = toc;
% fprintf('\n It takes %8.4f seconds to verify Dnf!\n', Time_Dnf);

TF_Dnf = isempty(Dnf);

if TF_Dnf ~= 1
%     Nonblokingness = [0];
      Nonblockingness = {MMBRG;Dnf;"Blocking"};
   fprintf('\n Dnf is not empty, i.e., the system contains non-final deadlock!\n The system is blocking!\n'); 
   return
else 
   fprintf('\n The system contains no non-final deadlock!\n\n Now we test unobstructiveness of its minimax-BRG!\n'); 
end

tic;
[ICO] = Mico(Pre, Post, Te1, MMBRG, w, k);
[UOS] = Unobs(MMBRG, ICO);
Time_Unobs = toc;

fprintf('\n It takes %8.4f seconds to compute MMBRG!\n', Time_MMBRG);
fprintf('\n It takes %8.4f seconds to verify Dnf!\n', Time_Dnf);
fprintf('\n It takes %8.4f seconds to verify unobstructiveness!\n', Time_Unobs);

if UOS == [0]
%        Nonblokingness = [1];
       Nonblockingness = {MMBRG;Dnf;"Non-Blocking";ICO;UOS};
       fprintf('\n Dnf is empty!\n The minimax-BRG is unobstructed!\n The system is non-blocking!\n');
       return
   else
%        Nonblokingness = [0];
       Nonblockingness = {MMBRG;Dnf;"Blocking";ICO;UOS};
       fprintf('\n Dnf is empty!\n minimax-BRG is obstructed!\n The system is blocking!\n');
       return
   
end



end