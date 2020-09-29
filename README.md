# Dwell-time analysis
Dwell time analysis of single-molecule force-spectroscopy data.

(c) 2020 Cesar Lopez Pastrana

This software was used in the work "Dynamics of DNA nicking and unwinding by the RepC–PcrA complex" Carolina Carrasco, Cesar L Pastrana, Clara Aicart-Ramos, Sanford H Leuba, Saleem A Khan, Fernando Moreno-Herrero [Nucleic Acids Research](https://academic.oup.com/nar/article/48/4/2013/5701458), 48(4), 2020:  2013–2025.


# Usage

This codes are Linux-based and are executed at terminal level.
Traces and codes have to be located on the same path. Traces files can have any name but they must be .txt in extension. Each trace file contains (in columns) time, the extension of a translocation experiment, time of translocation initiation (single row) and end time of translocation (single row). In other words, the output of `head my_trace_data.txt` should be similar to:

```
Time(s)   Extension(um)   t0(s)   tf(s)
0.017     1.52721    25.0    132.0
0.033     1.55897
0.005     1.60012
0.067     1.59097
```

To execute the analysis simply go to the terminal and run the main script
```
./dt_analysis.sh
```
This script parses the data to the Octave function `dt_analysis.m`. The bash script and Octave work synergistically to load, filter and pre-analyze the data. The MATLAB file can be edited to change the the filtering window as well as the extension step for dwell time considered for the analysis of dwell times. Finally, the function `dwell_time.m` executes the dwell time analysis for a given file previoulsy processed by `dt_analysis.m`. The software produces the file 'dwell_times.dat' which contains a list of all the dwell times. Finally, the main bash script generates dwell times histograms, saved as 'dwell_time_histogram.dat', and calls to Gnuplot for data reppresentation and fitting.
