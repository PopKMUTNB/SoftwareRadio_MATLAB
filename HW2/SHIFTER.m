function [Alpha] = SHIFTER(inputArg1,j)
% SHIFTER function
% This function will return value of inputArg1 after Arithmetics right
% right shift by j bits.

    Alpha = bitsra(inputArg1, j);

end

