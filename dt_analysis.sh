# Remove previous data 
rm "./dwell_times.dat"

for file_name in ./*.txt; do 
    echo "> Analysis file $file_name"
    #octave --persist ./dt_analysis.m "$file_name" #THIS LINE IF YOU WANT TO PLKOT THE DATA
    ./dt_analysis.m "$file_name"
done

echo " "

# Once the analysis is finished obtain the histogram
octave <<-EOF_Octave
    loaded_dta = dlmread('./dwell_times.dat');
    
    % Determine the optium number of bins considering bins of k seconds
    k=2;
    
    % n =  ceil((max(loaded_dta(:, 1)) -  min(loaded_dta(:, 1)) )/ k) ;
    % [counts, bin_center] = hist(loaded_dta(:, 1), n);
    
    bin_centers = (1:k:500);  % Bins between 0 and 500
    [counts, bin_center] = hist( loaded_dta(:, 1), bin_centers);
    [foo n_bins] = size(bin_centers);
     
    data_to_export = zeros( n_bins, 5);
    Z = trapz(bin_center, counts);
    data_to_export(:,1) = bin_center;
    data_to_export(:,2) = counts;
    data_to_export(:,3) = sqrt(counts);
    data_to_export(:,4) = counts/Z;
    data_to_export(:,5) = sqrt(counts)/Z;

    
    dlmwrite('dwell_time_histogram.dat', data_to_export, '\t');
    
    % Calculates the average
    max_int = trapz(bin_center, bin_center .* (data_to_export(:,4)  +  data_to_export(:,5) )' );
    min_int = trapz(bin_center, bin_center .* (data_to_export(:,4)  -  data_to_export(:,5) )' );
    ave = trapz(bin_center, bin_center .* data_to_export(:,4)' );
    
    D = 0.5*(max_int - min_int); % Calculates the dispersion
    s=0;
    I=0;

    for(i=2:1:n_bins)
        I = I + 0.5*k*( bin_centers(1,i)*data_to_export(i,4)' + bin_centers(1,i-1)*data_to_export(i-1,4)' );
        s = s + 0.5*k*sqrt( data_to_export(i-1,5)^2  +  data_to_export(i,5)^2 );
    end
    
    disp( strcat('<t> = ', num2str(ave),  ' +/- ', num2str(D), ' s' ));
    disp( strcat('<t> = ', num2str(I),  ' +/- ', num2str(s), ' s' ));
EOF_Octave


gnuplot --persist <<-EOF_gnuplot
    set style data lines
    set size square 1,1
    set key off
    set xlabel 'Dwell time (s)'
    set ylabel 'Probability density (s^{⁻1})'
    set logscale y
    set xrange [0:50]
    plot 'dwell_time_histogram.dat' using 1:4:5 with yerrorbars  linestyle 2 pt 7 ps 1 lc rgb "#DD0000"
EOF_gnuplot

