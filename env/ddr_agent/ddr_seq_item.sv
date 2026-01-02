///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_seq_item.sv
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
//   DDR sequence item defining all signals for a single DDR transaction.
//   Includes row/column/bank addresses, control, data, strobe, and ODT signals.
//   Field macros are added for UVM automation (copy, print, compare, pack/unpack).
// Dependencies:
//   ddr_defines.sv (for MEM_* widths)
// Notes:
//   - Randomizable fields are declared with 'rand'.
//   - All fields are registered using UVM macros for full sequence item functionality.
//////////////////////////////////////////////////////////////////////////////////

`ifndef DDR_SEQ_ITEM_SV
`define DDR_SEQ_ITEM_SV

class ddr_seq_item extends uvm_sequence_item;

  //////////////////////////////////////////////////////////////////////////
  // Address and Bank signals (randomizable)
  //////////////////////////////////////////////////////////////////////////
  rand bit [`MEM_ROW_WIDTH-1:0] a;   // Row address
  rand bit [`MEM_BA_WIDTH-1:0] ba;   // Bank address

  //////////////////////////////////////////////////////////////////////////
  // Control signals
  //////////////////////////////////////////////////////////////////////////
  bit cke;        // Clock enable
  bit cs_n;       // Chip select (active low)
  bit dm;         // Data mask
  bit ras_n;      // Row address strobe (active low)
  bit cas_n;      // Column address strobe (active low)
  bit we_n;       // Write enable (active low)
  bit reset_n;    // Reset (active low)

  //////////////////////////////////////////////////////////////////////////
  // Data and strobe signals
  //////////////////////////////////////////////////////////////////////////
  bit [`MEM_DQ_WIDTH-1:0] dq;   // Data bus
  bit dqs_t;                     // Data strobe positive
  bit dqs_n;                     // Data strobe complementary
  bit odt;                       // On-die termination

  //////////////////////////////////////////////////////////////////////////
  // Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_object_utils_begin(ddr_seq_item)

    // Register fields for print, copy, compare, pack/unpack
  `uvm_field_int(a,UVM_HEX | UVM_ALL_ON)       // Row address
  `uvm_field_int(ba,UVM_HEX | UVM_ALL_ON)      // Bank address
  `uvm_field_int(cke,UVM_HEX | UVM_ALL_ON)     // Clock enable
  `uvm_field_int(cs_n,UVM_HEX | UVM_ALL_ON)    // Chip select
  `uvm_field_int(dm,UVM_HEX | UVM_ALL_ON)      // Data mask
  `uvm_field_int(ras_n,UVM_HEX | UVM_ALL_ON)   // Row address strobe
  `uvm_field_int(cas_n,UVM_HEX | UVM_ALL_ON)   // Column address strobe
  `uvm_field_int(we_n,UVM_HEX | UVM_ALL_ON)    // Write enable
  `uvm_field_int(reset_n,UVM_HEX | UVM_ALL_ON)// Reset
  `uvm_field_int(dq,UVM_HEX | UVM_ALL_ON)      // Data bus
  `uvm_field_int(dqs_t,UVM_HEX | UVM_ALL_ON)   // Data strobe positive
  `uvm_field_int(dqs_n,UVM_HEX | UVM_ALL_ON)   // Data strobe complementary
  `uvm_field_int(odt,UVM_HEX | UVM_ALL_ON)     // On-die termination

  `uvm_object_utils_end

  //////////////////////////////////////////////////////////////////////////
  // Constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name = "ddr_seq_item");

endclass

function ddr_seq_item::new(string name = "ddr_seq_item");
  super.new(name);
endfunction

`endif