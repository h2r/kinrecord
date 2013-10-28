#!/bin/bash
rosrun image_view extract_images _sec_per_frame:=0.01 image:=camera/rgb/image_color &
imageViewPID=$!
rosbag play --clock kinect.bag
kill -9 $imageViewPID
