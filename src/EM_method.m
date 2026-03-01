% EM_METHOD  Simulate the SIR model using the Euler-Maruyama (DTMC) method.
%   Implements the Euler-Maruyama stochastic numerical scheme for the SIR
%   stochastic differential equation model. Approximates the continuous-time
%   dynamics with discrete time-steps and Wiener process noise terms.
%
%   Uses globals: N, days, beta, gamma, i, x, y, f1, f3
% ------------------------------------
% The variables used are -
% dt -- Fractional time-step
% steps -- Total #time-steps
% S -- Simulated number of susceptibles
% I -- Simulated number of infectives
% R -- Simulated number of removed
% t -- Particular time instant
% eta -- Vector of two normally random numbers to simulate Wiener processes
% f -- Expected transmitted and removed populations at t
% gw -- Covariance values for time-step t (simplified vector form)
% s -- Simulated susceptible population for time-step t+1
% i1 -- Simulated infected population for time-step t+1
% ------------------------------------

function []=EM_method()

    global N days beta gamma
    global i x y
    global f1 f3

    dt=1;
    steps=(4*days-x)*dt;
    S=zeros(steps,1);
    I=zeros(steps,1);

    S(1)=N-i;                       %initial number of susceptibles
    I(1)=i;                         %initial number of infectives

    for t=1:steps-1
        eta=randn(2,1);
        f(1)=beta*S(t)*I(t)*dt/N;
        f(2)=gamma*I(t)*dt;
        gw=sqrt(f).*eta;
        s=S(t)-f(1)-gw(1);
        i1=I(t)+f(1)-f(2)+gw(1)-gw(2);
         if i1<=0                   %end of epidemic condition
             S(t+1:steps)=s+i1;
             I(t+1:steps)=0;
             break;
        elseif s<0                  %non-negativity of susceptible population condition
             S(t+1)=0;
             I(t+1)=i1-s;
         else
             S(t+1)=s;
             I(t+1)=i1;
         end
    end
    R=N-S-I;                        %S+I+R=N at any time-step

    if days~=200
        figure(f1);
        plot(x:y-1,I(1:y-x),'-m','DisplayName','EM Method');
    end

    figure(f3);
    plot(x:steps+x-1,S,'-b','DisplayName','EM S');
    hold on;
    plot(x:steps+x-1,I,'-r','DisplayName','EM I');
    plot(x:steps+x-1,R,'-g','DisplayName','EM R');

end
