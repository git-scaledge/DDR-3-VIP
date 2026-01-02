///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_coverage_collector.sv
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
`ifndef DDR_COVERAGE_COLLECTOR_SV
`define DDR_COVERAGE_COLLECTOR_SV

class ddr_coverage_collector extends uvm_component;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_coverage_collector)
  
  //////////////////////////////////////////////////////////////////////////
  // Analysis implementation port
  // Receives DDR transactions for coverage collection
  //////////////////////////////////////////////////////////////////////////
  uvm_analysis_imp#(ddr_seq_item,ddr_coverage_collector) ddr_coverage_collector_imp_port;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_coverage_collector",uvm_component parent=null);  
   
  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase 
  // argument      : uvm_phase phase
  // description   : Build phase of DDR coverage collector
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);
      
  //////////////////////////////////////////////////////////////////////////
  // function name : write
  // argument      : ddr_seq_item req
  // description   : Collects coverage from incoming transactions
  //////////////////////////////////////////////////////////////////////////
  extern function void write(ddr_seq_item req);

endclass
    
function ddr_coverage_collector::new(string name ="ddr_coverage_collector",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_coverage_collector::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  ddr_coverage_collector_imp_port = new("ddr_coverage_collector_imp_port",this);
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_coverage_collector::write(ddr_seq_item req);
      
endfunction
    
`endif
