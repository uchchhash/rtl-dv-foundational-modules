
# Universal Shift Register – RTL Design and SystemVerilog Verification

This project implements a **4-bit Universal Shift Register** with support for parallel load, left shift, right shift, and hold operations. The design is tested through a structured, modular SystemVerilog testbench featuring constrained-random and directed verification, and comprehensive functional/code coverage.

---

## 🔧 Features

- Synthesizable Verilog RTL of a Universal Shift Register
- Modular SystemVerilog testbench with:
  - Generator, Driver, Monitor, Scoreboard, and Coverage
  - Event-based synchronization and transaction-driven architecture
- Coverage-driven verification including cross coverage
- Bash scripts for test execution and regression

---

## 📁 Directory Structure

```bash
universal_shift_register/
│
├── rtl/                    
│   └── shift_register.v
│
├── tb/                     
│   ├── interface.sv
│   ├── transaction.sv
│   ├── generator.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── coverage.sv
│   ├── test_base.sv
│   ├── test_cases/
│   │   ├── reset_test.sv
│   │   ├── data_load_test.sv
│   │   ├── left_shift_test.sv
│   │   ├── right_shift_test.sv
│   │   ├── hold_test.sv
│   │   └── random_test.sv
│   └── tb_top.sv
│
├── scripts/
│   ├── run.sh              
│   └── regression.sh       
│
├── doc/
│   ├── testplan.xlsx
│   ├── coverage_report.html
│   └── bug_report.md
│
└── README.md
```

---

## 📌 Design Summary

- **Inputs:** `clk`, `reset`, `I_par`, `MSB_in`, `LSB_in`, `s0`, `s1`
- **Output:** `A_par` (4-bit shift register output)
- **Functionality:**
  - Parallel load: `s1=1, s0=1`
  - Left shift: `s1=1, s0=0`
  - Right shift: `s1=0, s0=1`
  - Hold: `s1=0, s0=0`

---

## ✅ Verification Strategy

- **Transaction-based communication** via mailboxes
- **Tasks** for reset, load, shift, and hold operations
- **Functional and code coverage** collected using covergroups and coverpoints
- **Randomized tests** supported through `randsequence` blocks

---

## 🐞 Bug Highlights

- **Data Load Error:** In `data_set_test`, loading `4'b0110` results in `4'b1001`
- **Right Shift Bug:** MSB output observed as inverted due to suspected `~` gate in RTL

---

## 📈 Coverage

- **Functional Coverage:** 100%
- **Code Coverage:** 89% (default cases not fully hit)

---

## 🏃 Run Instructions

```bash
# Run a single test
chmod +x ./scripts/run.sh
./scripts/run.sh gui reset_test 10

# Run all regression tests with coverage
chmod +x ./scripts/regression.sh
./scripts/regression.sh
```

---

## 📚 Learning Outcomes

- FSM and shift register design in Verilog
- SystemVerilog class-based testbench architecture
- Scoreboarding, fork-join control, mailbox communication
- Functional coverage and assertion-based testing

---

## 👨‍💻 Author

- **Uchchhash Sarkar**

---

## 📜 License

This project is intended for educational and demonstrative purposes. For reuse or collaboration, please contact the author.
