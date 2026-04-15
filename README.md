# Modelagem de Robo Diferencial em ROS 2 (URDF/XACRO)

**Autor:** Luca Torres Villela

Este projeto contem a modelagem visual, cinematica e fisica (inercia e colisao) de um robo de tracao diferencial, desenvolvido como avaliacao AV1. O projeto utiliza o framework ROS 2 (Humble) e a linguagem de macro XACRO para estruturacao do modelo 3D.

## Descricao do Projeto

O objetivo deste pacote e criar uma representacao computacional precisa de um chassi robotico com duas rodas motrizes e uma roda de apoio (caster wheel). O modelo esta configurado para ser visualizado e manipulado no RViz, utilizando o `joint_state_publisher_gui` para validar a rotacao das juntas continuas.

## Estrutura de Arquivos

A arquitetura do modelo foi modularizada utilizando XACRO para evitar repeticao de codigo e facilitar a manutencao:

* `robot.urdf.xacro`: Arquivo principal que atua como ponto de entrada e importa os demais modulos.
* `robot_core.xacro`: Contem a definicao geometrica do chassi (caixa de 0.6 x 0.4 x 0.2), das rodas motrizes (cilindros) e da roda boba (esfera), alem das propriedades de colisao e materiais visuais.
* `inertial_macros.xacro`: Biblioteca de macros matematicas para o calculo automatico da matriz de inercia de cilindros, esferas e caixas.

## Requisitos de Sistema

* Sistema Operacional: Ubuntu 22.04 (Suporte nativo a arquitetura ARM64 / Apple Silicon via UTM).
* ROS 2 Versao: Humble Hawksbill.
* Pacotes adicionais: `xacro`, `joint-state-publisher-gui`.

## Como Executar

1.  Abra o terminal e navegue ate a raiz do seu workspace:
    ```bash
    cd ~/ros_ws
    ```

2.  Certifique-se de carregar o ambiente do ROS 2:
    ```bash
    source /opt/ros/humble/setup.bash
    ```

3.  Inicie a visualizacao no RViz executando o comando de lancamento:
    ```bash
    ros2 launch urdf_tutorial display.launch.py model:=src/my_robot_description/urdf/robot.urdf.xacro
    ```
    *(Nota: Se preferir, utilize o script `run_rviz.sh` disponibilizado na raiz do workspace).*

4.  Uma janela do RViz sera aberta junto com um painel de controle. Utilize os controles deslizantes no painel "Joint State Publisher" para testar a rotacao das rodas independentes.