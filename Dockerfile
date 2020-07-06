FROM ros:melodic-ros-base

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update;\
    apt-get install -yy python-catkin-tools software-properties-common wget;

RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE;\
    add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u;\
    apt update;\
    apt -yy install librealsense2-udev-rules=2.28.0-0~realsense0.1512;\
    apt -yy install librealsense2=2.28.0-0~realsense0.1512;

RUN wget -qO - http://packages.openrobotino.org/keyFile | apt-key add -;\
    echo "deb http://packages2.openrobotino.org bionic main" > /etc/apt/sources.list.d/openrobotino.list;\
    apt update;\
    adduser --system --group --no-create-home robotino;\
    apt install -yy robotino-api2 robotino-dev

RUN apt install -yy ros-melodic-robot-state-publisher ros-melodic-teleop-twist-keyboard;

RUN mkdir -p /ws/src;
COPY ./src/ /ws/src
RUN rosdep init; rosdep update;
RUN rosdep install -y -r --from-path /ws/src
RUN source /opt/ros/$ROS_DISTRO/setup.bash;\
 cd /ws;\
 catkin init;\
 catkin build;

RUN echo 'source /ws/devel/setup.bash' >> /root/.bashrc 
RUN sed -i "s/exec \"\$@\"/exec stdbuf -o L \"\$@\"/g" /ros_entrypoint.sh