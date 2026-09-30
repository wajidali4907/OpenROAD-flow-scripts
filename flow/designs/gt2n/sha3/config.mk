export DESIGN_NICKNAME = sha3
export DESIGN_NAME     = sha3
export PLATFORM        = gt2n

# Release RTL from HighTide (plain Verilog, already sv2v-converted -> no slang).
export VERILOG_FILES = /home/wali2/backside/HighTide/designs/src/sha3/sha3.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export ABC_AREA = 1

# Floorplan args translated from HighTide designs/gt2n/sha3/BUILD.bazel.
export CORE_UTILIZATION   = 50
export PLACE_DENSITY      = 0.60
export MAX_ROUTING_LAYER  = M7
export TNS_END_PERCENT    = 100
