///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_top.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) <Year> Scaledge Technology Pvt. All rights reserved.
// 
// This file is part of the project.
// Description:
//   Top-level module for DDR simulation. Instantiates the DDR interface,
//   the DUT (DDR3 memory model), and sets up the clock, reset, and UVM test.
//   Configures the DDR VIP environment and starts the base test.
// Dependencies:
//   - uvm_pkg
//   - ddr_pkg
//   - ddr3_simple4 (DUT memory model)
// Notes:
//   - Generates ck_t/ck_c clock signals.
//   - Generates synchronous reset signal.
//   - Configures virtual interface for UVM environment.
//   - Dumps simulation waveforms to VCD file for debugging.
//////////////////////////////////////////////////////////////////////////////////
`include "ddr_defines.sv"

`ifdef USE_QUESTA
  `timescale 1ns/1ps
`endif
module ddr_tb_top;

  // Import UVM and DDR package
  import uvm_pkg::*;
  import ddr_pkg::*;

  //////////////////////////////////////////////////////////////////////////
  // Clock and reset signals
  //////////////////////////////////////////////////////////////////////////
  bit ck_c, ck_t, reset_n;

  //////////////////////////////////////////////////////////////////////////
  // DDR interface instance connecting DUT and VIP components
  //////////////////////////////////////////////////////////////////////////
  ddr_interface inf(.ck_t(ck_t), .reset_n(reset_n));

  //////////////////////////////////////////////////////////////////////////
  // DUT instantiation
  // DDR3 simple memory model with parameterized widths and timing
  //////////////////////////////////////////////////////////////////////////
  ddr3_simple4 #(
    .MEM_DQ_WIDTH(`MEM_DQ_WIDTH),
    .MEM_BA_WIDTH(`MEM_BA_WIDTH),
    .MEM_ROW_WIDTH(`MEM_ROW_WIDTH),
    .MEM_COL_WIDTH(`MEM_COL_WIDTH),
    .AL(`AL),
    .CWL(`CWL),
    .CL(`CL)
  ) dut (
    .a(inf.a),
    .ba(inf.ba),
    .ck(inf.ck_t),
    .ck_n(inf.ck_c),
    .cke(inf.cke),
    .cs_n(inf.cs_n),
    .dm(inf.dm),
    .ras_n(inf.ras_n),
    .cas_n(inf.cas_n),
    .we_n(inf.we_n),
    .reset_n(inf.reset_n),
    .dq(inf.dq),
    .dqs(inf.dqs_t),
    .dqs_n(inf.dqs_c),
    .odt(inf.odt)
  );

  bind ddr_tb_top ddr_assertion asrt(.inf(inf));

  ///////////////////////////////////////////////////////////////////////////////////////
  // Clock generation
  // Generates ck_t and complementary ck_c signals with 2.5ns period and 400MHz frequency
  //////////////////////////////////////////////////////////////////////////////////////

  initial begin
    ck_t = 0;
    ck_c = 1;
    forever begin
      ck_c = ~ck_t;
      #((`TIMEPERIOD)/2) ck_t = ~ck_t;
    end
  end

  //////////////////////////////////////////////////////////////////////////
  // Reset generation
  // Active-low reset for DDR interface and DUT
  //////////////////////////////////////////////////////////////////////////
  initial begin
    reset_n = 1;
    #20ns reset_n = 0;  // Assert reset
    #200us reset_n = 1;  // Deassert reset
  end

  //////////////////////////////////////////////////////////////////////////
  // UVM test initialization
  // - Configures virtual interface for DDR VIP environment
  // - Runs the base test
  //////////////////////////////////////////////////////////////////////////
  initial begin
    uvm_config_db #(virtual ddr_interface)::set(null,"uvm_test_top.ddr_env*","vif",inf);
    run_test("ddr_base_test");
  end

  initial begin
    $printtimescale();
  end

`ifndef USE_QUESTA
  initial begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars;
  end
`endif
endmodule
