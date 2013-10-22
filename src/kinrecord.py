#!/usr/bin/env python
import argparse
import rospy
import cv
import cv2
from PIL import Image
from sensor_msgs.msg import Image
from std_msgs.msg import String

import sensor_msgs
from cv_bridge import CvBridge, CvBridgeError
import time
class Kinrecord(object):
    def __init__(self):
        self.bridge = CvBridge()
        
    def callback(self, image_msg):
        rospy_time = image_msg.header.stamp
        python_time = time.ctime(rospy_time.to_sec())
        #print python_time

        cv_image = self.bridge.imgmsg_to_cv(image_msg, "bgr8")
        cv.SaveImage("test.jpg", cv_image)
        #cv.ShowImage("Image window", cv_image)
        #cv.WaitKey(3)
  

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("--bag-filename", dest="bag_fname")

    kinrecord = Kinrecord()
    rospy.init_node('kinrecord')
    rospy.Subscriber("/camera/rgb/image_raw", sensor_msgs.msg.Image, 
                     kinrecord.callback)
    rospy.spin()

if __name__ == "__main__":
    main()
