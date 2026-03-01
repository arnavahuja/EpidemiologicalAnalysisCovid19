% ODEFUNC  Define the SIR model system of ordinary differential equations.
%   Computes the derivatives dS/dt and dI/dt for the SIR model, used as
%   the right-hand side function for ode45.
%
%   Inputs:
%       t     - Current time (unused, required by ode45 interface)
%       var   - State vector [S; I]
%       beta  - Transmission rate parameter
%       gamma - Removal rate parameter
%
%   Output:
%       dy - Derivative vector [dS/dt; dI/dt]
% ------------------------------------

function dy = odefunc(t,var,beta,gamma)

global N

dy=zeros(2,1);

dy(1)=-(beta/N)*var(1)*var(2);                %dS=-(beta/N)*s*i
dy(2)=(beta/N)*var(1)*var(2)-gamma*var(2);    %dI=(beta/N)*s*i-gamma*i

end
