function [ DT ] = dwell_time( input_data, STEP, T0, Tf )
% Dwell time analysis, Cesar LP
%%%%%%%%%%%%%%%%%%%%%%%%% DWELL TIME ANALYSIS  %%%%%%%%%%%%%%%%%%%%%%%%%%



[rows cols] = size(input_data);
% Determine the frame at which the time T0 and Tf are reached
T0_frame = 0; 
Tf_frame = 0;

for( i = 1:1:rows ) 
    if( input_data(i, 1) >= T0 )
        T0_frame =i;
        break;
    end
end

for( i = 1:1:rows ) 
    if( input_data(i, 1) >= Tf )
        Tf_frame = i;
        break;
    end
end


DT = zeros(rows, 1);
counts_dt = 1;
z_T = input_data(T0_frame, 2);
last_event_time = input_data(T0_frame, 1);

for( i = T0_frame:1:Tf_frame )
    if( input_data(i, 2) < z_T - STEP ) 
        z_T =  input_data(i, 2);
        DT(counts_dt, 1) = input_data(i, 1) - last_event_time;
        last_event_time = input_data(i, 1);
        counts_dt = counts_dt + 1;
    end
end

% The first event is discarted because the starting time
% of the translocation is not well defined by the user.


DT = DT(2:1:counts_dt-1, 1);

% Calculates the velocity as v = Dz/Dt;
proces = (input_data(T0_frame, 2)  -  input_data(Tf_frame, 2) )* 1000;
v = proces/(Tf-T0);
disp(strcat('Average velocity = ', num2str(v),  ' nm/s'));
disp(strcat('Procesivity = ', num2str(proces),  ' nm'));
%disp( num2str(v) );
%disp(num2str(proces));
end

