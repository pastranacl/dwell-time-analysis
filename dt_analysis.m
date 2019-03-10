#!/usr/bin/octave -qf

arg_list = argv();
filename = arg_list{1};
loaded_dta = dlmread(filename);

% The times of starting and ending of translocation
t0 = loaded_dta(2, 3);
tf = loaded_dta(2, 4);

main_data = loaded_dta(2:end, 1:2);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Filters the data for a given number of points using a moving average filter
POINTS = 60;
[frames, columns] = size(main_data);
smth_data = zeros(frames,  1);
temp_data = 0;

for( i = 1:1:frames-POINTS )
    temp_data = main_data(i:i+POINTS,2);
    smth_data (i, 1) = mean(temp_data);
end


%%%% TO VISUALIZE THE DATA UNCOMMENT THIS
%hold on
%plot(main_data(:,2), '1');
%plot(smth_data, '3');

main_data(:,2) = smth_data;
% Calculates the standard deviation of the filtered data in the first points
std_trace_filtered = std(main_data(1:60*5, 2))*1000;
disp(strcat('Standard deviation = ', num2str(std_trace_filtered), ' nm') );



% Anlyze the data
STEP = 76/1000; % Step for the analysis of dwell times
DT  = dwell_time( main_data, STEP, t0, tf );
dlmwrite('dwell_times.dat', DT, '-append');

