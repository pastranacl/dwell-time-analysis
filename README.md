# Dwell-time-analysis
Dwell time analysis of single-molecule force-spectroscopy data.

The file dt_analysis.sh is a Bash script that analysis all the .dat files in a given folder, with each file containing (in columns) time, extension, time of translocation initiation (single_row) and end of translocation (single row). The script sends the data to the Octave function dwell_time.m to load, smooth and pre-analyze the data. Then, the function dwell_time.m executes the dwell time analysis. A file 'dwell_times.dat' is generated with a list of dwell times. The Bash script then generates histograms, saved as 'dwell_time_histogram.dat' and calls to gnuplot for data fitting.
