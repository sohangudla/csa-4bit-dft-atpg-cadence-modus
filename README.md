# 4-bit Carry-Save Adder: DFT, Fault Collapsing and ATPG with Cadence Modus

Simulation assignment for **23ECE336 VLSI Testing and Testability** (B.Tech ECE, Amrita School of Engineering, Bengaluru, AY 2026-27).

## Design

`design.v` is a gate-level 4-bit carry-save adder (3:2 compressor): three 4-bit operands X, Y, Z produce a sum vector S and a carry vector C with X + Y + Z = S + 2C.
12 primary inputs, 8 primary outputs, 20 gates, 3 logic levels, purely combinational. Each gate is wrapped in its own one-gate cell (XOR2 / AND2 / OR2) so Modus places stuck-at faults on every gate pin.

## Flow (Cadence Modus 20.12)

1. `build_model -designsource design.v`
2. `build_testmode -testmode FULLSCAN`
3. `verify_test_structures -testmode FULLSCAN`
4. `build_faultmodel` — stuck-at fault list and equivalence collapsing
5. `create_logic_tests -testmode FULLSCAN -experiment FULL` — ATPG
6. `report_faults ... -faultstatus "untested aborted redundant"` → `faults_hard.log`
7. Pattern-limited and coverage-limited ATPG experiments (`-maxpatterns 7`, `-maxcoverage 70.0`)

## Files

| Path | Contents |
|---|---|
| `design.v`, `design.bench` | Gate-level netlist (Verilog and ISCAS bench format) |
| `design.test`, `design.vec` | Test patterns / vectors |
| `modus.cmd`, `modus.log` | Modus command script and run log |
| `faults_hard.log` | Hard-to-test fault report |
| `testresults/` | Modus logs, STIL and Verilog pattern exports |
| `Simulation_Assignment_Report_csa_4bit.pdf` / `.docx` / `.pptx` | Report and slides with results and analysis |
