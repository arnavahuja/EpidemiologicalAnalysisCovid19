% INIGUESS  Generate random initial guesses for beta and gamma.
%   Returns a two-element vector of uniform random values in (0,1) to
%   serve as the starting point for parameter optimization via fminsearch.
%
%   Output:
%       b0 - Vector [beta0, gamma0] of initial parameter guesses
% ------------------------------------

function b0 = iniGuess()

b0(1) = rand;           %random value of beta
b0(2) = rand;           %random value of gamma

end
