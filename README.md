# Dwell-time analysis
Dwell time analysis of single-molecule force-spectroscopy data.

(c) 2020 Cesar Lopez Pastrana

This software was used in the work "Dynamics of DNA nicking and unwinding by the RepC–PcrA complex" Carolina Carrasco, Cesar L Pastrana, Clara Aicart-Ramos, Sanford H Leuba, Saleem A Khan, Fernando Moreno-Herrero [Nucleic Acids Research](https://academic.oup.com/nar/article/48/4/2013/5701458), 48(4), 2020:  2013–2025.


# Usage

The file 'dt_analysis.sh' is a Bash script that analysis all the .txt files in a given folder, with each file containing (in columns) time, the extension of a translocation experiment, time of translocation initiation (single_row) and end time of translocation (single row). The script sends the data to the Octave function 'dt_analysis.m' to load, filter and pre-analyze the data. Then, the function 'dwell_time.m' executes the dwell time analysis for a given file previoulsy processed by 'dt_analysis'. A file 'dwell_times.dat' is generated containing a list of all the dwell times. Finally, the main Bash scriptgenerates the dwell times histograms, saved as 'dwell_time_histogram.dat' and calls to Gnuplot for data reppresentation and fitting.


Traces and codes have to be located on the same path. Each trace file containing (in columns) time, the extension of a translocation experiment, time of translocation initiation (single_row) and end time of translocation (single row). To execute simply run
```
./dt_analysis.sh
```
This script `dt_analysis.sh` is main script and parses the data to the Octave function `dt_analysis.m`. This functions loads, filter and pre-analyze the data. There you can modify the filtering as well as the step for dwell time crossing. Finally, the function `dwell_time.m` executes the dwell time analysis for a given file previoulsy processed by `dt_analysis.m`. A file 'dwell_times.dat' is generated containing a list of all the dwell times. Finally, the main bash script generates the dwell times histograms, saved as 'dwell_time_histogram.dat' and calls to Gnuplot for data reppresentation and fitting.
