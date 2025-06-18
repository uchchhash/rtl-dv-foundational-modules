
# Foundational RTL Design and Verification Projects

This repository showcases three fundamental RTL design projects—**Traffic Light Controller**, **4-bit Binary Counter**, and **Universal Shift Register**—implemented in **Verilog** and verified using **SystemVerilog-based testbenches**. These projects were developed as part of RTL design and verification training to reinforce concepts in digital logic, FSMs, and verification methodologies.

---

## 📁 Project Structure

```bash
.
├── binary_counter/
│   ├── rtl/
│   ├── tb/
│   ├── doc/
│   └── README_binary_counter.md
│
├── universal_shift_register/
│   ├── rtl/
│   ├── tb/
│   ├── doc/
│   └── README_shift_register.md
│
├── traffic_light_controller/
│   ├── rtl/
│   ├── tb/
│   ├── doc/
│   └── README_traffic_light.md
│
└── README.md   ← (This file)
```

---

## 🚦 Traffic Light Controller

- **Design:** FSM-based control for a traffic light with IDLE → RED → YELLOW → GREEN cycle.
- **RTL Language:** Verilog
- **Verification:** Basic Verilog testbench with waveform observation
- **Highlights:**
  - PSR + NSL implementation
  - State-based output logic
  - Functional test with `start` signal

📄 [View Project README](traffic_light_controller/README.md)

---

## 🔢 4-bit Binary Counter

- **Design:** 4-bit counter with load, up-count, down-count, and carry-out functionality.
- **Verification:** SystemVerilog testbench with constrained-random testing
- **Highlights:**
  - Scoreboarding and event-based sync
  - Full functional and code coverage (100%)
  - Multiple test scenarios and coverage bins

📄 [View Project README](binary_counter/README.md)

---

## 🔁 Universal Shift Register

- **Design:** 4-bit universal shift register with parallel load, left/right shift, and hold.
- **Verification:** Class-based SystemVerilog testbench with full coverage integration
- **Highlights:**
  - Randomized and directed stimulus
  - Semaphore, mailbox, covergroups
  - Modular agent-based architecture

📄 [View Project README](universal_shift_register/README.md)

---

## 🧠 Learning Outcomes

- RTL Design using FSM, counters, and shift registers
- Writing synthesizable Verilog code
- Creating reusable SystemVerilog testbenches
- Achieving high-quality functional and code coverage
- Debugging and coverage analysis using waveform tools

---

## 🛠 Tools Used

- **Languages:** Verilog, SystemVerilog
- **Simulators:** ModelSim, VCS, or Xcelium
- **Coverage:** Code + Functional Coverage
- **Version Control:** Git

---

## 👨‍💻 Author

- Uchchhash Sarkar

---

## 📜 License

These projects are intended for educational and training purposes.
