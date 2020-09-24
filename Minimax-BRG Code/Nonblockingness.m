function [Nonblokingness] = Nonblockingness(Pre,Post,M0,Te1,w,k)
%*************This function is to test if a given PNS is nonblocking******
%***************Nonblockingness = 1  -->  PNS is nonblocking**************
%***************Nonblockingness = 0  -->  PNS is blocking*****************
%*************************************************************************
%*************************************************************************
MMBRG = MinimaxBRG(Pre,Post,M0,Te1);

tic;
[Dnf] = Dnf0914(Pre,Post,Te1,MMBRG,w,k);
Time_Dnf = toc;
fprintf('\n It takes %8.4f seconds to verify Dnf!\n', Time_Dnf);

TF_Dnf = isempty(Dnf);

if TF_Dnf ~= 1
%     Nonblokingness = [0];
      Nonblokingness = {Dnf;"Blocking"};
   fprintf('\n The system contains non-final deadlock!\n\n The system is blocking!\n'); 
   return
else 
   fprintf('\n The system contains no non-final deadlock!\n\n Now we test unobstructiveness of its minimax-BRG!\n'); 
end

tic;
[ICO] = Mico(Pre, Post, Te1, MMBRG, w, k);
[UOS] = Unobs(MMBRG, ICO);
Time_Unobs = toc;
fprintf('\n It takes %8.4f seconds to verify unobstructiveness!\n', Time_Unobs);

if UOS == [0]
%        Nonblokingness = [1];
       Nonblokingness = {Dnf;"Non-Blocking";ICO;UOS};
       fprintf('\n The minimax-BRG is unobstructed!\n The system is non-blocking!\n');
       return
   else
%        Nonblokingness = [0];
       Nonblokingness = {Dnf;"Blocking";ICO;UOS};
       fprintf('\n The minimax-BRG is obstructed!\n The system is blocking!\n');
       return
   
end



end