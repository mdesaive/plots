#dom=26
filename_memory=sprintf('./%s/results/%s-%s-memory.csv',host,host,dom)
filename_swap=sprintf('./%s/results/%s-%s-swap.csv',host,host,dom)
filename_swap_pagin=sprintf('./%s/results/%s-%s-swap-pagesio.csv',host,host,dom)

set format x "%H:%M"                                                             
set timefmt "%H:%M:%S"                                                           
set key font ",8"                                                                
set xtics font ",8"            
set ytics font ",8"
set title font ",10"

set terminal pngcairo size 1750,1750 enhanced font 'Verdana,8'
set output filename_plot 


set multiplot layout 5, 1


set title sprintf("%s - Memory Used on %s.",host, dom)
set xdata time
set yrange [0:200000000]
set format y "%12.0f"
set key right top
set lmargin 12
set timefmt "%H:%M:%S"
plot filename_memory using 1:3 with lines title 'kbmemused'


set title sprintf("%s - Free Memory on %s.",host, dom)
set xdata time
set yrange [0:5000000]
set format y "%12.0f"
set key right top
set lmargin 12
set timefmt "%H:%M:%S"
plot filename_memory using 1:2 with lines title 'kbmemfree'


set title sprintf("%s - Swap Used on %s.",host, dom)
set xdata time                                                                   
set yrange[0:50000000]
# 
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_swap using 1:3 with lines title 'kbswpused'


set title sprintf("%s - Swap Free on %s.",host, dom)
set xdata time                                                                   
set yrange[0:300000000]
# 
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_swap using 1:2 with lines title 'kbswpfree'


set title sprintf("%s - Swap Paging on %s.",host, dom)
set xdata time                                                                   
set yrange[0:10000]
# 
set key right top
set timefmt "%H:%M:%S"                                                           
plot filename_swap_pagin using 1:2 with lines title 'pgpgin/s KB paged in per Second', \
     filename_swap_pagin using 1:3 with lines title 'pgpgout/s KB paged out per Second'


set nomultiplot
