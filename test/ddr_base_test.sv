///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_base_test.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) <Year> Scaledge Technology Pvt. All rights reserved.
// 
// This file is part of the  project.
// Description:
// Dependencies:
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_BASE_TEST_SV
`define DDR_BASE_TEST_SV

class ddr_base_test extends uvm_test;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_base_test)
  
  //////////////////////////////////////////////////////////////////////////
  // Test-level component handles
  //////////////////////////////////////////////////////////////////////////
  ddr_env           ddr_env_h;
  ddr_config        ddr_config_h;
  ddr_base_sequence ddr_base_seq_h;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_base_test",uvm_component parent=null);  

  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase
  // argument      : uvm_phase phase
  // description   : Build phase of DDR base test
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : connect_phase
  // argument      : uvm_phase phase
  // description   : Connect phase of DDR base test
  //////////////////////////////////////////////////////////////////////////
  extern function void connect_phase(uvm_phase phase);
    
  //////////////////////////////////////////////////////////////////////////
  // function name : end_of_elaboration_phase
  // argument      : uvm_phase phase
  // description   : Prints UVM topology
  //////////////////////////////////////////////////////////////////////////
  extern function void end_of_elaboration_phase(uvm_phase phase);
    
  //////////////////////////////////////////////////////////////////////////
  // task name : run_phase
  // argument  : uvm_phase phase
  // description : Starts base sequence and controls objections
  //////////////////////////////////////////////////////////////////////////
  extern task run_phase(uvm_phase phase);
      
endclass
    
function ddr_base_test::new(string name ="ddr_base_test",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_base_test::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  
  ddr_env_h = ddr_env::type_id::create("ddr_env_h",this);
  ddr_config_h = ddr_config::type_id::create("ddr_config_h");
  ddr_base_seq_h = ddr_base_sequence::type_id::create("ddr_base_seq_h");

  uvm_config_db#(ddr_config)::set(this, "*", "ddr_config_h", ddr_config_h);
  ddr_config_h.randomize();
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_base_test::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of connect phase....", UVM_LOW)
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "ending of connect phase....", UVM_LOW)
endfunction
          
function void ddr_base_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of end_of_elaboration phase....", UVM_LOW)
  uvm_top.print_topology();
  `uvm_info(get_type_name(), "ending of end_of_elaboration phase....", UVM_LOW)
endfunction

task ddr_base_test::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of run phase....", UVM_LOW)
  phase.raise_objection(this);
  
  ddr_base_seq_h.start(ddr_env_h.ddr_agent_h.ddr_sequencer_h);
  
  phase.drop_objection(this);
  phase.phase_done.set_drain_time(this,500us );
  `uvm_info(get_type_name(), "ending of run phase....", UVM_LOW)
endtask

`endif