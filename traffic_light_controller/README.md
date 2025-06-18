
# Traffic Light Controller – RTL Design and Basic Testbench Verification

This project implements a **Finite State Machine (FSM)-based Traffic Light Controller** using Verilog. It follows a well-defined sequence of state transitions—IDLE → RED → YELLOW → GREEN → IDLE—and is verified through a basic Verilog testbench with stimulus generation and waveform observation.

---

## 🔧 Features

- FSM-based RTL design in Verilog
- Three-light output (Red, Yellow, Green) based on state logic
- Clock and reset-driven state transitions
- Functional simulation with waveform-based validation

---

## 📁 Directory Structure

```bash
traffic_light_controller/
│
├── rtl/
│   └── traffic_light.v
│
├── tb/
│   └── traffic_light_top_tb.v
│
├── doc/
│   ├── fsm_diagram.png
│   └── waveform_snapshots/
│       ├── idle_state.png
│       ├── red_state.png
│       ├── yellow_state.png
│       ├── green_state.png
│
└── README.md
```

---

## 📌 FSM Design Summary

- **Inputs:** `clk`, `reset_b`, `start`
- **Outputs:** `red`, `yellow`, `green`
- **States:**
  - `IDLE`: All lights OFF
  - `RED`: Red ON
  - `YELLOW`: Yellow ON
  - `GREEN`: Green ON
- **Timing (in simulation time units):**
  - RED: 50ns, YELLOW: 30ns, GREEN: 70ns

---

## ✅ Verification Strategy

- Stimulus is applied using a basic Verilog testbench (`traffic_light_top_tb.v`)
- Clock generation and reset sequencing handled in testbench
- Start signal triggered to test full FSM cycle
- Outputs observed through waveform viewer (e.g., GTKWave, ModelSim)

---

## 🧠 Key Concepts Demonstrated

- FSM Design using `case` statements
- State encoding and transition logic
- Clocked behavior with asynchronous reset
- Separate logic for Next State and Output

---

## 🏃 Run Instructions

```bash
# Compile and simulate (example with ModelSim)
vlog rtl/traffic_light.v tb/traffic_light_top_tb.v
vsim -c work.traffic_light_top_tb -do "run 200ns; quit"
```

---

## 📚 Learning Outcomes

- FSM-based RTL design fundamentals
- Separation of Present State Register (PSR) and Next State Logic (NSL)
- Simulation-based functional validation without SystemVerilog classes

---

## 👨‍💻 Author

- **Uchchhash Sarkar**

---

## 📜 License

This project is for educational purpose only.
