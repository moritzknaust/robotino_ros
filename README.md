# Robotino ROS used with Docker

This packages provides the base packages used to communicate with a Festo robotino robot in a docker image.

## Usage

Build the docker image:
```
docker build -t robotino .
```

Now you can run the docker image. The `docker_run.sh` script starts a special configuration to use the host network and GUI. To acces the host GUI x11docker(https://github.com/mviereck/x11docker) is used. The hastname and user in the docker container is the same like on the host PC.
```
./docker_run.sh
```
The workspace src folder is mounted in the container, so edit it in the container and save it afterwards. This works fine with the Visual Studo Code Remote Development Extension.

In the container execute the following to test the connection:
```
roscore
roslaunch robotino_node robotino_node.launch
roslaunch robotino_node robotino_node.launch hostname:=$ROBOTINO_IP
rosrun teleop_twist_keyboard teleop_twist_keyboard.py 
```
Now you can teleoperate the robot with your keyboard.