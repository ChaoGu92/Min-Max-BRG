% empty_vector: This function computes an empty cell-vector of dimension n
%
%               ***********************************************************
%                               ## SINTAX ##
%
%               EMPTY =empty_vector(n)
%               Given an arbitrary number (n), this function returns a cell
%               EMPTY with [1 x n] dimensions. Each component is an empty
%               element.


function EMPTY =empty_vector(n)

count=0;

if n==0
	EMPTY={[]};
else
    while count<n
        EMPTY{1,count+1}=[];
        count=count+1;
    end
end

end

% Copyright Yin Tong