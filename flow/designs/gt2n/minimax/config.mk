export DESIGN_NICKNAME = minimax
export DESIGN_NAME     = minimax
export PLATFORM        = gt2n

# Release RTL from HighTide (plain Verilog, already sv2v-converted -> no slang).
export VERILOG_FILES = /home/wali2/backside/HighTide/designs/src/minimax/minimax.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export ABC_AREA = 1

# Floorplan args translated from HighTide designs/gt2n/minimax/BUILD.bazel.
export CORE_UTILIZATION   = 60
export PLACE_DENSITY      = 0.7
export CORE_ASPECT_RATIO  = 1.0
export CORE_MARGIN        = 4
export MAX_ROUTING_LAYER  = M9
export TNS_END_PERCENT    = 100
