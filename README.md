# Robô Diferencial ROS 2 - Adaptação Mac M4 (ARM64)

Este projeto apresenta a modelagem e simulação de um robô diferencial utilizando ROS 2 Humble. O diferencial técnico deste repositório é a adaptação completa para execução nativa em arquitetura **ARM64 (Apple Silicon M4)** através do UTM.

## Adaptações para Mac M4

Ao seguir tutoriais tradicionais de ROS 2, desenvolvedores com Mac M1/M2/M3/M4 enfrentam barreiras de arquitetura. Abaixo, as soluções implementadas:

### 1. Simulador: Gazebo Classic vs. Gazebo Fortress
O **Gazebo Classic** (utilizado em muitos tutoriais) não possui binários oficiais para ARM64 no Ubuntu 22.04. 
* **Solução:** Migramos para o **Gazebo Fortress (Ignition)**, que possui suporte nativo a ARM e melhor desempenho gráfico nos chips Apple Silicon.

### 2. Estrutura de Arquivos (XACRO)
Em vez de um arquivo URDF único e estático, o projeto utiliza **XACRO (XML Macros)** para:
* **Modularidade:** Divisão em `robot_core` (visuais), `gazebo_control` (plugins) e `inertial_macros` (física).
* **Física Real:** Implementação de tags de `<collision>` e matrizes de `<inertial>` calculadas para as dimensões exatas solicitadas (0.6x0.4x0.2).

### 3. Comunicação: ros_gz_bridge
No Gazebo Classic, o plugin de controle fala diretamente com o ROS. No Gazebo Fortress, é necessário uma "ponte" (`parameter_bridge`) para traduzir as mensagens de velocidade (`/cmd_vel`) entre o ecossistema ROS e o simulador.

## Estrutura do Projeto
- `robot.urdf.xacro`: Arquivo mestre que une os módulos.
- `robot_core.xacro`: Geometria do chassi (0.6x0.4x0.2) e rodas.
- `gazebo_control.xacro`: Configuração do plugin de tração diferencial para Ignition.
- `inertial_macros.xacro`: Fórmulas de inércia para esferas, cilindros e caixas.

## Como Executar
1. Certifique-se de estar no ambiente Ubuntu (UTM) com ROS 2 Humble instalado.
2. Clone este repositório no seu `ros_ws/src`.
3. Instale as dependências: `sudo apt install ros-humble-ros-gz ros-humble-teleop-twist-keyboard`.
4. Execute o script de automação: `./run_simulation.sh`.

**Nota:** Lembre-se de clicar no botão "Play" no canto inferior esquerdo do Gazebo ao iniciar, caso a física comece pausada.