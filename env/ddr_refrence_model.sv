///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_refrence_model.sv
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
`ifndef DDR_REFRENCE_MODEL_SV
`define DDR_REFRENCE_MODEL_SV

class ddr_refrence_model extends uvm_component;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_refrence_model)
  
  //////////////////////////////////////////////////////////////////////////
  // Analysis implementation port
  // Receives DDR transactions from monitor
  //////////////////////////////////////////////////////////////////////////
  uvm_analysis_imp#(ddr_seq_item,ddr_refrence_model) ddr_refrence_model_imp_port;
  
  //////////////////////////////////////////////////////////////////////////
  // Blocking put port
  // Sends DDR transactions to scoreboard
  //////////////////////////////////////////////////////////////////////////
  uvm_blocking_put_port#(ddr_seq_item) ddr_refrence_model_put_port;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_refrence_model",uvm_component parent=null);  
   
  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase 
  // argument      : uvm_phase phase
  // description   : Build phase of DDR reference model
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);
      
  //////////////////////////////////////////////////////////////////////////
  // function name : write
  // argument      : ddr_seq_item req
  // description   : Receives transactions from analysis port
  //////////////////////////////////////////////////////////////////////////
  extern function void write(ddr_seq_item req);

endclass
    
function ddr_refrence_model::new(string name ="ddr_refrence_model",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_refrence_model::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  ddr_refrence_model_imp_port = new("ddr_refrence_model_imp_port",this);
  ddr_refrence_model_put_port = new("ddr_refrence_model_put_port",this);
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_refrence_model::write(ddr_seq_item req);
      
endfunction

`endif