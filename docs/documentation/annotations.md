# Annotations

Annotations in reactor-uc allow you to configure reactor components, specify platform details, and set up network communication. They refine system behavior and enable runtime optimizations across different hardware platforms.

## Build Configuration

Configure how the reactor system is compiled and built.

- **`@build_type("<type>")`**
    
    Specifies the build type for compilation optimization and debug symbols. This is only supported for the `Native` platform. 
    
    **Valid values:**

    - `"DEBUG"`: Include debug symbols and disable optimizations
    - `"RELEASE"`: Enable optimizations and omit debug symbols

## Runtime Configuration

Configure global runtime behavior and system-wide options.

- **`@logging("<level>")`**
    
    Sets the logging verbosity level for the runtime system.
    
    **Valid values:**

    - `"ERROR"`: Only log errors
    - `"WARN"`: Log warnings and errors
    - `"INFO"`: Log general information
    - `"DEBUG"`: Log detailed debug information

- **`@timeout(<time_value>)`**
    
    Specifies a global timeout for reactor execution. The program will shutdown after this amount of logical time.
    
    **Parameters:**

    - `<time_value>`: Logical time duration in appropriate time unit (e.g., `MSEC(5000)`, `SEC(5)`)

- **`@fast(<boolean>)`**
    
    When enabled, the reactor system runs as fast as possible without waiting for physical time to advance. Useful for simulation and testing.
    
    **Parameters:**

    - `<boolean>`: `true` to enable fast execution, `false` for real-time execution

- **`@keepalive(<boolean>)`**
    
    Controls whether the reactor keeps running when there are no more scheduled events. When disabled, the reactor may shut down prematurely.
    
    **Parameters:**

    - `<boolean>`: `true` to keep the reactor alive, `false` to allow shutdown

- **`@clock_sync("<mode>")`**
    
    Globally enables or disables clock synchronization across a federation.
    
    **Valid values:**

    - `"on"`: Enable clock synchronization
    - `"off"`: Disable clock synchronization

## Reactor Components

Annotations for configuring individual reactor components and connections.

- **`@max_pending_event(<number>)`**
    
    Specifies the maximum number of elements that can be queued in a logical action's buffer. This controls memory usage and prevents unbounded growth of pending events.
    
    **Parameters:**
    - `<number>`: Maximum queue size (positive integer)

- **`@buffer(<number>)`**
    
    Specifies the maximum number of elements that can be in transit across a delayed connection. Useful for controlling backpressure in pipelines.
    
    **Parameters:**

    - `<number>`: Maximum buffer size (positive integer)

## Platform Configuration

Specify which platforms a federate should be compiled for in multi-platform federations.

- **`@platform("<platform_name>")`**
    
    Generic platform annotation for specifying target platforms.
    
    **Valid platforms:**
    - `"NATIVE"`: Native/Linux platform
    - `"PICO"`: Raspberry Pi Pico
    - `"ZEPHYR"`: Zephyr RTOS
    - `"RIOT"`: RIOT OS
    - `"FLEXPRET"`: FlexPRET
    - `"PATMOS"`: Patmos hardware
    - `"ESP-IDF"`: ESP-IDF framework
    - `"FREERTOS"`: FreeRTOS


??? warning
    These annotations may be deprecated.

- **`@platform_riot()`** - Compile for RIOT OS
- **`@platform_zephyr()`** - Compile for Zephyr RTOS
- **`@platform_patmos()`** - Compile for Patmos hardware
- **`@platform_native()`** - Compile for native/Linux platform

## Network Interfaces

Configure communication channels between federates using various network protocols.

- **`@interface_tcp(name="string", address="127.0.0.1:4200")`**
    
    TCP/IP network interface for federate communication.
    
    **Parameters:**
    - `name`: Interface identifier
    - `address`: Host and port (format: "host:port")

- **`@interface_uart(name="uart0", uart_device=0, baud_rate=115200, data_bits=8, parity="", stop_bits=1, async=false)`**
    
    UART/serial interface for embedded systems communication.
    
    **Parameters:**

    - `name`: Interface identifier
    - `uart_device`: Device number
    - `baud_rate`: Communication speed (e.g., 115200)
    - `data_bits`: Bits per character (typically 8)
    - `parity`: Parity mode (e.g., "", "even", "odd")
    - `stop_bits`: Stop bits (typically 1 or 2)
    - `async`: Whether to use asynchronous mode

- **`@interface_coap(name="coap0", address="10.0.0.1")`**
    
    CoAP (Constrained Application Protocol) interface for IoT communication.
    
    **Parameters:**

    - `name`: Interface identifier
    - `address`: Server address

- **`@interface_s4noc(core=0)`**
    
    S4NoC network-on-chip interface for tightly-coupled embedded systems.
    
    **Parameters:**

    - `core`: Core identifier

- **`@interface_custom(name="c1", args="blabla", include="my_network.h")`**
    
    Custom network interface for user-defined communication protocols.
    
    **Parameters:**

    - `name`: Interface identifier
    - `args`: Custom arguments passed to the interface
    - `include`: Header file containing the interface implementation

## Network Configuration

Configure how federates communicate across network interfaces.

- **`@link(left="tcp0", right="tcp1")`**
    
    Specifies which network interfaces to use for transmitting values between federates. The `left` and `right` refer to previously defined interface names.

- **`@maxwait(<time_value>)`**
    
    Maximum time a federate should wait for a value from a remote federate on a network channel. Helps prevent indefinite blocking in case of communication failures.
    
    **Parameters:**
    - `<time_value>`: Duration (e.g., `MSEC(100)`, `SEC(1)`)

- **`@joining_policy(policy="<policy>")`**
    
    Controls how federates synchronize when joining a federation.
    
    **Policies:**
    - `"TIMER_ALIGNED"`: Synchronize to a common time reference
    - `"IMMEDIATELY"`: Begin execution immediately

## Clock Synchronization

Configure distributed clock synchronization across federated systems.

- **`@clock_sync(grandmaster=true, period=3500000000, max_adj=512000, kp=0.5, ki=0.1)`**
    
    Enable and configure clock synchronization using a PTP-like protocol for precise time alignment across federates.
    
    **Parameters:**
    
    - `grandmaster`: Whether this federate is the time reference (true/false)
    - `period`: Synchronization period in nanoseconds
    - `max_adj`: Maximum clock adjustment per sync cycle (nanoseconds)
    - `kp`: Proportional controller gain
    - `ki`: Integral controller gain

## Legacy Annotations (Not Supported)

The following annotations are from earlier Lingua Franca versions and are not currently supported in reactor-uc:

- `@label()`
- `@sparse()`
- `@icon("value")`
- `@side("value")`
- `@layout(option="string", value="any")` — e.g., `@layout(option="port.side", value="WEST")`
- `@enclave(each=boolean)`
- `@property(name="<property_name>", tactic="<induction|bmc>", spec="<SMTL_spec>", CT=0, expect=true)` - SMTL is the safety fragment of Metric Temporal Logic (MTL)
- `@_c_body`
- `@_tpoLevel`
- `@_networkReactor`
