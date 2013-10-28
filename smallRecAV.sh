#!/bin/bash
roslaunch audio_capture capture_to_file.launch &
audio_PID=$!

##Test clock
#echo $audio_PID
#count=0; 
#while [ $count -lt 1000000 ]; do   # Iterate 100 times 
#   if [ $count -eq 2 ]; then   # Skip the 2nd iteration 
#      continue; 
#   fi; 
#   do_stuff || break;          # Stop iterating if do_stuff fails 
#   count=$((count+1));         # Increment ‘count’ 
#done;



rosbag record tf camera/rgb/image_color camera/rgb/camera_info --limit=1800 -O kinect
kill -9 $audio_PID
cp -f ../.ros/output.mp3 .
rm -rf ../.ros/output.mp3
