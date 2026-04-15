#!/bin/bash

# Autoria: Luca Torres Villela
# Descricao: Script para iniciar a visualizacao do robo no RViz com Joint State Publisher

echo "Iniciando a visualizacao do Robo Diferencial no RViz..."

# Carrega o ambiente do ROS 2
source /opt/ros/humble/setup.bash

# Define o caminho do arquivo baseando-se no diretorio atual
WORKSPACE_PATH=$(pwd)
XACRO_PATH="$WORKSPACE_PATH/src/my_robot_AV1/urdf/robot.urdf.xacro"

# Verifica se o arquivo realmente existe antes de tentar abrir
if [ ! -f "$XACRO_PATH" ]; then
    echo "Erro: O arquivo nao foi encontrado no caminho: $XACRO_PATH"
    echo "Por favor, execute este script estando na raiz do seu workspace (ex: cd ~/ros_ws)"
    exit 1
fi

echo "Arquivo encontrado. Abrindo interface..."

# Lanca o RViz com o pacote de tutorial
ros2 launch urdf_tutorial display.launch.py model:="$XACRO_PATH"