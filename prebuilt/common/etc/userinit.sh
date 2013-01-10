# Get scaling frequencies from alternate location for ROMControl and put them in /data/local in the proper format

# Get available scaling frequencies
cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state | awk ' {print $1 } ' > /data/local/scaling_available_frequencies
sed -i ':a;N;$!ba;s/\n/ /g' /data/local/scaling_available_frequencies
