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
# standard cell grid (backside power: BPR followpins + BM1/BM2 mesh)
####################################
define_pdn_grid -name {grid} -voltage_domains {CORE} -pins {BM2}
add_pdn_stripe -grid {grid} -layer {BPR} -width {0.032} -pitch {0.144} -offset {0} -followpins
# RIGHT-SIZED fine-layer grid (worksheet-designed, gcd @ 2GHz alpha=1):
#   P_peak=0.353mW -> I=0.504mA; budget 2.5% of 0.7V = 17.5mV -> R_grid<=35ohm;
#   one 0.2um strap ~43ohm -> IR needs >=2/net; redundancy floor >=2/net.
#   => 0.2um straps at 3.0um pitch (2-3 per net per direction).
#   Verified: VDD 0.13% / VSS 0.04% IR at worst case, PSM-0040 connected,
#   EM 1.26mA/um. Narrower than the 0.224/0.448 originals -> more BM1/BM2
#   tracks left for the backside clock mesh.
add_pdn_stripe -grid {grid} -layer {BM1} -width {0.2} -pitch {3.0} -offset {1.5}
add_pdn_stripe -grid {grid} -layer {BM2} -width {0.2} -pitch {3.0} -offset {1.5}
add_pdn_connect -grid {grid} -layers {BPR BM1}
add_pdn_connect -grid {grid} -layers {BM1 BM2}
