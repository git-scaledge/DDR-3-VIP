///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_interface.sv
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
//   DDR interface defining all signals for DDR memory communication,
//   along with driver and monitor clocking blocks and modports for
//   UVM components to interact with the DUT.
// Dependencies:
//   ddr_defines.sv (for memory parameter widths)
// Notes:
//   - Clocking blocks provide timing and signal sampling points for driver
//     and monitor components.
//////////////////////////////////////////////////////////////////////////////////

`ifdef USE_QUESTA
  `timescale 1ns/1ps
`endif

`ifndef DDR_INTERFACE_SV
`define DDR_INTERFACE_SV

// DDR interface declaration with clock and reset inputs
interface ddr_interface(input logic ck_t, input logic reset_n);

  //////////////////////////////////////////////////////////////////////////
  // Address and Bank signals
  //////////////////////////////////////////////////////////////////////////
  logic [`MEM_ROW_WIDTH-1:0] a;       // Row address
  logic [`MEM_BA_WIDTH-1:0] ba;       // Bank address

  //////////////////////////////////////////////////////////////////////////
  // Control signals
  //////////////////////////////////////////////////////////////////////////
  logic ck_c;        // Complementary clock
  logic cke;         // Clock enable
  logic cs_n;        // Chip select (active low)
  logic ras_n;       // Row address strobe (active low)
  logic cas_n;       // Column address strobe (active low)
  logic we_n;        // Write enable (active low)
  logic odt;         // On-die termination control

  //////////////////////////////////////////////////////////////////////////
  // Data signals
  //////////////////////////////////////////////////////////////////////////
  logic dm;          // Data mask
  wire [`MEM_DQ_WIDTH-1:0] dq;  // Data bus
  wire dqs_t;        // Data strobe true
  wire dqs_c;        // Data strobe complementary

  //assign complement of ck_t to ck_c
  assign ck_c = ~ck_t;

  //////////////////////////////////////////////////////////////////////////
  // Driver clocking block
  // Used by driver to drive outputs and sample inputs
  //////////////////////////////////////////////////////////////////////////
  clocking ddr_drv_cb @(posedge ck_t);
    default input #1 output #1;
    
    // Output signals driven by the driver
    output a, ba, cke, cs_n, dm, ras_n, cas_n, we_n, odt;
    output dq, dqs_t, dqs_c;

  endclocking

  //////////////////////////////////////////////////////////////////////////
  // Monitor clocking block
  // Used by monitor to sample DUT signals
  //////////////////////////////////////////////////////////////////////////
  clocking ddr_mon_cb @(posedge ck_t);
    default input #1 output #0;
    
    // Input signals sampled by monitor
    input dq, dqs_t, dqs_c;
    input a, ba, cke, cs_n, dm, ras_n, cas_n, we_n;
  endclocking

  //////////////////////////////////////////////////////////////////////////
  // Modports
  // Define signal access restrictions for driver and monitor components
  //////////////////////////////////////////////////////////////////////////
  modport ddr_drv_mp(
    input ck_t, reset_n,        // Inputs to driver
    clocking ddr_drv_cb          // Clocking block for driver
  );

  modport ddr_mon_mp(
    input ck_t, reset_n,        // Inputs to monitor
    clocking ddr_mon_cb          // Clocking block for monitor
  );

endinterface
`endif
