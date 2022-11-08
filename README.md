# CDCPD ROS Workspace

ROS workspace for working with Constrained Deformable Coherent Point Drift.

## Preliminaries

This workspace has been tested on ROS Noetic, which can be installed on an Ubuntu 20.04 OS with the below command. 

```bash
sudo apt install ros-noetic-desktop-full
```

More details on ROS installation are available [from the developers](http://wiki.ros.org/melodic/Installation/Ubuntu). Note: every terminal which uses ROS must source the ROS installation. A convenient way of auto-sourcing is to source the ROS installation in the `.bashrc` file:

```bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
```

Using the RMDLO CDCPD ROS Workspace requires desktop [configuration of a GitHub SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

## Installation of CDCPD ROS Workspace for the first time

First, install any necessary dependencies deteiled in the [original CDCPD installation instructions](https://github.com/RMDLO/cdcpd). Namely, install dependencies using the instructions to modify and run the `cdcpd/install_scripts/install_dep.sh` script and obtain a Gurobi license.

Perform the below commands in a terminal.
```bash
# First update the local rosdep database.
~$ rosdep update
# Clone the ABB robot catkin workspace.
~$ git clone git@github.com:RMDLO/cdcpd_ws.git --recurse-submodules
# Change to the root of the ABB catkin workspace, use rosdep to install missing dependencies.
~$ cd cdcpd_ws/src && rosdep install -r --from-paths cdcpd -y && cd ..
# Build the workspace (using catkin_tools).
~/cdcpd_ws$ catkin build
# Run all unit tests to ensure the workspace built properly.
~/cdcpd_ws$ cd src/cdcpd && ./test_cdcpd.sh
```

## Running CDCPD on Bag Files

1. Download the UM ARM Lab [rosbag files](https://www.dropbox.com/sh/4nsnxu4a2cxm8ko/AAC0-FsuWTHUB8FWrvp5BqR0a?dl=0).
2. Perform the below commands in a terminal.
```bash
# Extract the bagged data to the CDCPD directory.
~$ cd ~/Downloads && unzip CDCPD_demo_data.zip -d ~/cdcpd_ws/src/cdcpd/demos/ && rm ~/Downloads/CDCPD_demo_data.zip && cd ..
# Decompress the extracted rosbag files.
~$ cd ~/cdcpd_ws/src/cdcpd/demos && ./unpack_rosbags.sh && rm -rf rosbags_compressed
```
3. Open a new terminal and launch
`roscore`
4. Open a new terminal and perform
```bash
# First source the workspace
~$ cd cdcpd_ws && source devel/setup.bash
# Run the desired demo script, e.g.
~/cdcpd_ws$ cd src/cdcpd/demos && ./launch_demo1.sh
```

See the [original CDCPD repository](https://github.com/RMDLO/cdcpd) for more information.