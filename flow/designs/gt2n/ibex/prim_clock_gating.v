// GT2N-specific clock-gating stub for ibex.
//
// The upstream ibex prim_clock_gating.v infers a level-sensitive latch
// (en_latch). GT2N has NO latch/ICG cell (LATCH_MAP_FILE is empty), so that
// latch cannot map to a gate and stays behavioral -- which OpenROAD's
// structural Verilog reader rejects (STA-0171 syntax error).
//
// GT2N's platform clock gate (cells_clkgate.v / OPENROAD_CLKGATE) is itself a
// pure passthrough (GCK = CK, enable ignored), so clock gating has no physical
// effect on this PDK. Model prim_clock_gating as a latch-free clock passthrough:
// synthesizes to a wire/buffer, reads cleanly, and matches platform behavior.
module prim_clock_gating (
  input  clk_i,
  input  en_i,
  input  test_en_i,
  output clk_o
);
  assign clk_o = clk_i;
endmodule
