# Robotino ROS used with Docker

This packages provides the base packages used to communicate with a Festo robotino robot in a docker image.

## Install x11docker for GUI

Install x11docker (https://github.com/mviereck/x11docker):
```
curl -fsSL https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker | sudo bash -s -- --update
```
Install dependencies

```
sudo apt install xpra xserver-xephyr xinit xauth xclip x11-xserver-utils weston xwayland xdotool
```

Follow output of x11docker to install the gpu driver.

## Usage

Build the docker image:
```
docker build -t robotino .
```

Now you can run the docker image. The `docker_run.sh` script starts a special configuration to use the host network and GUI. To acces the host GUI x11docker (https://github.com/mviereck/x11docker) is used. The hostname and user in the docker container are the same like on the host PC.
```
./docker_run.sh
```
The workspace src folder is mounted in the container, so you can edit it in the container and save it afterwards. This works fine with the Visual Studio Code Remote Development Extension.

In the container execute the following to test the connection to the robot:
```
roscore
roslaunch robotino_node robotino_node.launch
roslaunch robotino_node robotino_node.launch hostname:=$ROBOTINO_IP
rosrun teleop_twist_keyboard teleop_twist_keyboard.py 
```
Now you can control the robot with your keyboard.