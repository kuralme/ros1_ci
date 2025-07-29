#!/bin/bash

# Build docker image
sudo docker build -t tortoisebot-ros-test .

# Start the container and run the gazebo node
sudo docker run --rm \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    tortoisebot-ros-test:latest \
    bash -c "source /simulation_ws/devel/setup.bash && roslaunch tortoisebot_gazebo tortoisebot_playground.launch"