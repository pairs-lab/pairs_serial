cmake_minimum_required(VERSION 3.5)
project(pairs_serial)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CATKIN_DEPENDENCIES
  roscpp
  cmake_modules
  nodelet
  sensor_msgs
  pairs_msgs
  pairs_modules_msgs
  std_msgs
  pairs_lib
  dynamic_reconfigure
  )

find_package(catkin REQUIRED COMPONENTS
  ${CATKIN_DEPENDENCIES}
  )

generate_dynamic_reconfigure_options(
  config/gimbal.cfg
  )

set(LIBRARIES
  PairsSerial_VioImu
  PairsSerial_NmeaParser
  PairsSerial_BacaProtocol
  PairsSerial_Servo
  PairsSerial_Led
  PairsSerial_Estop
  PairsSerial_Ultrasound
  PairsSerial_TarotGimbal
  PairsSerial_Gimbal
  PairsSerial_Eagle
  )

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES ${LIBRARIES}
  CATKIN_DEPENDS ${CATKIN_DEPENDENCIES}
  )

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${dynamic_reconfigure_PACKAGE_PATH}/cmake/cfgbuild.cmake
  )

# Eagle

add_library(PairsSerial_Eagle
  src/eagle.cpp
  src/serial_port.cpp
  )

# PairsSerial_VioImu

add_library(PairsSerial_VioImu
  src/vio_imu.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_VioImu
  ${catkin_LIBRARIES}
  )

# PairsSerial_NmeaParser

add_library(PairsSerial_NmeaParser
  src/nmea_parser.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_NmeaParser
  ${catkin_LIBRARIES}
  )

# PairsSerial_BacaProtocol

add_library(PairsSerial_BacaProtocol
  src/baca_protocol.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_BacaProtocol
  ${catkin_LIBRARIES}
  )

# PairsSerial_Servo

add_library(PairsSerial_Servo
  src/servo.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_Servo
  ${catkin_LIBRARIES}
  )

# PairsSerial_Led

add_library(PairsSerial_Led
  src/led.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_Led
  ${catkin_LIBRARIES}
  )

# PairsSerial_Estop

add_library(PairsSerial_Estop
  src/estop.cpp
  src/serial_port.cpp
  )

target_link_libraries(PairsSerial_Estop
  ${catkin_LIBRARIES}
  )

# PairsSerial_Ultrasound

add_library(PairsSerial_Ultrasound
  src/ultrasound.cpp
  src/serial_port.cpp)

target_link_libraries(PairsSerial_Ultrasound
  ${catkin_LIBRARIES}
  )

# PairsSerial_TarotGimbal

add_library(PairsSerial_TarotGimbal
  src/tarot_gimbal.cpp
  src/serial_port.cpp)

target_link_libraries(PairsSerial_TarotGimbal
  ${catkin_LIBRARIES}
  )

# PairsSerial_Gimbal

add_library(PairsSerial_Gimbal
  src/gimbal.cpp
  src/serial_port.cpp
  src/SBGC_lib/SBGC_cmd_helpers.cpp
  include/gimbal.hpp
  )

add_dependencies(PairsSerial_Gimbal
  ${${PROJECT_NAME}_EXPORTED_TARGETS}
  ${catkin_EXPORTED_TARGETS}
  ${PROJECT_NAME}_gencfg
  )

target_link_libraries(PairsSerial_Gimbal
  ${catkin_LIBRARIES}
  )

## --------------------------------------------------------------
## |                           Install                          |
## --------------------------------------------------------------

install(TARGETS ${LIBRARIES}
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
  )

install(DIRECTORY launch config rviz
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  )

install(DIRECTORY tmux_scripts
  USE_SOURCE_PERMISSIONS
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  )

install(DIRECTORY include
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

install(FILES nodelets.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  )
