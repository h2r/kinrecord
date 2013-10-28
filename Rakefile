
task :launchOpenNI do
  # step 1 this launches the openNI dirvers 
  sh "rosparam set /use_sim_time false"
  sh "roslaunch openni_launch openni.launch"
end

task :recordSet do
  # step 2 this records the rosbag and the audio file
  sh "./smallRecAV.sh"
end

task :launchOpenNI_WD do
  # step 3 before this kill the old openNI drivers and then start these
  sh "rosparam set /use_sim_time true"
  sh "roslaunch openni_launch openni.launch load_driver:=false"
  sh "echo blah"
end

task :getImages do
  # step 4 gets images from the rosbag recorded previously
  sh "./getImages.sh"
end

task :convertAll do
  # step 5 combine the AV streams together after snipping the audio by 3s can correct the amount of snipping of the audio in the first line
  sh "ffmpeg -ss 00:00:03 -i output.mp3 -acodec copy outputNew.mp3"
  sh "ffmpeg -r 30 -i frame%04d.jpg -i outputNew.mp3 -r 30 -strict experimental out.mp4"
end

#task :echoCrap do
#sh "echo blah"
#end
