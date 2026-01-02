///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_driver.sv
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
//   DDR driver component responsible for driving stimulus transactions
//   received from the sequencer onto the DDR DUT interface.
// Dependencies:
//   ddr_interface, ddr_seq_item
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_DRIVER_SV
`define DDR_DRIVER_SV

class ddr_driver extends uvm_driver#(ddr_seq_item);
 
  // Factory registration for DDR driver
  `uvm_component_utils(ddr_driver)
  
  // Virtual interface handle used to drive signals to the DDR DUT
  virtual ddr_interface vif;

  // Constructor:
  // Initializes the DDR driver component
  extern function new(string name ="ddr_driver",
                      uvm_component parent=null);  

  // Build phase:
  // Retrieves the virtual interface required for driving DUT signals
  extern function void build_phase(uvm_phase phase);

  // Connect phase:
  // Used to connect TLM ports or perform post-build connections if needed
  extern function void connect_phase(uvm_phase phase);
      
  // Run phase:
  // Controls the main runtime behavior of the driver
  // Typically fetches sequence items and calls drive task
  extern task run_phase(uvm_phase phase);

  // Drive task:
  // Drives a single DDR transaction onto the DUT interface
  // based on the received sequence item
  extern task drive();

endclass
    
    function ddr_driver::new(string name ="ddr_driver",
                             uvm_component parent=null);
      super.new(name,parent);
    endfunction
      
    function void ddr_driver::build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Retrieve virtual interface from configuration database
      if(!uvm_config_db #(virtual ddr_interface)::get(this,"","drv_vif",vif))
        `uvm_error(get_type_name(),
                   "can not able to get interface in driver")
    endfunction
        
    function void ddr_driver::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    endfunction
      
    task ddr_driver::run_phase(uvm_phase phase);
      // Main driver execution loop is typically implemented here
    endtask
      
    task ddr_driver::drive();
      // Actual signal-driving logic based on DDR protocol goes here
    endtask
    
`endif
