#!/bin/bash


rosparam set /use_sim_time false
roslaunch openni_launch openni.launch &
openNI_PID =$!


#Test clock
#echo $audio_PID
count=0; 
while [ $count -lt 500000 ]; do   # Iterate 100 times 
#   if [ $count -eq 2 ]; then   # Skip the 2nd iteration 
#      continue; 
#   fi; 
#   do_stuff || break;          # Stop iterating if do_stuff fails 
   count=$((count+1));         # Increment ‘count’ 
done;

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



rosbag record tf camera/rgb/image_color camera/rgb/camera_info --limit=1200 -O kinect
kill -9 $audio_PID
cp -f ../.ros/output.mp3 .
kill -9 $openNI_PID
rosparam set /use_sim_time true
roslaunch openni_launch openni.launch load_driver:=false &
openNINewPID=$!
count=0; 
while [ $count -lt 500000 ]; do   # Iterate 100 times 
#   if [ $count -eq 2 ]; then   # Skip the 2nd iteration 
#      continue; 
#   fi; 
#   do_stuff || break;          # Stop iterating if do_stuff fails 
   count=$((count+1));         # Increment ‘count’ 
done;
rosrun image_view extract_images _sec_per_frame:=0.01 image:=camera/rgb/image_color &
imageViewPID=$!
rosbag play --clock kinect.bag
ffmpeg -ss 00:00:03.1 -i output.mp3 -acodec copy outputNew.mp3
ffmpeg -r 30 -i frame%04d.jpg -i outputNew.mp3 -r 30 -strict experimental out.mp4
kill -9 $openNINewPID
kill -9 $imageViewPID
