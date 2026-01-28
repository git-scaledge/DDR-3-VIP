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
  ddr_config ddr_config_h;
  
  // To store the temporary previous command
  command_e prev_cmd = NOP;

  
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
  
  // send_to_dut task:
  // Drives a single DDR transaction onto the DUT interface
  // based on the received sequence item
  extern task send_to_dut(ddr_seq_item req);

  // mode_register_set task: 
  // Drives a single DDR transaction onto the DUT interface
  // based on the received sequence item
  extern task mode_register_set( bit [`MEM_BA_WIDTH-1:0] ba,bit [`MEM_ROW_WIDTH-1:0] a);

  // mode_register_set task: 
  // Drives a single DDR transaction onto the DUT interface
  // based on the received sequence item
  extern task drive_cmd(bit cs_n,bit ras_n,bit cas_n,bit we_n,bit[`MEM_BA_WIDTH-1:0] ba,bit[`MEM_ROW_WIDTH-1:0] a);
  extern task wait_for_reset_assert();
  extern task wait_for_reset_deassert();
  extern task command(ddr_seq_item req);
  extern task reset_Initialization();

  bit [`MEM_ROW_WIDTH-1:0] MR0;
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

      if(!uvm_config_db#(ddr_config)::get(this,"","ddr_config_h",ddr_config_h))
      begin    
      `uvm_error(get_full_name()," CAN'T GET DDR CONFIGURATION IN DRIVER ")
      end
    endfunction
        
    function void ddr_driver::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    endfunction
      
    task ddr_driver::run_phase(uvm_phase phase);
      reset_Initialization();
      forever begin
        fork
          begin
            drive();
          end
          begin
            wait_for_reset_assert();
          end
        join_any
        wait_for_reset_deassert();
      end
    endtask
      
    task ddr_driver::drive();
    forever begin
      seq_item_port.get_next_item(req);
      $cast(rsp,req.clone());
      send_to_dut(rsp);
      rsp.set_name($sformatf("DRIVER: RECEIVED PKT FROM SEQS", $time));
      rsp.print();
      seq_item_port.item_done();
    end
    endtask 

   
   task ddr_driver::wait_for_reset_deassert();
     wait(vif.reset_n);
   endtask

   task ddr_driver::wait_for_reset_assert();
     @(negedge vif.reset_n);
     reset_Initialization();
     seq_item_port.item_done();
   endtask

   task ddr_driver::reset_Initialization();
    wait(vif.reset_n==0);
    #190us;
    vif.cke<=0;
    #10ns;
    wait(vif.reset_n==1);
    #500us;
    vif.cke<=1;
    @(vif.ddr_drv_cb);
    // wait (ddr_config_h.txpr);
    mode_register_set(2,13'b0000000000000);
    mode_register_set(3,13'b0000000000000);
    mode_register_set(1,13'b0000000000001);
    mode_register_set(0,13'b0001000010000);
   endtask

   task ddr_driver::send_to_dut(ddr_seq_item req);
       command(req);
   endtask

   task ddr_driver::mode_register_set( bit [`MEM_BA_WIDTH-1:0] ba,bit [`MEM_ROW_WIDTH-1:0] a);
      @(vif.ddr_drv_cb);
      vif.ddr_drv_cb.ba <= ba;
      vif.ddr_drv_cb.a<=a;
      if(ba == 0) MR0 = a;
   endtask

  task ddr_driver::drive_cmd(bit cs_n,bit ras_n,bit cas_n,bit we_n,bit[`MEM_BA_WIDTH-1:0] ba,bit[`MEM_ROW_WIDTH-1:0] a);
  @(vif.ddr_drv_cb);
  vif.ddr_drv_cb.cs_n  <= cs_n;
  vif.ddr_drv_cb.ras_n <= ras_n;
  vif.ddr_drv_cb.cas_n <= cas_n;
  vif.ddr_drv_cb.we_n  <= we_n;
  vif.ddr_drv_cb.ba    <= ba;
  vif.ddr_drv_cb.a     <= a;
  endtask
  


task ddr_driver::command(ddr_seq_item req);
  case (req.cmd)

    ACT : begin

      //-------------------------------
      // Previous was NOP
      //-------------------------------
      if (prev_cmd == NOP) begin
        drive_cmd(0,0,1,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was ACT (tRRD)
      //-------------------------------
      if (prev_cmd == ACT) begin
        repeat(ddr_config_h.trrd) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was PRE (tRP)
      //-------------------------------
      if (prev_cmd == PRE) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was WRA (tDAL + tWL)
      //-------------------------------
      if (prev_cmd == WRA) begin
        if (MR0[1:0] == 2'b10) begin
          repeat(ddr_config_h.tdal + ddr_config_h.twl + 2) @(vif.ddr_drv_cb);
          drive_cmd(0,0,1,1, req.ba, req.a);
        end
        else begin
          repeat(ddr_config_h.tdal + ddr_config_h.twl + 4) @(vif.ddr_drv_cb);
          drive_cmd(0,0,1,1, req.ba, req.a);
        end
      end

      //-------------------------------
      // Previous was RDA (tRTP / tRP)
      //-------------------------------
      if (prev_cmd == RDA) begin
        if (MR0[1:0] == 2'b01) begin
          repeat(ddr_config_h.trtp + ddr_config_h.trp) @(vif.ddr_drv_cb);
          drive_cmd(0,0,1,1, req.ba, req.a);
        end
        else begin
          repeat(ddr_config_h.tdal + ddr_config_h.trp) @(vif.ddr_drv_cb);
          drive_cmd(0,0,1,1, req.ba, req.a);
        end
      end

      //-------------------------------
      // Previous was PREA (tRP)
      //-------------------------------
     if (prev_cmd == PREA) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end
      //-------------------------------
      // Previous was MRS (tMOD)
      //-------------------------------
     if (prev_cmd == MRS) begin
        repeat(ddr_config_h.tmod) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end
      //-------------------------------
      // Previous was PDX (tactpden)
      //-------------------------------
     if (prev_cmd == PDX) begin
        repeat(ddr_config_h.tactpden) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end
      //-------------------------------
      // Previous was REF (txp)
      //-------------------------------
     if (prev_cmd == REF) begin
        repeat(ddr_config_h.txp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,1,1, req.ba, req.a);
      end

    end // ACT

  WR : begin
      //-------------------------------
      // Previous was ACT (trcd)
      //-------------------------------
      if(prev_cmd == ACT)begin
        repeat(ddr_config_h.trcd) @(vif.ddr_drv_cb);
        begin
        drive_cmd(0,1,0,0, req.ba, req.a);
        
        end

      end
      //-------------------------------
      // Previous was WR (tccd)
      //-------------------------------
     if (prev_cmd == WR) begin
        repeat(ddr_config_h.tccd) @(vif.ddr_drv_cb);
        drive_cmd(0,1,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was RD (trl+tccd+2-wl)
      //-------------------------------
     if (prev_cmd == RD) begin
        if(MR0[1:0]==2'b00)begin
          repeat(ddr_config_h.trl+ddr_config_h.tccd-ddr_config_h.twl+2) @(vif.ddr_drv_cb);
          drive_cmd(0,1,0,0, req.ba, req.a);
          end
          else begin
            repeat(ddr_config_h.trl+(ddr_config_h.tccd/2)-ddr_config_h.twl+2) @(vif.ddr_drv_cb);
            drive_cmd(0,1,0,0, req.ba, req.a);
          end
      end

        repeat(ddr_config_h.twl) @(vif.ddr_drv_cb);
          for(int i =0 ;i<req.dq_q.size()-1;i++)begin
            vif.ddr_drv_cb.dq<=req.dq_q.pop_front();
            @(edge vif.ck_t);
          end
  end//WR

  RD :begin

      //-------------------------------
      // Previous was ACT (trcd)
      //-------------------------------
     if (prev_cmd == ACT) begin
        repeat(ddr_config_h.trcd) @(vif.ddr_drv_cb);
        drive_cmd(0,1,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was WR (twl+twtr)
      //-------------------------------
     if (prev_cmd == WR) begin
        if(MR0[1:0]==2'b00)begin
        repeat(ddr_config_h.twl+ddr_config_h.twtr+4) @(vif.ddr_drv_cb);
        drive_cmd(0,1,0,1, req.ba, req.a);
        end
        else begin
        repeat(ddr_config_h.twl+ddr_config_h.twtr+2) @(vif.ddr_drv_cb);
        drive_cmd(0,1,0,1, req.ba, req.a);
        end
      end

      //-------------------------------
      // Previous was RD (tccd)
      //-------------------------------
     if (prev_cmd == RD) begin
        repeat(ddr_config_h.tccd) @(vif.ddr_drv_cb);
        drive_cmd(0,1,0,1, req.ba, req.a);
      end

  end//RD

  MRS :begin

      //-------------------------------
      // Previous was MRS (tmrd)
      //-------------------------------
     if (prev_cmd == MRS) begin
        repeat(ddr_config_h.tmrd) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was PRE (tRP)
      //-------------------------------
     if (prev_cmd ==PRE) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was PREA (tRP)
      //-------------------------------
     if (prev_cmd ==PREA) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was REF (tRFC)
      //-------------------------------
     if (prev_cmd == REF) begin
        repeat(ddr_config_h.trfc) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was ZQCL (tzqinit
      //-------------------------------
     if (prev_cmd == ZQCL) begin
        repeat(ddr_config_h.tzqinit) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      //-------------------------------
      // Previous was SRX (txs)
      //-------------------------------
     if (prev_cmd == SRX) begin
        repeat(ddr_config_h.txs) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,0, req.ba, req.a);
      end

      end//MRS

  REF :begin

      //-------------------------------
      // Previous was PRE/PREA (tRP)
      //-------------------------------
     if (prev_cmd == (PRE||PREA)) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was REF (tRFC)
      //-------------------------------
     if (prev_cmd == REF) begin
        repeat(ddr_config_h.trfc) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was MRS (tMRD)
      //-------------------------------
     if (prev_cmd == MRS) begin
        repeat(ddr_config_h.tmrd) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was ZQCL (tzqinit)
      //-------------------------------
     if (prev_cmd == ZQCL) begin
        repeat(ddr_config_h.tzqinit) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was SRX (tXS)
      //-------------------------------
     if (prev_cmd == SRX) begin
        repeat(ddr_config_h.txs) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was PDX (tXP)
      //-------------------------------
     if (prev_cmd == PDX) begin
        repeat(ddr_config_h.txp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end


      end//REF

  SRX :begin

      //-------------------------------
      // Previous was SRE (tCKESR)
      //-------------------------------
     if (prev_cmd == SRE) begin
        repeat(ddr_config_h.tckesr) @(vif.ddr_drv_cb);
        drive_cmd(0,1,1,1, req.ba, req.a);
      end

      end//SRX

  SRE :begin

      //-------------------------------
      // Previous was (PRE/PREA) (tRP)
      //-------------------------------
     if (prev_cmd == (PRE||PREA)) begin
        repeat(ddr_config_h.trp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was REF (tRFC)
      //-------------------------------
     if (prev_cmd == REF) begin
        repeat(ddr_config_h.trfc) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was MRS (tMRD)
      //-------------------------------
     if (prev_cmd == MRS) begin
        repeat(ddr_config_h.tmrd) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      //-------------------------------
      // Previous was PDX (tXP)
      //-------------------------------
     if (prev_cmd == PDX) begin
        repeat(ddr_config_h.txp) @(vif.ddr_drv_cb);
        drive_cmd(0,0,0,1, req.ba, req.a);
      end

      end//SRE

  PDX :begin

      //-------------------------------
      // Previous was PDE (tPD)
      //-------------------------------
     if (prev_cmd == PDE) begin
        repeat(ddr_config_h.tpd) @(vif.ddr_drv_cb);
        drive_cmd(1,'bx,'bx,'bx, req.ba, req.a);
      end

      end
  endcase

  prev_cmd = req.cmd;

endtask

`endif

