export DESIGN_NICKNAME = ibex
export DESIGN_NAME     = ibex_core
export PLATFORM        = gt2n

# ibex is SystemVerilog -> slang frontend (same as asap7/nangate45 ibex).
# Use the GT2N-specific latch-free prim_clock_gating (GT2N has no latch/ICG cell;
# the upstream one infers a behavioral latch that OpenROAD's reader rejects).
export VERILOG_FILES = $(sort $(wildcard $(DESIGN_HOME)/src/ibex_sv/*.sv)) \
    $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/prim_clock_gating.v
export VERILOG_INCLUDE_DIRS = \
    $(DESIGN_HOME)/src/ibex_sv/vendor/lowrisc_ip/prim/rtl/
export SDC_FILE             = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export SYNTH_HDL_FRONTEND = slang

export ABC_AREA = 1

# Floorplan: same conservative first-pass as gt2n/jpeg and asap7/ibex.
export CORE_UTILIZATION       = 40
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 2
export PLACE_DENSITY_LB_ADDON = 0.20
export TNS_END_PERCENT        = 100

export SWAP_ARITH_OPERATORS = 1
export OPENROAD_HIERARCHICAL = 1
export ENABLE_DPO             = 0

# Cap at the highest layer ibex actually routes on (M10-M13 unused), matching
# gt2n/jpeg -- shrinks the detailed-route grid, vias, and DRC.
export MAX_ROUTING_LAYER      = M9
