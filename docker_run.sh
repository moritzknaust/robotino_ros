x11docker --gpu --shell="bash" --interactive -- \
--network host \
--mount type=bind,source=$(pwd)/src,target=/ws/src \
--env HOME=/home.tmp/$USER \
--env ROS_MASTER_URI=http://$HOSTNAME:11311/ \
--env ROS_HOSTNAME=$HOSTNAME \
--env ROBOTINO_IP=172.26.1.2 \
-- robotino