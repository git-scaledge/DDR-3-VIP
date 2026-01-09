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
  bit reset_n;    // Reset (active low)
  /*
  bit cke;             // Clock enable
  bit cs_n;            // Chip select (active low)
  bit ras_n;           // Row address strobe (active low)
  bit cas_n;           // Column address strobe (active low)
  bit we_n;            // Write enable (active low)
  */
  rand command_e cmd;  // DDR3 commands

  //////////////////////////////////////////////////////////////////////////
  // Data and strobe signals
  //////////////////////////////////////////////////////////////////////////
  rand bit [`MEM_DQ_WIDTH-1:0] dq_q[$]; // Data bus
  bit dm_q[$];                          // Data mask
  bit odt;                              // On-die termination

  //////////////////////////////////////////////////////////////////////////
  // Constraints
  //////////////////////////////////////////////////////////////////////////
  constraint dq_size{ // constraint to determine BC4 or BL8 transaction
    dq_q.size == a[12] ? 4:8;
  }

  constraint cmd_mrs {
    if (cmd == MRS) 
      ba inside {[0:2]};
  }
  constraint cmd_ap_bc {
    if (cmd == PRE) 
      a[10] == 0;
    if (cmd == PREA) 
      a[10] == 1;

    if (cmd == WR || cmd == RD) 
      a[10] == 0;
    if (cmd == WRS4 || cmd == RDS4) {
      a[10] == 0; 
      a[12] == 0;
    }
    if (cmd == WRS8 || cmd == RDS8) {
      a[10] == 0; 
      a[12] == 1;
    }
    if (cmd == WRA || cmd == RDA) 
      a[10] == 1;
    if (cmd == WRAS4 || cmd == RDAS4) {
      a[10] == 1; 
      a[12] == 0;
    }
    if (cmd == WRAS8 || cmd == RDAS8) {
      a[10] == 1; 
      a[12] == 1;
    }
  }

  //////////////////////////////////////////////////////////////////////////
  // Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_object_utils_begin(ddr_seq_item)

    // Register fields for print, copy, compare, pack/unpack
    `uvm_field_enum(command_e,cmd,UVM_ALL_ON)       // DDR3 commands
    `uvm_field_int(reset_n,UVM_HEX | UVM_ALL_ON)    // Reset
    `uvm_field_int(a,UVM_HEX | UVM_ALL_ON)          // Row address
    `uvm_field_int(ba,UVM_HEX | UVM_ALL_ON)         // Bank address
    `uvm_field_int(odt,UVM_HEX | UVM_ALL_ON)        // On-die termination
    `uvm_field_queue_int(dm_q,UVM_HEX | UVM_ALL_ON) // Data mask
    `uvm_field_queue_int(dq_q,UVM_HEX | UVM_ALL_ON) // Data bus

    /*
    `uvm_field_int(cke,UVM_HEX | UVM_ALL_ON)     // Clock enable
    `uvm_field_int(cs_n,UVM_HEX | UVM_ALL_ON)    // Chip select
    `uvm_field_int(ras_n,UVM_HEX | UVM_ALL_ON)   // Row address strobe
    `uvm_field_int(cas_n,UVM_HEX | UVM_ALL_ON)   // Column address strobe
    `uvm_field_int(we_n,UVM_HEX | UVM_ALL_ON)    // Write enable
    */
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