# pairs_serial

Serial-line drivers connecting PAIRS UAVs to onboard hardware over a serial port. This branch provides the ROS 2 port of the visual-inertial IMU driver, reading the sensor over serial and publishing its IMU data into the PAIRS estimation stack.

## Contents

Composable node:
- `vio_imu::VioImu` (executable `PairsSerial_VioImu`) — reads a visual-inertial IMU over serial and publishes raw and synchronized IMU messages.
- `PairsSerial_SerialPort` — shared serial-port library backing the driver.

## Branches
- `ros1` — ROS 1 Noetic (catkin)
- `ros2` — ROS 2 Jazzy (ament_cmake)

## Install (ROS 2 Jazzy)
```bash
sudo apt install ros-jazzy-pairs-serial
```

## Usage

Launch the VIO IMU driver (set `UAV_NAME` and the device port as needed):

```bash
ros2 launch pairs_serial vio_imu.launch.py portname:=/dev/vio_imu baudrate:=460800
```

## License
BSD 3-Clause. Derived from the CTU-MRS `pairs_serial` package; the original
copyright is retained in [LICENSE](LICENSE).
