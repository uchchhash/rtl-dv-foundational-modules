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
