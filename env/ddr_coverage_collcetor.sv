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
  
  virtual ddr_interface vif;
  ddr_wrapper_cov_class cov;

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

  if(!uvm_config_db #(virtual ddr_interface)::get(this,"","vif",vif))
    `uvm_error(get_type_name(),"can not able to get inteface in coverage class")

  cov = new(vif);
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction

function void ddr_coverage_collector::write(ddr_seq_item req);
  cov.DDR_FOUR_ACTIVATION_CG.sample(req);
  cov.DDR_ACTIVATION_CG.sample(req);
  cov.DDR_PRECHARGE_CG.sample(req);
  cov.DDR_WRITE_CG.sample(req);
  cov.DDR_READ_CG.sample(req);
  cov.DDR_DES_CG.sample(req);
  cov.DDR_NOP_CG.sample(req);
  cov.DDR_MRS_CG.sample(req);
  cov.DDR_POWERDOWN_CG.sample(req);
  cov.DDR_REFRESH_CG.sample(req);
  cov.DDR_SELF_REFRESH_CG.sample(req);
  cov.DDR_ZQCALIBRATION_CG.sample(req);
  cov.DDR_REFRESH_CG.sample(req);
  cov.DDR_MRS_CG.sample(req);
  cov.DDR_SELF_REFRESH_CG.sample(req);
  cov.DDR_TRANSACTION_TO_IDLE_CG.sample(req);
  cov.DDR_TRANSACTION_TO_ACT_CG.sample(req);
  cov.DDR_TRANSACTION_TO_WR_WRA_CG.sample(req);
  cov.DDR_TRANSACTION_TO_RD_RDA_CG.sample(req);
  cov.DDR_TRANSACTION_TO_MRS_CG.sample(req);
  cov.DDR_TRANSACTION_TO_SELF_REFRESH_CG.sample(req);
  cov.DDR_TRANSACTION_TO_REFRESH_CG.sample(req);
  cov.DDR_TRANSACTION_TO_POWERDOWN_CG.sample(req);
endfunction
    
`endif
