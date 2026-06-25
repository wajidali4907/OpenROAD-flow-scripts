####################################
# global connections
####################################
add_global_connection -net {vdd} -inst_pattern {.*} -pin_pattern {^vdd$} -power
add_global_connection -net {vss} -inst_pattern {.*} -pin_pattern {^vss$} -ground
global_connect
####################################
# voltage domains
####################################
set_voltage_domain -name {CORE} -power {vdd} -ground {vss}
####################################
# standard cell grid
#
# Power uses the COARSE backside layers (BM3 vertical / BM4 horizontal): they are
# wide (0.36 um) and low-resistance -> ideal for IR. The FINE layers BM1/BM2 are
# left FREE for the backside clock mesh (dense, small BTerms).
#
# The cell power pin is BPR, whose only metal exit is BV0->BM1. So power reaches
# the coarse straps through a via column BPR->BM1->BM2->BM3->BM4. Those columns
# put only small via pads on BM1/BM2 at the (sparse, coarse-pitch) strap
# crossings; the fine clock mesh on BM1/BM2 routes around them.
####################################
define_pdn_grid -name {grid} -voltage_domains {CORE} -pins {BM4}
# std-cell rail on BPR (the cell power pin), followpins.
add_pdn_stripe -grid {grid} -layer {BPR} -width {0.032} -pitch {0.144} -offset {0} -followpins
# Coarse power straps: BM3 (vertical) + BM4 (horizontal). Wide, low IR, sparse.
add_pdn_stripe -grid {grid} -layer {BM3} -width {0.36} -spacing {0.36} -pitch {2.16} -offset {1.08}
add_pdn_stripe -grid {grid} -layer {BM4} -width {0.36} -spacing {0.36} -pitch {2.16} -offset {1.08}
# Connect BPR up to the coarse straps. Connecting BPR directly to BM3 makes PDN
# auto-build the via stack BPR->BM1->BM2->BM3, leaving only small intermediate
# via pads on BM1/BM2 (no stripes) -> they stay free for the clock mesh.
add_pdn_connect -grid {grid} -layers {BPR BM3}
add_pdn_connect -grid {grid} -layers {BM3 BM4}
