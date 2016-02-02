filename_cpu_all=sprintf('./%s/results/%s-%s-cpu-all.csv',host, host,dom)
filename_cpu_0=sprintf('./%s/results/%s-%s-cpu-0.csv',host, host,dom)
filename_cpu_1=sprintf('./%s/results/%s-%s-cpu-1.csv',host, host,dom)
# filename_cpu_2=sprintf('./%s/results/%s-%s-cpu-2.csv',host, host,dom)
# filename_cpu_3=sprintf('./%s/results/%s-%s-cpu-3.csv',host, host,dom)
# filename_cpu_4=sprintf('./%s/results/%s-%s-cpu-4.csv',host, host,dom)
# filename_cpu_5=sprintf('./%s/results/%s-%s-cpu-5.csv',host, host,dom)
# filename_cpu_6=sprintf('./%s/results/%s-%s-cpu-6.csv',host, host,dom)
# filename_cpu_7=sprintf('./%s/results/%s-%s-cpu-7.csv',host, host,dom)
# filename_cpu_8=sprintf('./%s/results/%s-%s-cpu-8.csv',host, host,dom)
# filename_cpu_9=sprintf('./%s/results/%s-%s-cpu-9.csv',host, host,dom)
# filename_cpu_10=sprintf('./%s/results/%s-%s-cpu-10.csv',host, host,dom)
# filename_cpu_11=sprintf('./%s/results/%s-%s-cpu-11.csv',host, host,dom)
# filename_cpu_12=sprintf('./%s/results/%s-%s-cpu-12.csv',host, host,dom)
# filename_cpu_13=sprintf('./%s/results/%s-%s-cpu-13.csv',host, host,dom)
# filename_cpu_14=sprintf('./%s/results/%s-%s-cpu-14.csv',host, host,dom)
# filename_cpu_15=sprintf('./%s/results/%s-%s-cpu-15.csv',host, host,dom)
# filename_cpu_16=sprintf('./%s/results/%s-%s-cpu-16.csv',host, host,dom)
# filename_cpu_17=sprintf('./%s/results/%s-%s-cpu-17.csv',host, host,dom)
# filename_cpu_18=sprintf('./%s/results/%s-%s-cpu-18.csv',host, host,dom)
# filename_cpu_19=sprintf('./%s/results/%s-%s-cpu-19.csv',host, host,dom)
# filename_cpu_20=sprintf('./%s/results/%s-%s-cpu-20.csv',host, host,dom)
# filename_cpu_21=sprintf('./%s/results/%s-%s-cpu-21.csv',host, host,dom)
# filename_cpu_22=sprintf('./%s/results/%s-%s-cpu-22.csv',host, host,dom)
# filename_cpu_23=sprintf('./%s/results/%s-%s-cpu-23.csv',host, host,dom)

set format x "%H:%M"                                                             
set timefmt "%H:%M:%S"                                                           
set key font ",5"                                                                
set xtics font ",8"            
set ytics font ",8"
set title font ",10"

set terminal pngcairo size 1750,1750 enhanced font 'Verdana,8'
set output filename_plot 

set multiplot layout 6, 1

set title sprintf("%s - Percent user -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:3 with lines title 'all', \
     filename_cpu_0 using 1:3 with lines title '1', \
     filename_cpu_1 using 1:3 with lines title '2'
 
set title sprintf("%s - Percent nice -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:4 with lines title 'all', \
     filename_cpu_0 using 1:4 with lines title '1', \
     filename_cpu_1 using 1:4 with lines title '2'


set title sprintf("%s - Percent system -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:5 with lines title 'all', \
     filename_cpu_0 using 1:5 with lines title '1', \
     filename_cpu_1 using 1:5 with lines title '2'



set title sprintf("%s - Percent iowait -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:6 with lines title 'all', \
     filename_cpu_0 using 1:6 with lines title '1', \
     filename_cpu_1 using 1:6 with lines title '2'

set title sprintf("%s - Percent steal -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:7 with lines title '%all', \
     filename_cpu_0 using 1:7 with lines title '1', \
     filename_cpu_1 using 1:7 with lines title '2'

set title sprintf("%s - Percent idle -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:100]
#set timefmt "%H:%M:%S"
plot filename_cpu_all using 1:8 with lines title '%all', \
     filename_cpu_0 using 1:8 with lines title '1', \
     filename_cpu_1 using 1:8 with lines title '2'


set nomultiplot
