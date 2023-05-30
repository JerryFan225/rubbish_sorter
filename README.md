#Rubbish Sorter:

The rubbish sorter project is a program that I created on a Jetson Nano to identify rubbish which is shown to the program. There is a popup window next to the camera feed which allows you to reference the piece of rubbish that has been identified and check its recyclability (I think that's a word...)

Obviously the model is not perfect, and there are a few points where it could improve and the project will, hopefully, be updated in the future to fix these problems in order to create a more robust program.

**Note** A demo video can be found at this link: https://youtu.be/GYu8002dW4o

#Problems/Issues with the Program:

Currently, as far as I know, there are a few issues with program.

1. The types of trash that can be identified is still limited so not everything will be able to be identified.
2. The program is often confused between plastic and glass and may often misidentify a plastic bag as glass.
3. Plastic bottles refuse to be identified and only seem to be either a metal tin from the top, or glass from the bottom.
4. The program creates windows to display the recyclind table and also the camera feed which are opened by the terminal. This does not seem to work in headless mode, or at least I haven't been able to find a fix, and therefore is currently limited to headed mode operation only.

#Installation Instructions:

This project was built on the Jetson Nano 2GB Developer Kit and should, hopefully, funcion perfectly fine on all Nvidia Jetson devices.

To download the files of the program, simply open up the Linux terminal and execute the following command:

git clone https://github.com/JerryFan225/rubbish_sorter YOUR-DIRECTORY-NAME

This should download all of the files from GitHub to either the folder that you are in (in the Linux terminal) if the directory name is not specified in the command above, or to whatever directory is specified above.

This files downloaded should include the scripts for training the model in order to further develop it and make it more robust, the current models and picture, the README file, and also the runProgram.sh file so that the program is easy to use in the Linux Terminal.

#Using the Program:

When using the program, you can either navigate the folder and double click the runProgram.sh file to execute it, or you can alternatively go into the terminal and simply type out the path of the directory to the file:
e.g. /home/nvidia/rubbish_sorter/runProgram.sh

This should firstly activate the Recycling Table as a popup which you can reposition as you wish. It should then (this may take a few minutes) launch the camera feed for the program and allow you to identify the rubbish and reference it to the table.

**Note**The runProgram.sh file is programmed to use a usb camera and you will have to modify the code if you are using a csi camera. The instructions should be in the file.

#Retraining/FurtherTraining the Program:

To retrain or further train the program, you would first install PyTorch onto your system. You would then use the command:

camera-capture YOUR_CAMERA_NAME("/dev/video0" for usb webcams)

This should open up a camera capture window in which you can then set the Dataset Type to Detection, and you can set the DataSet Path, or the folder where your pictures and annotations will be stored, and the labels file, which you should create as a text (.txt) file with each of your different classes (or types of rubbish in this case) on a different line. Alternatively, you can simply edit the existing labels file in the pictures folder (the pictures folder would be your dataset path). When you have positioned the item in the frame of the video feed, you can freeze the frame, drag your mouse over the object, keeping the edges as close to the object as you can (you can adjust the edges by dragging them), and save the image. To have a good set of data to traing the model, you would ideally have hundreds, if not thousands of images of differeent items of the same class either in different pictures or in the same one with multiple boxes.

You would navigate the main rubbish_sorter folder and then train the model by executing the command:

python3 train_ssd.py --dataset-type=voc --data=pictures --model-dir=models --batch-size=2 --workers=1 --epochs=30

**Note:**
--data	= the location of the dataset
--model-dir = directory to output the trained model checkpoints
--batch-size - try increasing depending on available memory
--epochs - up to 100 is desirable, but will increase training time
--workers = number of data loader threads (0 -disable multithreading)

Once the model is done training, you would then export it to onnx with the command:

python3 onnx_export.py --model-dir=models

This will save a file called "ssd-mobilenet.onnx" in the models folder.

The runProgram script is already scripted to use the ssd-mobilenet.onnx model and therefore you can simply replace the old model with the new one to use it for your object detection.

You can also go into the runProgram.sh script to change the Recycling Table if anything has changed or if you are adding anything new to the program.


#Planned Further Development:

Expansion of model to cover a wider range of rubbish for wider range of object detection.

Expansion of current dataset for more accurate object detection.

Allowing the project to run on headless mode (e.g. over SSH)

~~Changing the labels/names of the classes to reflect their recyclability~~ (Finished)

~~Changing the colours of the bounding boxes to reflect the objects' recyclability~~ (Finished)
