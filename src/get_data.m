% GET_DATA  Load and parse COVID-19 case data for India from CSV.
%   Reads date-India-confirmed-recovered-dead.csv and populates the global
%   variables S (susceptible), I (infected), R (removed), and date arrays.
%
%   Outputs (via globals):
%       S    - Susceptible population over time (N - confirmed)
%       I    - Active infections (confirmed - recovered - dead)
%       R    - Removed population (recovered + dead)
%       date - Date strings for each data row
%       N    - Total population of India (constant)
% ------------------------------------

function []=get_data()

    global S I R date
    global N

    T=readtable('../data/date-India-confirmed-recovered-dead.csv');
    N=136641750;

    date=string(T.Date);
    R=T.r+T.d;
    I=T.c-T.r-T.d;
    S=N-T.c;

end
