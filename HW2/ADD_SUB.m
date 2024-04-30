function [Sign,output] = ADD_SUB(inputArg1,inputArg2,sigma,yData)
% ADD_SUB function
% If selector is 1 then Subtract function wiil be selected.

    if (yData)
        if (sigma == -1)
            output = inputArg1 - inputArg2;
        end
        if (sigma == 1)
            output = inputArg1 + inputArg2;
        end
        if (output >= 0)
            Sign = -1;
        else
            Sign = 1;
        end
    else
        if (sigma == 1)
            output = inputArg1 - inputArg2;
        end
        if (sigma == -1)
            output = inputArg1 + inputArg2;
        end
        if (output >= 0)
            Sign = 1;
        else
            Sign = -1;
        end
    end
end

