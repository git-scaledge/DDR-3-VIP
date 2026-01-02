///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_checker.sv
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
`ifndef DDR_CHECKER_SV
`define DDR_CHECKER_SV

class ddr_checker extends uvm_component;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_checker)  
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_checker",uvm_component parent=null);  
   
  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase
  // argument      : uvm_phase phase
  // description   : Build phase of DDR checker
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : connect_phase
  // argument      : uvm_phase phase
  // description   : Connect phase of DDR checker
  //////////////////////////////////////////////////////////////////////////
  extern function void connect_phase(uvm_phase phase);

endclass
    
function ddr_checker::new(string name ="ddr_checker",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_checker::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
      
function void ddr_checker::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of connect phase....", UVM_LOW)
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "ending of connect phase....", UVM_LOW)
endfunction
           
`endif
