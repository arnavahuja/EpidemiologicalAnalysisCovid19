% DET_ODE  Solve the deterministic SIR model using ODE45 and plot results.
%   Computes the numerical solution of the SIR ordinary differential
%   equations using MATLAB's ode45 solver. Generates figures for the ODE
%   trajectories and overlays on the Gillespie/EM comparison plots.
%
%   Output:
%       f_spread - Total number of removed individuals at end of simulation
%
%   Uses globals: N, days, i, beta, gamma, x, y, f1, f2, f3
% ------------------------------------
% The functions used are-
% ode45 -- Non-stiff ODE solver
% odefunc -- Sets SIR Model
% ------------------------------------

function [f_spread]=det_ode()

    warning ('off');

    global N days i
    global beta gamma x y
    global f1 f2 f3

    %obtaining ODE solution
    [t,var] = ode45(@(t,var) odefunc(t,var,beta,gamma), [x 4*days-x], [N-i i]);

    warning ('on');

    f_spread=N-var(end,1)-var(end,2);

    if x==1 && y==800
        f1=figure;
        plot(t,var(:,1),'--b');
        hold on;
        plot(t,var(:,2),'--r');
        plot(t,N-var(:,1)-var(:,2),'--g');
        legend('ODE S','ODE I','ODE R');
        title('Gillespie Algo + ODE');
        xlabel('#Days');
        ylabel('Population');

        f2=figure;
        plot(t,var(:,1),'-b');
        hold on;
        plot(t,var(:,2),'-r');
        plot(t,N-var(:,1)-var(:,2),'-g');
        legend('Susceptible','Infected','Removed');
        title('ODE');
        xlabel('#Days');
        ylabel('Population');
    else
        id=find(t<=y);
        figure(f1);
        plot(t(id),var(id,2),'-r','DisplayName','ODE');
    end


    f3=figure;
    plot(t,var(:,1),'--b');
    hold on;
    plot(t,var(:,2),'--r');
    plot(t,N-var(:,1)-var(:,2),'--g');
    legend('ODE S','ODE I','ODE R');
    title('EM method + ODE');
    xlabel('#Days');
    ylabel('Population');

end
