FROM osrf/ros:noetic-desktop-full-focal
SHELL [ "/bin/bash" , "-c" ]

# Install Noetic/Gazebo 11 and other dependencies
RUN apt-get update && apt-get install -y \
  gazebo11 \
  ros-noetic-gazebo-ros-pkgs \
  ros-noetic-gazebo-ros-control \
  ros-noetic-ros-control \
  ros-noetic-ros-controllers \
  ros-noetic-joint-state-publisher \
  ros-noetic-joint-state-controller \
  ros-noetic-robot-state-publisher \
  ros-noetic-robot-localization \
  ros-noetic-xacro \
  ros-noetic-tf2-ros \
  ros-noetic-tf2-tools \
  && rm -rf /var/lib/apt/lists/*

# Prepare the workspace
RUN mkdir -p /simulation_ws/src
COPY ./tortoisebot /simulation_ws/src/tortoisebot

# Source ros and build workspace
RUN source /opt/ros/noetic/setup.bash && cd /simulation_ws && catkin_make \
  && echo "source /simulation_ws/devel/setup.bash" >> ~/.bashrc

WORKDIR /simulation_ws