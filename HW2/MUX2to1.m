function [sigma] = MUX2to1(signY,signZ,sel)
% MUX2to1 function
% This function will return the sign of Y[j] or Z[j].
% If select (sel) = 1 then it is Rotation Mode and return signZ
% else return signY.

    if (sel)
        sigma = signZ;
    else
        sigma = signY;
    end

end

