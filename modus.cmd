# Cadence Modus
#   Cadence(R) Modus(TM) DFT Software Solution, Version 20.12-s002_1, built Feb 26 2021 (linux26_64)
#   Date: Saturday, October 31, 2026
build_model -designsource design.v
build_testmode -testmode FULLSCAN
verify_test_structures -testmode FULLSCAN
build_faultmodel
exit
