
///////////////////////////////////////////////////////////////////////////
// Filename: ddr_monitor.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) &lt;Year&gt; Scaledge Technology Pvt. All rights reserved.
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

`include "uvm_macros.svh"
import uvm_pkg::*;

class ddr_monitor extends uvm_monitor;
 
  // Factory registration for DDR monitor
  `uvm_component_utils(ddr_monitor)
  
  // Virtual interface handle used to sample DDR DUT signals
  virtual ddr_interface vif;

  // Handle to DDR checker component for protocol and data checking
  ddr_checker ddr_checker_h;

  // Local variables for sampling commands
    bit[1:0] otf;
    bit [3:0] bl = 8;
  // Analysis port used to broadcast monitored DDR transactions
  // to subscribers such as scoreboard or coverage
  uvm_analysis_port#(ddr_seq_item) ddr_mon_analysis_port;

  // Local handle for the monitored sequence item
  ddr_seq_item req;
  
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
  extern task wait_for_reset_assert();
  extern task wait_for_reset_deassert();
  extern task command_select();
  extern task trans_command_select();
  extern task self_refresh();
  extern task power_down();
  extern task write_read_data();
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
      forever begin
        wait_for_reset_deassert();
        fork
          monitor();
          wait_for_reset_assert();
        join_any
        disable fork;
        wait_for_reset_deassert(); 
      end
    endtask
      
    task ddr_monitor::monitor();
      // Actual signal sampling and transaction creation logic goes here
      forever begin
        @(posedge vif.ck_t);

        // Create sequence item for this sampled transaction
        req = ddr_seq_item::type_id::create("req", this);

        req.a  = vif.ddr_mon_cb.a;
        req.ba = vif.ddr_mon_cb.ba;
        req.reset_n = vif.reset_n;
        command_select();
        trans_command_select();
        write_read_data();
        // Publish the monitored transaction
        if(!(req.cmd == DES || req.cmd == NOP)) begin
          req.set_name($sformatf("MONITOR: RECEIVED PKT FROM INF", $time));
          req.print();
          ddr_mon_analysis_port.write(req);
        end
      end  
    endtask
   
    task ddr_monitor::wait_for_reset_assert();
      ddr_seq_item item;
      @(negedge vif.reset_n);
      item = ddr_seq_item::type_id::create("item", this);
      item.reset_n = 0;
      ddr_mon_analysis_port.write(item);
      
      
    endtask

    task ddr_monitor::wait_for_reset_deassert();
      @(posedge vif.reset_n);
    endtask
    
    task ddr_monitor::command_select();
      if(vif.ddr_mon_cb.cke == 1) begin
          if(vif.ddr_mon_cb.cs_n == 0) begin

            case ({vif.ddr_mon_cb.ras_n, vif.ddr_mon_cb.cas_n, vif.ddr_mon_cb.we_n})
              3'b000:begin 
                    req.cmd = MRS;
                    if(req.ba == 2'b00) otf = req.a[1:0]; 
                  end
              3'b001: req.cmd = REF;
              3'b010: req.cmd = req.a[10]? PREA: PRE;
              3'b011: req.cmd = ACT;
              3'b100: req.cmd = req.a[10] ?(otf == 2'b01)?req.a[12]?WRAS8:WRAS4:WRA :(otf == 2'b01)?req.a[12]?WRS8:WRS4:WR;
              3'b101: req.cmd = req.a[10] ?(otf == 2'b01)?req.a[12]?RDAS8:RDAS4:RDA :(otf == 2'b01)?req.a[12]?RDS8:RDS4:RD;
              3'b110: req.cmd = req.a[10] ?ZQCL:ZQCS;
            endcase
          end
          else
              req.cmd = DES;
      end
    endtask

    task ddr_monitor::write_read_data();
      bl = otf == 2'b01 ? 8:4; 
      for(int i=0;i<bl;i++) begin
        req.dq_q.push_back(vif.ddr_mon_cb.dq);
        @(posedge vif.ck_t or posedge vif.ck_c);
      end
    endtask
    task ddr_monitor::trans_command_select();
      if(vif.ddr_mon_cb.cke == 0) begin
        if(vif.ddr_mon_cb.cs_n == 0 && vif.ddr_mon_cb.ras_n == 0 && vif.ddr_mon_cb.cas_n == 0 && vif.ddr_mon_cb.we_n == 1)
          self_refresh();
        if((vif.ddr_mon_cb.cs_n == 0 && vif.ddr_mon_cb.ras_n == 1 && vif.ddr_mon_cb.cas_n == 1 && vif.ddr_mon_cb.we_n == 1) ||vif.ddr_mon_cb.cs_n == 1)
          power_down();
      end
    endtask

    task ddr_monitor::self_refresh();
      req.cmd = SRE;
      wait(vif.ddr_mon_cb.cke == 1) begin
        if((vif.ddr_mon_cb.cs_n == 0 && vif.ddr_mon_cb.ras_n == 1 && vif.ddr_mon_cb.cas_n == 1 && vif.ddr_mon_cb.we_n == 1) ||vif.ddr_mon_cb.cs_n == 1)begin
          req.cmd = SRX;
          disable trans_command_select;
        end
      end
    endtask
 
    task ddr_monitor::power_down();
      req.cmd = PDE;
      wait(vif.ddr_mon_cb.cke == 1) begin
        if((vif.ddr_mon_cb.cs_n == 0 && vif.ddr_mon_cb.ras_n == 1 && vif.ddr_mon_cb.cas_n == 1 && vif.ddr_mon_cb.we_n == 1) ||vif.ddr_mon_cb.cs_n == 1) begin
          req.cmd = PDX;
          disable trans_command_select;
        end
      end
    endtask 
`endif
