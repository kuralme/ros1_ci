pipeline {
    agent any

    stages {
        stage('Install Docker if Needed') {
            steps {
                sh '''
                if ! command -v docker &> /dev/null; then
                    echo "Docker is not installed. Installing now..."

                    # Remove both ROS1 & ROS2 apt sources
                    sudo rm -f /etc/apt/sources.list.d/ros-latest.list
                    sudo rm -f /etc/apt/sources.list.d/ros2-latest.list

                    sudo apt-get update
                    sudo apt-get install -y docker.io
                    sudo service docker start
                    echo "Docker is installed successfully!"
                fi
                '''
            }
        }

        stage('Build ROS2 Docker Image') {
            steps {
                sh '''
                cd ~/simulation_ws/src/ros1_ci
                sudo docker build -t tortoisebot-ros-test .
                '''
            }
        }

        stage('Run ROS2 Test in Container') {
            steps {
                sh '''
                sudo docker run --rm tortoisebot-ros-test:latest \
                    bash -c "source /simulation_ws/devel/setup.bash && rostest tortoisebot_gazebo test_tortoisebot_waypoints.launch"
                '''
            }
        }
    }
}
