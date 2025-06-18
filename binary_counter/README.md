
# 4-bit Binary Counter – RTL Design and Functional Verification

This project implements a **4-bit binary counter** with support for **up-count, down-count, and load operations**, and verifies its functionality using a **SystemVerilog UVM-like modular testbench**. The verification includes **directed, constrained-random testing** and **functional/code coverage** tracking.

---

## 🔧 Features

- RTL design in **Verilog** (synthesizable)
- Modular verification testbench using **SystemVerilog**
- Verification components:
  - Generator, Driver, Monitor, Scoreboard
  - Mailbox-based transaction communication
  - Configurable random/directed testing
- Full functional and code coverage
- Simulation support with run and regression scripts

---

## 📁 Directory Structure

```bash
binary_counter/
│
├── rtl/                    # RTL Design Files
│   └── binary_counter.v
│
├── tb/                     # Testbench Components
│   ├── interface.sv
│   ├── transaction.sv
│   ├── generator.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── test_base.sv
│   ├── test_cases/         # Different test scenarios
│   │   ├── reset_test.sv
│   │   ├── load_test.sv
│   │   ├── up_count_test.sv
│   │   ├── down_count_test.sv
│   │   ├── rollover_test.sv
│   │   └── sync_test.sv
│   └── tb_top.sv
│
├── coverage/               # Coverage Files
│   ├── functional_cov.sv
│   └── iccr_merge.do
│
├── scripts/
│   ├── run.sh              # Compile and run (batch/gui/cov mode)
│   └── regression.sh       # Run all tests and generate merged coverage
│
├── doc/
│   ├── testplan.xlsx
│   ├── architecture_diagram.png
│   ├── coverage_report.html
│   └── bugs_found.md
│
└── README.md               # Project Overview
```

---

## 📌 Design Summary

The counter has the following features:
- **Inputs:** `clk`, `reset`, `enable`, `load`, `count`, `data_in`
- **Outputs:** `A_count`, `C_out`
- Supports **load**, **increment**, and **decrement**
- **Synchronous reset (expected)** but a bug was found showing asynchronous behavior

---

## ✅ Verification Strategy

- **Stimuli Generation:** Randomized or directed via a generator
- **Communication:** Transaction-based, passed via mailboxes
- **Assertions:** Manual check via scoreboard, with pass/fail reporting
- **Coverage:** 
  - Coverpoints for key signal values
  - Cross-coverage for signal combinations
  - Full branch, expression, and toggle coverage

---

## 🔍 Bugs Identified During Verification

- ❗ Reset behaves asynchronously instead of synchronously
- ❗ Counter fails to decrement when `count=0` and enabled
- ❗ Carry-out (`C_out`) incorrect in rollover conditions

---

## 📈 Coverage

- **Code Coverage:** 100%
- **Functional Coverage:** 100%
  - All bins and crosses were hit during regression

---

## 🏃 Run Instructions

```bash
# Run a test
chmod +x ./scripts/run.sh
./scripts/run.sh -mode "gui" -test_name "reset_test" -Half_Period 10

# Run all tests and merge coverage
chmod +x ./scripts/regression.sh
./scripts/regression.sh
```

---

## 📚 Learning Outcomes

- RTL FSM Design using Verilog
- Transaction-level modular testbench in SystemVerilog
- Use of fork-join, coverage bins, and mailboxes
- Debugging using waveform analysis and scoreboard comparison

---

## 👨‍💻 Author

- **Uchchhash Sarkar**

---

## 📜 License

This project is intended for educational and demonstration purposes. Contact the author for reuse or collaboration.
