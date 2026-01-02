///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_config.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) <Year> Scaledge Technology Pvt. All rights reserved.
// 
// This file is part of the VIP project.
// Description:
//   Configuration object for DDR VIP components.
//   Used to store environment/test specific parameters.
// Dependencies:
//   None
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_CONFIG_SV
`define DDR_CONFIG_SV

class ddr_config extends uvm_object;
 
  // Factory registration for DDR configuration object
  `uvm_object_utils(ddr_config)
  
  // Constructor:
  // Initializes the configuration object
  extern function new(string name ="ddr_config");

endclass

function ddr_config::new(string name ="ddr_config");
  super.new(name);
endfunction

`endif