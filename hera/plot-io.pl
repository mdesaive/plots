#dom=26
filename_sda=sprintf('./%s/results/%s-%s-io-sda.csv',host,host,dom)
filename_sdb=sprintf('./%s/results/%s-%s-io-sdb.csv',host,host,dom)
filename_sdc=sprintf('./%s/results/%s-%s-io-sdc.csv',host,host,dom)
filename_sdd=sprintf('./%s/results/%s-%s-io-sdd.csv',host,host,dom)
filename_sde=sprintf('./%s/results/%s-%s-io-sde.csv',host,host,dom)
filename_cpu=sprintf('./%s/results/%s-%s-cpu.csv',host,host,dom)

set format x "%H:%M"                                                             
set timefmt "%H:%M:%S"                                                           
set key font ",8"                                                                
set xtics font ",8"            
set ytics font ",8"
set title font ",10"

set terminal pngcairo size 1750,1750 enhanced font 'Verdana,8'
set output filename_plot 

set multiplot layout 5, 1
set title sprintf("%s - Read Sectors per Second on %s.",host, dom)
set xdata time
# set yrange [0:5000]
set key right top
set lmargin 10
set timefmt "%H:%M:%S"
plot filename_sda using 1:3 with lines title 'sda rd\_sec/s', \
     filename_sdb using 1:3 with lines title 'sdb rd\_sec/s', \
     filename_sdc using 1:3 with lines title 'sdc rd\_sec/s', \
     filename_sdd using 1:3 with lines title 'sdd rd\_sec/s', \
     filename_sde using 1:3 with lines title 'sde rd\_sec/s'

set title sprintf("%s - Written Sectors per Second on %s.",host, dom)
set xdata time                                                                   
set yrange[0:1500000]
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_sda using 1:4 with lines title 'sda wr\_sec/s', \
     filename_sdb using 1:4 with lines title 'sdb wr\_sec/s', \
     filename_sdc using 1:4 with lines title 'sdc wr\_sec/s', \
     filename_sdd using 1:4 with lines title 'sdd wr\_sec/s', \
     filename_sde using 1:4 with lines title 'sde wr\_sec/s'

set title sprintf("%s - await [ms] on %s.",host, dom)
set xdata time                                                                   
set yrange [0:250]
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_sda using 1:7 with lines title 'sda await [ms]', \
     filename_sdb using 1:7 with lines title 'sdb await [ms]', \
     filename_sdc using 1:7 with lines title 'sdc await [ms]', \
     filename_sdd using 1:7 with lines title 'sdd await [ms]', \
     filename_sde using 1:7 with lines title 'sde await [ms]'

set title sprintf("%s - util [Percent] on %s.",host, dom)
set xdata time                                                                   
set yrange [0:50]
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_sda using 1:9 with lines title 'sda await [ms]', \
     filename_sdb using 1:9 with lines title 'sdb await [ms]', \
     filename_sdc using 1:9 with lines title 'sdc await [ms]', \
     filename_sdd using 1:9 with lines title 'sdd await [ms]', \
     filename_sde using 1:9 with lines title 'sde await [ms]'


set title sprintf("%s - iowait [Percent] on %s",host, dom)
set xdata time                                                                   
set yrange [0:15]
set key right top
set timefmt "%H:%M:%S" 
plot filename_cpu using 1:6 with lines title 'iowait [%]'
set nomultiplot
