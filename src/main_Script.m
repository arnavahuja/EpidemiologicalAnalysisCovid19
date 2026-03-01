% MAIN_SCRIPT  Main driver script for SIR epidemiological analysis of COVID-19 in India.
%   Runs the full analysis pipeline: theoretical SIR simulation, then
%   parameter estimation and simulation for three phases of COVID-19
%   (pre-lockdown, lockdown, post-lockdown) and an overall analysis.
%   Saves all generated plots as PNG files in the ../results/ directory.
%
%   NOTE: This script should be run from the src/ directory so that
%   relative paths to data/ and results/ resolve correctly.
%
% ------------------------------------
% The variables used are -
% N -- Total population
% days -- Total number of days for which data is available
% x -- Start index of time period
% y -- End index of time period
% i -- Initial number of infectives
% beta -- Estimated value of transmission parameter
% gamma -- Estimated value of removal parameter
% flag -- Epidemic status according to Deterministic Theorem
% p -- Probability of a major outbreak
% f_spread -- Total cases according to simulation
% f -- Optimization status
% fminval -- Optimization function value
% f1 -- Figure for showing actual data + ODE
% f2 -- Figure for showing ODE over longer period of time
% f3 -- Figure for showing EM-plot over longer period of time
% ------------------------------------
% The functions used are -
% det_ode -- ODE plot
% isEpidemic -- Epidemic status according to Deterministic Theorem
% P_majOutBr -- Probability of a major outbreak
% EM_method -- EM Method simulation
% gillespie -- Gillespie Algorithm simulation
% get_data -- Setting up actual data
% view_data -- Plotting actual data
% parest -- Estimation of beta and gamma
% ------------------------------------

global days beta gamma
global x y i
global I N date
global f1 f2 f3

close all
beta=0.08;
gamma=0.03;
N=1000;
i=10;
x=1;
days=200;
y=days*4;
f_spread=det_ode;
flag=isEpidemic;
p=P_majOutBr;
disp("Theoretical");
disp("Total Population="+N+"    Initial Infectives="+i...
    +"    Basic Reproduction Number="+(beta/gamma));
disp("Start Date:"+x+"    End Date:"+y+...
    "    Transmission Rate(Beta)="+beta+"    Removal Rate(Gamma)="+gamma)
disp("Probability of major outbreak="+p+"    Total simulated number of cases="+f_spread);
if flag
    disp("Deterministic Status: Epidemic");
else
    disp("Deterministic Status: Disease-free equilibrium");
end
disp(" ");
EM_method;
gillespie;
saveas(f2,'../results/ODE_theory.png');
saveas(f3,'../results/EM_theory.png')
saveas(f1,'../results/Gillespie_theory.png')

get_data;

days=length(I);

close all
x=43;
y=64;
i=I(x);
view_data;
[f,fminval]=parest;
f_spread=det_ode;
flag=isEpidemic;
p=P_majOutBr;
disp("COVID-19 in India - Phase 1 Analysis - Pre-Lockdown")
disp("Total population="+N+"    Initial Infectives="+i...
    +"    Basic Reproduction Number="+(beta/gamma));
disp("Start Date:"+date(x)+"    End Date:"+date(y)+...
    "    Transmission Rate(Beta)="+beta+"    Removal Rate(Gamma)="+gamma);
disp("Optimization status="+f+"    Optimized error function="+fminval);
disp("Probability of major outbreak="+p+"    Total simulated number of cases="+f_spread);
if flag
    disp("Deterministic Status: Epidemic");
else
    disp("Deterministic Status: Disease-free equilibrium");
end
disp(" ");
gillespie;
EM_method;
saveas(f1,'../results/Estimation_1.png');
saveas(f2,'../results/ODE_1.png');
saveas(f3,'../results/EM_1.png');

close all
x=64;
y=131;
i=I(x);
view_data;
[f,fminval]=parest;
f_spread=det_ode;
flag=isEpidemic;
p=P_majOutBr;
disp("COVID-19 in India - Phase 2 Analysis - Lockdown")
disp("Total population="+N+"    Initial Infectives="+i...
    +"    Basic Reproduction Number="+(beta/gamma));
disp("Start Date:"+date(x)+"    End Date:"+date(y)+...
    "    Transmission Rate(Beta)="+beta+"    Removal Rate(Gamma)="+gamma);
disp("Optimization status="+f+"    Optimized error function="+fminval);
disp("Probability of major outbreak="+p+"    Total simulated number of cases="+f_spread);
if flag
    disp("Deterministic Status: Epidemic");
else
    disp("Deterministic Status: Disease-free equilibrium");
end
disp(" ");
%gillespie;
EM_method;
saveas(f1,'../results/Estimation_2.png');
saveas(f2,'../results/ODE_2.png');
saveas(f3,'../results/EM_2.png');

close all
x=131;
y=days;
i=I(x);
view_data;
[f,fminval]=parest;
f_spread=det_ode;
flag=isEpidemic;
p=P_majOutBr;
disp("COVID-19 in India - Phase 3 Analysis - Post-Lockdown")
disp("Total population="+N+"    Initial Infectives="+i...
    +"    Basic Reproduction Number="+(beta/gamma));
disp("Start Date:"+date(x)+"    End Date:"+date(y)+...
    "    Transmission Rate(Beta)="+beta+"    Removal Rate(Gamma)="+gamma);
disp("Optimization status="+f+"    Optimized error function="+fminval);
disp("Probability of major outbreak="+p+"    Total simulated number of cases="+f_spread);
if flag
    disp("Deterministic Status: Epidemic");
else
    disp("Deterministic Status: Disease-free equilibrium");
end
disp(" ");
%gillespie;
EM_method;
saveas(f1,'../results/Estimation_3.png');
saveas(f2,'../results/ODE_3.png');
saveas(f3,'../results/EM_3.png');

close all
x=43;
y=days;
i=I(x);
view_data;
[f,fminval]=parest;
f_spread=det_ode;
flag=isEpidemic;
p=P_majOutBr;
disp("COVID-19 in India - Overall Analysis");
disp("Total population="+N+"    Initial Infectives="+i...
    +"    Basic Reproduction Number="+(beta/gamma));
disp("Start Date:"+date(x)+"    End Date:"+date(y)+...
    "    Transmission Rate(Beta)="+beta+"    Removal Rate(Gamma)="+gamma);
disp("Optimization status="+f+"    Optimized error function="+fminval);
disp("Probability of major outbreak="+p+"    Total simulated number of cases="+f_spread);
if flag
    disp("Deterministic Status: Epidemic");
else
    disp("Deterministic Status: Disease-free equilibrium");
end
%gillespie;
EM_method;
saveas(f1,'../results/Estimation_overall.png');
saveas(f2,'../results/ODE_overall.png');
saveas(f3,'../results/EM_overall.png');
