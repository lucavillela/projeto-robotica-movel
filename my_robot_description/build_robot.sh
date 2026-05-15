#!/bin/bash

# Aborta o script se qualquer comando falhar
set -e

# 1. Source inicial (se existir)
if [ -f "install/setup.bash" ]; then
    source install/setup.bash
fi

# 2. Compila e só continua se o build der certo
echo "Compilando my_robot_description..."
colcon build --packages-select my_robot_description

# 3. Atualiza o ambiente
echo "Atualizando o ambiente..."
source install/setup.bash

# 4. Lança o display
echo "Abrindo RViz..."
ros2 launch my_robot_description display.launch.xml