filename_eth0=sprintf('./%s/results/%s-%s-nic-eth0.csv',host,host,dom)
filename_eth1=sprintf('./%s/results/%s-%s-nic-eth1.csv',host,host,dom)
filename_ovs_system=sprintf('./%s/results/%s-%s-nic-ovs-system.csv',host,host,dom)
filename_br0=sprintf('./%s/results/%s-%s-nic-br0.csv',host,host,dom)
filename_eth2=sprintf('./%s/results/%s-%s-nic-eth2.csv',host,host,dom)
filename_vlan1=sprintf('./%s/results/%s-%s-nic-vlan1.csv',host,host,dom)
filename_vlan110=sprintf('./%s/results/%s-%s-nic-vlan110.csv',host,host,dom)
filename_vlan120=sprintf('./%s/results/%s-%s-nic-vlan120.csv',host,host,dom)
filename_veth37iris=sprintf('./%s/results/%s-%s-nic-veth37iris.csv',host,host,dom)

set format x "%H:%M"                                                             
set timefmt "%H:%M:%S"                                                           
set key font ",12"                                                                
set xtics font ",12"            
set ytics font ",12"
set title font ",14"

set terminal pngcairo size 1750,1750 enhanced font 'Verdana,8'
set output filename_plot 

set multiplot layout 2, 1

set title sprintf("%s - KB Received -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth0 using 1:5 with lines title 'eth0', \
     filename_eth1 using 1:5 with lines title 'eth1', \
     filename_ovs_system using 1:5 with lines title 'ovs-system', \
     filename_br0 using 1:5 with lines title 'br0', \
     filename_eth2 using 1:5 with lines title 'eth2', \
     filename_vlan1 using 1:5 with lines title 'vlan1', \
     filename_vlan110 using 1:5 with lines title 'vlan110', \
     filename_vlan120 using 1:5 with lines title 'vlan120', \
     filename_veth37iris using 1:5 with lines title 'veth37iris'
     
set title sprintf("%s - KB Sent -  on %s.",host,dom)
set xdata time
set key right top
set lmargin 10
# set yrange [0:120000]
#set timefmt "%H:%M:%S"   5
plot filename_eth0 using 1:6 with lines title 'eth0', \
     filename_eth1 using 1:6 with lines title 'eth1', \
     filename_ovs_system using 1:6 with lines title 'ovs-system', \
     filename_br0 using 1:6 with lines title 'br0', \
     filename_eth2 using 1:6 with lines title 'eth2', \
     filename_vlan1 using 1:6 with lines title 'vlan1', \
     filename_vlan110 using 1:6 with lines title 'vlan110', \
     filename_vlan120 using 1:6 with lines title 'vlan120', \
     filename_veth37iris using 1:6 with lines title 'veth37iris'
 

set nomultiplot
