///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_env.sv
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
`ifndef DDR_ENV_SV
`define DDR_ENV_SV

class ddr_env extends uvm_env;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_env)
  
  //////////////////////////////////////////////////////////////////////////
  // Virtual interface handle
  //////////////////////////////////////////////////////////////////////////
  virtual ddr_interface vif;
  
  //////////////////////////////////////////////////////////////////////////
  // DDR environment component handles
  //////////////////////////////////////////////////////////////////////////
  ddr_agent               ddr_agent_h;
  ddr_config              ddr_config_h;
  ddr_scoreboard          ddr_scoreboard_h;
  ddr_coverage_collector  ddr_coverage_collector_h;
  ddr_refrence_model      ddr_refrence_model_h;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_env",uvm_component parent=null);  

  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase
  // argument      : uvm_phase phase
  // description   : Build phase of DDR environment
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : connect_phase
  // argument      : uvm_phase phase
  // description   : Connect phase of DDR environment
  //////////////////////////////////////////////////////////////////////////
  extern function void connect_phase(uvm_phase phase);
      
endclass
    
function ddr_env::new(string name ="ddr_env",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);      
  ddr_agent_h = ddr_agent::type_id::create("ddr_agent_h",this);
  ddr_scoreboard_h = ddr_scoreboard::type_id::create("ddr_scoreboard_h",this);
  ddr_coverage_collector_h = ddr_coverage_collector::type_id::create("ddr_coverage_collector_h",this);
  ddr_refrence_model_h = ddr_refrence_model::type_id::create("ddr_refrence_model_h",this);
  
  if(!uvm_config_db #(virtual ddr_interface)::get(this,"","vif",vif))
    `uvm_error(get_type_name(),"can not able to get interface in env")
  else
    uvm_config_db #(virtual ddr_interface)::set(this,"ddr_agent*","vif",vif);    
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of connect phase....", UVM_LOW)
  super.connect_phase(phase);     
  ddr_agent_h.ddr_monitor_h.ddr_mon_analysis_port.connect(ddr_scoreboard_h.ddr_scoreboard_mon_port);
  ddr_agent_h.ddr_monitor_h.ddr_mon_analysis_port.connect(ddr_coverage_collector_h.ddr_coverage_collector_imp_port);
  ddr_agent_h.ddr_monitor_h.ddr_mon_analysis_port.connect(ddr_refrence_model_h.ddr_refrence_model_imp_port);
  ddr_refrence_model_h.ddr_refrence_model_put_port.connect(ddr_scoreboard_h.ddr_scoreboard_ref_port);
  `uvm_info(get_type_name(), "ending of connect phase....", UVM_LOW)
endfunction
          
`endif