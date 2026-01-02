///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_monitor.sv
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
//   DDR monitor component responsible for sampling DUT interface signals,
//   converting them into sequence items, and forwarding them to analysis
//   components such as checkers or scoreboards.
// Dependencies:
//   ddr_interface, ddr_seq_item, ddr_checker
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_MONITOR_SV
`define DDR_MONITOR_SV

class ddr_monitor extends uvm_monitor;
 
  // Factory registration for DDR monitor
  `uvm_component_utils(ddr_monitor)
  
  // Virtual interface handle used to sample DDR DUT signals
  virtual ddr_interface vif;

  // Handle to DDR checker component for protocol and data checking
  ddr_checker ddr_checker_h;

  // Analysis port used to broadcast monitored DDR transactions
  // to subscribers such as scoreboard or coverage
  uvm_analysis_port#(ddr_seq_item) ddr_mon_analysis_port;
  
  // Constructor: initializes the DDR monitor component
  extern function new(string name ="ddr_monitor",
                      uvm_component parent=null);  

  // Build phase:
  // - Creates analysis port
  // - Instantiates checker
  // - Retrieves virtual interface from configuration database
  extern function void build_phase(uvm_phase phase);

  // Connect phase:
  // - Used to connect monitor ports to other components if required
  extern function void connect_phase(uvm_phase phase);
      
  // Run phase:
  // - Controls runtime behavior of the monitor
  // - Typically calls the monitor task
  extern task run_phase(uvm_phase phase);

  // Monitor task:
  // - Continuously samples DDR interface signals
  // - Packs sampled information into sequence items
  // - Sends transactions through the analysis port
  extern task monitor();

endclass
    
    function ddr_monitor::new(string name ="ddr_monitor",
                              uvm_component parent=null);
      super.new(name,parent);
    endfunction
    
    function void ddr_monitor::build_phase(uvm_phase phase);
      super.build_phase(phase);
            
      // Create analysis port for publishing monitored transactions
      ddr_mon_analysis_port = new("ddr_mon_analysis_port",this);

      // Create DDR checker component
      ddr_checker_h = ddr_checker::type_id::create("ddr_checker_h",this);
      
      // Retrieve virtual interface from configuration database
      if(!uvm_config_db #(virtual ddr_interface)::get(this,"","mon_vif",vif))
        `uvm_error(get_type_name(),
                   "can not able to get interface in monitor")
    endfunction
    
    function void ddr_monitor::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    endfunction
      
    task ddr_monitor::run_phase(uvm_phase phase);
      // Typically, monitor() would be called here in a fork/join or loop
    endtask
      
    task ddr_monitor::monitor();
      // Actual signal sampling and transaction creation logic goes here
    endtask
    
`endif
