% ISEPIDEMIC  Determine epidemic status using the Deterministic Epidemic Theorem.
%   Checks whether the basic reproduction number R0 scaled by the
%   susceptible fraction exceeds 1, indicating an epidemic will occur.
%
%   Output:
%       flag - 1 if epidemic conditions are met, 0 otherwise
%
%   Uses globals: N, beta, gamma, i
% ------------------------------------

function flag = isEpidemic()

    global N beta gamma i

    flag=0;
    R0=beta/gamma;
    s=N-i;

    if s*R0/N>1    %condition obtained from theorem
        flag=1;
    end

end
