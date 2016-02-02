filename_eth0=sprintf('./%s/results/%s-%s-nic-eth0.csv',host,host,dom)
filename_eth1=sprintf('./%s/results/%s-%s-nic-eth1.csv',host,host,dom)
filename_eth2=sprintf('./%s/results/%s-%s-nic-eth2.csv',host,host,dom)
filename_eth3=sprintf('./%s/results/%s-%s-nic-eth3.csv',host,host,dom)
filename_eth4=sprintf('./%s/results/%s-%s-nic-eth4.csv',host,host,dom)
filename_eth5=sprintf('./%s/results/%s-%s-nic-eth5.csv',host,host,dom)
filename_bond0=sprintf('./%s/results/%s-%s-nic-bond0.csv',host,host,dom)
filename_br1=sprintf('./%s/results/%s-%s-nic-br1.csv',host,host,dom)
filename_br2=sprintf('./%s/results/%s-%s-nic-br2.csv',host,host,dom)

set format x "%H:%M"                                                             
set timefmt "%H:%M:%S"                                                           
set key font ",12"                                                                
set xtics font ",12"            
set ytics font ",12"
set title font ",14"

set terminal pngcairo size 1750,1750 enhanced font 'Verdana,8'
set output filename_plot 

set multiplot layout 6, 1

set title sprintf("%s - KB Received -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth0 using 1:5 with lines title 'eth0', \
     filename_eth1 using 1:5 with lines title 'eth1', \
     filename_eth2 using 1:5 with lines title 'eth2', \
     filename_eth3 using 1:5 with lines title 'eth3'
     
set title sprintf("%s - KB Sent -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth0 using 1:6 with lines title 'eth0', \
     filename_eth1 using 1:6 with lines title 'eth1', \
     filename_eth2 using 1:6 with lines title 'eth2', \
     filename_eth3 using 1:6 with lines title 'eth3'

set title sprintf("%s - KB Received -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth4 using 1:5 with lines title 'eth4', \
     filename_eth5 using 1:5 with lines title 'eth5'

set title sprintf("%s - KB Sent -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth4 using 1:6 with lines title 'eth4', \
     filename_eth5 using 1:6 with lines title 'eth5'

set title sprintf("%s - KB Received -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_bond0 using 1:5 with lines title 'bond0', \
     filename_br1 using 1:5 with lines title 'br1', \
     filename_br2 using 1:5 with lines title 'br2'
     
set title sprintf("%s - KB Sent -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_bond0 using 1:6 with lines title 'bond0', \
     filename_br1 using 1:6 with lines title 'br1', \
     filename_br2 using 1:6 with lines title 'br2'

set nomultiplot
