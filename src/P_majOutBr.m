% P_MAJOUTBR  Compute the probability of a major outbreak.
%   Uses the branching process approximation to estimate the probability
%   that the epidemic results in a major outbreak, given the basic
%   reproduction number R0 and initial number of infectives.
%
%   Output:
%       p - Probability of a major outbreak (0 if R0 <= 1)
%
%   Uses globals: beta, gamma, i
% ------------------------------------

function p = P_majOutBr()

    global beta gamma i
    p=0;
    R0=beta/gamma;

    if R0>1             %derivation of condition from branching process assumption
        p=1-(1/R0)^i;
    end

end
