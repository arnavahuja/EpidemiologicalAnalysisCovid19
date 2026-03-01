% OPTIM_FUN  Objective function for SIR parameter estimation.
%   Computes the mean squared error between observed S/I data and the
%   ODE45 solution for a given set of parameters [beta, gamma].
%
%   Input:
%       params - Vector [beta, gamma] of candidate parameter values
%
%   Output:
%       f - Normalized mean squared error between model and data
%
%   Uses globals: S, I, x, y
% ------------------------------------
% The functions used are-
% ode45 -- Non-stiff ODE solver
% odefunc -- Sets SIR Model
% ------------------------------------

function f = optim_fun(params)

    global S I x y

    m=y-x+1;

    %solve ODE
    try
        warning('off')
    [tsol,sol] = ode45(@(t,y) odefunc(t,y,params(1),params(2)),0:m-1, [S(x),I(x)]);
        warning('on')
    catch
        f=NaN;
        warning('on')
        return
    end

    %calculate optimization function
    f =  (norm((S(x:y) - sol(:,1))) + norm((I(x:y) - sol(:,2))))/m;

end
