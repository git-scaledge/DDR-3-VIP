///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_agent.sv
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
`ifndef DDR_AGENT_SV
`define DDR_AGENT_SV

class ddr_agent extends uvm_agent;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_agent)
  
  //////////////////////////////////////////////////////////////////////////
  // Virtual interface handle
  //////////////////////////////////////////////////////////////////////////
  virtual ddr_interface vif;

  //////////////////////////////////////////////////////////////////////////
  // Agent sub-component handles
  //////////////////////////////////////////////////////////////////////////
  ddr_driver    ddr_driver_h;
  ddr_monitor   ddr_monitor_h;
  ddr_sequencer ddr_sequencer_h;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_agent",uvm_component parent=null);  

  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase
  // argument      : uvm_phase phase
  // description   : Build phase of DDR agent
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : connect_phase
  // argument      : uvm_phase phase
  // description   : Connect phase of DDR agent
  //////////////////////////////////////////////////////////////////////////
  extern function void connect_phase(uvm_phase phase);
      
endclass
    
function ddr_agent::new(string name ="ddr_agent",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_agent::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  
  ddr_driver_h    = ddr_driver::type_id::create("ddr_driver_h",this);
  ddr_monitor_h   = ddr_monitor::type_id::create("ddr_monitor_h",this);
  ddr_sequencer_h = ddr_sequencer::type_id::create("ddr_sequencer_h",this);
  
  if(!uvm_config_db #(virtual ddr_interface)::get(this,"","vif",vif))
    `uvm_error(get_type_name(),"can not able to get interface in agent")
  else
    begin
      uvm_config_db #(virtual ddr_interface)::set(this,"ddr_driver*","drv_vif",vif);  
      uvm_config_db #(virtual ddr_interface)::set(this,"ddr_monitor*","mon_vif",vif);  
    end
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
    
function void ddr_agent::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of connect phase....", UVM_LOW)
  super.connect_phase(phase);
  ddr_driver_h.seq_item_port.connect(ddr_sequencer_h.seq_item_export);
  `uvm_info(get_type_name(), "ending of connect phase....", UVM_LOW)
endfunction
          
`endif
