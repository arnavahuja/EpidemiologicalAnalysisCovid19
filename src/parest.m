% PAREST  Estimate SIR model parameters beta and gamma from data.
%   Uses MATLAB's fminsearch to minimize the mean squared error between
%   the ODE solution and observed data, starting from a random initial guess.
%
%   Outputs:
%       f       - Optimization exit flag (1=converged, 0=max iter, -1=error)
%       fminval - Minimum value of the error function achieved
%
%   Sets globals: beta, gamma (updated to optimized values)
% ------------------------------------
% The functions used are-
% iniGuess -- Function for initial guess of parameters
% fminsearch -- An optimizer provided by MATLAB for minimizing the value of optim_fun
% optim_fun -- The function to optimize
% ------------------------------------

function [f,fminval] = parest()

    global beta gamma

    b0 = iniGuess();

    maxiters = 1000;

    options = optimset('Display','off','MaxIter',maxiters,...
                'MaxFunEvals',maxiters,'TolFun',1e-6,'TolX',1e-6,'PlotFcn',@optimplotfval);

    [b, fminval,f] = fminsearch(@optim_fun, b0, options);
    warning('on')

    beta=b(1);
    gamma=b(2);

end
