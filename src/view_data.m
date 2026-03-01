% VIEW_DATA  Plot observed COVID-19 infection data.
%   Creates a figure displaying the actual infected population over the
%   selected time window [x, y]. Sets up the figure handle f1 used by
%   other functions to overlay model results.
%
%   Uses globals: x, y, I, f1
% ------------------------------------

function []= view_data()

    global x y I
    global f1

    f1=figure;
    plot(x:y,I(x:y),'-k');
    hold on;
    legend('Actual');
    title('Actual data + Models');
    xlabel('#Days');
    ylabel('Infected population');

end
