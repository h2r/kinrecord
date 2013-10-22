
task :save_bag do
  # this saves the depth image and the raw rgb image. 
  # I got these paramters from here: http://mirror.umd.edu/roswiki/openni_launch%282f%29Tutorials%282f%29BagRecordingPlayback.html
  sh "rosbag record /camera/depth_registered/image_raw /camera/depth_registered/camera_info /camera/rgb/image_raw /camera/rgb/camera_info -O kinect.bag "
end
  

task :replay_bag_openni do
  sh "roslaunch openni_launch openni.launch load_driver:=false"
end

task :replay_bag_bag do
  sh "rosbag play --clock kinect.bag"
end


task :mencoder do
  sh "mencoder -ovc lavc -mf fps=3:type=jpg 'mf://test/*.jpg' -o time_lapse-test.avi "
end
