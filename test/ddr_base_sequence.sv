///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_base_sequence.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) <Year> Scaledge Technology Pvt. All rights reserved.
// 
// This file is part of the  VIP project.
// Description:
// Dependencies:
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_BASE_SEQUENCE_SV
`define DDR_BASE_SEQUENCE_SV
class ddr_base_sequence extends uvm_sequence;
 
  `uvm_object_utils(ddr_base_sequence)
  
  extern function new(string name ="ddr_base_sequence");
    
  extern task body();
    
endclass
    
    function ddr_base_sequence::new(string name ="ddr_base_sequence");
    super.new(name);
  endfunction
  
  task ddr_base_sequence::body();
    
  endtask
  
`endif