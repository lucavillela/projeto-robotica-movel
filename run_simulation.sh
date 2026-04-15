#!/bin/bash

WORKSPACE_PATH=$(pwd)
XACRO_PATH="$WORKSPACE_PATH/src/my_robot_advanced/urdf/robot.urdf.xacro"

echo "Iniciando simulacao do Robo Diferencial..."

source /opt/ros/humble/setup.bash


echo "Publicando descricao do robo..."
ros2 run robot_state_publisher robot_state_publisher --ros-args -p robot_description:="$(xacro $XACRO_PATH)" &
PID_RSP=$!

echo "Abrindo o simulador (Gazebo Fortress)..."
ign gazebo empty.sdf &
PID_GZ=$!

sleep 5

echo "Colocando o robo no mundo virtual..."
ros2 run ros_gz_sim create -topic robot_description -name my_robot

echo "Ativando ponte de comando (/cmd_vel)..."
ros2 run ros_gz_bridge parameter_bridge /cmd_vel@geometry_msgs/msg/Twist]ignition.msgs.Twist &
PID_BRIDGE=$!

echo "Pronto! Use o teclado neste terminal para pilotar."
echo "   (Dica: Clique no Play no Gazebo se ele estiver pausado)"
ros2 run teleop_twist_keyboard teleop_twist_keyboard

kill $PID_RSP $PID_GZ $PID_BRIDGE
echo "Simulacao encerrada."