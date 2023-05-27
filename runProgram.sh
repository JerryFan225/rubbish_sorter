#!/bin/bash

#This creates the popup window which displays which items are recyclable and which are not.
zenity --info --text "Rubbish Index:\nPlastic Bottle - <span foreground='green'>Recyclable</span>\nMixed Paper - <span foreground='green'>Recyclable</span>\nPlastic Bag - <span foreground='red'>Non-Recyclable</span>\nGlass - <span foreground='green'>Recyclable</span>\nBattery - <span foreground='orange'>Recyclable ONLY in Special Bin</span>\nMetal Tin - <span foreground='green'>Recyclable</span>" --width=300 --height=500 &

#Loads the trained model into detectnet and creates the video feed through which the detection is shown
#Note that /dev/video0 here will only work for v4l2(usb) cameras and for any csi cameras, that part of the command will have to be changed to "csi://0"
detectnet --model=/home/nvidia/rubbish_sorter/models/ssd-mobilenet.onnx --labels=/home/nvidia/rubbish_sorter/models/labels.txt --input-blob=input_0 --output-cvg=scores --output-bbox=boxes /dev/video0
