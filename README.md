# pairs_serial

Serial-line drivers connecting PAIRS UAVs to onboard microcontrollers and peripherals. Each driver is a nodelet that talks to a device over a serial port (typically the BACA protocol or NMEA) and bridges it to ROS topics and services, covering sensors, actuators, and safety hardware on the airframe.

## Contents

Nodelets:
- `baca_protocol/BacaProtocol` — general BACA serial-protocol bridge to the flight microcontroller.
- `nmea_parser/NmeaParser` — parses NMEA sentences (e.g. RTK GNSS).
- `vio_imu/VioImu` — reads a visual-inertial IMU over serial.
- `ultrasound/Ultrasound`, `eagle/Eagle` — range/sensor drivers.
- `servo/Servo`, `led/Led`, `estop/Estop` — actuator, LED, and emergency-stop drivers.
- `gimbal/Gimbal` (SBGC-API) and `tarot_gimbal/TarotGimbal` — camera gimbal drivers.

A plain-tmux session under `tmux_scripts/` brings up roscore, RViz, rqt, and the gimbal driver for bench testing.

## Branches
- `ros1` — ROS 1 Noetic (catkin)
- `ros2` — ROS 2 Jazzy (ament_cmake)

## Install (ROS 1 Noetic)
```bash
sudo apt install ros-noetic-pairs-serial
```

## Usage

Launch the BACA protocol driver against the UAV's serial port:

```bash
roslaunch pairs_serial uav.launch portname:=/dev/ttyUSB0 baudrate:=115200
```

Other per-device launch files are provided (`gimbal.launch`, `vio_imu.launch`, `servo.launch`, `ultrasound.launch`, `estop.launch`, `rtk.launch`, `imu.launch`, and more). Or run the bench session:

```bash
cd tmux_scripts && ./start.sh
```

## License
BSD 3-Clause. Derived from the CTU-MRS `pairs_serial` package; the original
copyright is retained in [LICENSE](LICENSE).
