///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_scoreboard.sv
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
`ifndef DDR_SCOREBOARD_SV
`define DDR_SCOREBOARD_SV

class ddr_scoreboard extends uvm_component;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_scoreboard)
  
  //////////////////////////////////////////////////////////////////////////
  // Analysis implementation port
  // Receives transactions from DDR monitor
  //////////////////////////////////////////////////////////////////////////
  uvm_analysis_imp#(ddr_seq_item,ddr_scoreboard) ddr_scoreboard_mon_port;

  //////////////////////////////////////////////////////////////////////////
  // Blocking put implementation port
  // Receives transactions from DDR reference model
  //////////////////////////////////////////////////////////////////////////
  uvm_blocking_put_imp#(ddr_seq_item,ddr_scoreboard) ddr_scoreboard_ref_port;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_scoreboard",uvm_component parent=null);  
   
  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase 
  // argument      : uvm_phase phase
  // description   : Build phase of DDR scoreboard
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);
      
  //////////////////////////////////////////////////////////////////////////
  // function name : write
  // argument      : ddr_seq_item req
  // description   : Receives transactions from monitor
  //////////////////////////////////////////////////////////////////////////
  extern function void write(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // task name : put
  // argument  : ddr_seq_item req
  // description : Receives transactions from reference model
  //////////////////////////////////////////////////////////////////////////
  extern task put(ddr_seq_item req);

endclass
    
function ddr_scoreboard::new(string name ="ddr_scoreboard",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_scoreboard::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  ddr_scoreboard_mon_port = new("ddr_scoreboard_mon_port",this);
  ddr_scoreboard_ref_port = new("ddr_scoreboard_ref_port",this);
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_scoreboard::write(ddr_seq_item req);
      
endfunction
      
task ddr_scoreboard::put(ddr_seq_item req);
      
endtask
    
`endif