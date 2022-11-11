# RMDLO Tracking ROS Workspace

ROS workspace for working with Constrained Deformable Coherent Point Drift and TrackDLO.

## Preliminaries

This workspace has been tested on ROS Noetic, which can be installed on an Ubuntu 20.04 OS with the below command. 

```bash
sudo apt install ros-noetic-desktop-full
```

More details on ROS installation are available [from the developers](http://wiki.ros.org/melodic/Installation/Ubuntu). Note: every terminal which uses ROS must source the ROS installation. A convenient way of automatically sourcing is to source the ROS installation in the `.bashrc` file:

```bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
```

Using the RMDLO Tracking ROS Workspace requires desktop [configuration of a GitHub SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

## Installation of RMDLO Tracking ROS Workspace for the first time

First, install any necessary dependencies detailed in the [original CDCPD installation instructions](https://github.com/RMDLO/cdcpd). Namely, install dependencies using the instructions to modify and run the `cdcpd/install_scripts/install_dep.sh` script and obtain a Gurobi license.

Perform the below commands in a terminal.
```bash
# First update the local rosdep database.
~$ rosdep update
# Clone the ABB robot catkin workspace.
~$ git clone git@github.com:RMDLO/rmdlo_tracking.git --recurse-submodules
# Change to the root of the ABB catkin workspace, use rosdep to install missing dependencies.
~$ cd rmdlo_tracking/src && rosdep install -r --from-paths cdcpd -y && cd ..
# Build the workspace (using catkin_tools).
~/rmdlo_tracking$ catkin build
```

Additionally, test CDCPD to ensure it built properly.
```bash
# Run all unit tests to ensure the workspace built properly.
~/rmdlo_tracking$ cd src/cdcpd && ./test_cdcpd.sh
```

## Running CDCPD on Bag Files

1. Download the UM ARM Lab [rosbag files](https://www.dropbox.com/sh/4nsnxu4a2cxm8ko/AAC0-FsuWTHUB8FWrvp5BqR0a?dl=0).
2. Perform the below commands in a terminal.
```bash
# Extract the bagged data to the CDCPD directory.
~$ cd ~/Downloads && unzip CDCPD_demo_data.zip -d ~/rmdlo_tracking/src/cdcpd/demos/ && rm ~/Downloads/CDCPD_demo_data.zip && cd ..
# Decompress the extracted rosbag files.
~$ cd ~/rmdlo_tracking/src/cdcpd/demos && ./unpack_rosbags.sh && rm -rf rosbags_compressed
```
3. Open a new terminal and launch
`roscore`
4. Open a new terminal and perform
```bash
# First source the workspace
~$ cd rmdlo_tracking && source devel/setup.bash
# Run the desired demo script, e.g.
~/rmdlo_tracking$ cd src/cdcpd/demos && ./launch_demo1.sh
```

After verifying this works, press `Ctrl+C` on the terminal session to end it, and then perform `killall -9 rosmaster` to stop the rosmaster from running in the background.

## Running TrackDLO on a Camera Image Stream

1. Download the UM ARM Lab [rosbag files](https://www.dropbox.com/sh/4nsnxu4a2cxm8ko/AAC0-FsuWTHUB8FWrvp5BqR0a?dl=0).
2. Perform the below commands one terminal.
```bash
# Source the RMDLO Tracking ROS Workspace
~$ cd rmdlo_tracking && source devel/setup.bash
# Lanch the camera, Rviz, and visualize the color image, mask, and tracking result (in 2D and 3D)
~/rmdlo_tracking$ roslaunch TrackDLO realsense_node.launch
```
2. Open a second terminal and perform the below commands.
```bash
# Source the RMDLO Tracking ROS Workspace
~$ cd rmdlo_tracking && source devel/setup.bash
# Start the tracking algorithm and publish tracking results.
~/rmdlo_tracking$ rosrun TrackDLO tracking_ros_dev.py
```

## Notes

See the [original CDCPD repository](https://github.com/RMDLO/cdcpd), the [RMDLO CDCPD Installation Instructions](https://docs.google.com/document/d/1_r08YOtW4ldJITyKw-FgV_Jnz4U9KekI3ymMCv4ImIs/edit?usp=sharing), and the [TrackDLO README.md](https://github.com/RMDLO/TrackDLO) for more information.
