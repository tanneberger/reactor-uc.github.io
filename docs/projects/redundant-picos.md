# Redundant Picos

A fault-tolerant flight controller using federated reactor-uc execution across multiple Raspberry Pi Pico boards.

![Redundant Pico Setup](../assets/images/projects/redundant-pico.JPG)

## Overview

This project demonstrates **hardware redundancy** using reactor-uc's federated execution capabilities. Multiple Pico boards run as federated nodes, providing failover capability for safety-critical flight control applications.

## Architecture

The system uses a redundant node architecture with automatic failover:

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Node 0    │     │   Node 1    │     │   Node 2    │
│  (Primary)  │◄───►│  (Backup)   │◄───►│  (Backup)   │
│             │     │             │     │             │
│ FlightCtrl  │     │ FlightCtrl  │     │ FlightCtrl  │
│  Sensors    │     │  Sensors    │     │  Sensors    │
└─────────────┘     └─────────────┘     └─────────────┘
       │                  │                   │
       └──────────────────┴───────────────────┘
                          │
                    ┌─────▼─────┐
                    │  Actuators │
                    └───────────┘
```

## Key Components

| Reactor | Purpose |
|---------|---------|
| `FlightControllerReal` | Main flight control logic |
| `RedundantNode` | Redundancy and node coordination |
| `Failover` | Automatic failover detection and switching |
| `Forwarder` | Inter-node message routing |
| `SensorTest` | Sensor validation and testing |

## Building

Clone the repository and build for a specific federated node:

```bash
git clone https://github.com/tanneberger/fault-tolerance-testing.git
cd fault-tolerance-testing
```

Build and flash each node:

```bash
# Node 0 (Primary)
cmake -Bbuild -DLF_MAIN=FlightControllerReal -DFEDERATE=node_0
cmake --build build
sudo picotool load -x build/LF_MAIN.elf

# Node 1 (Backup)
cmake -Bbuild -DLF_MAIN=FlightControllerReal -DFEDERATE=node_1
cmake --build build
sudo picotool load -x build/LF_MAIN.elf
```

For sensor testing:

```bash
cmake -Bbuild -DLF_MAIN=SensorTest
cmake --build build
sudo picotool load -x build/LF_MAIN.elf
```

## Repository

[:octicons-mark-github-16: tanneberger/fault-tolerance-testing](https://github.com/tanneberger/fault-tolerance-testing)
