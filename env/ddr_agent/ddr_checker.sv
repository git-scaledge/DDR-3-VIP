
///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_checker.sv
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
`ifndef DDR_CHECKER_SV
`define DDR_CHECKER_SV

class ddr_checker extends uvm_component;
 
  //////////////////////////////////////////////////////////////////////////
  // UVM Factory registration
  //////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ddr_checker)  

	command_e prev_command, command;
	ddr_config config_h;
  
  //////////////////////////////////////////////////////////////////////////
  // class constructor
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_checker",uvm_component parent=null);  
   
  //////////////////////////////////////////////////////////////////////////
  // function name : build_phase
  // argument      : uvm_phase phase
  // description   : Build phase of DDR checker
  //////////////////////////////////////////////////////////////////////////
  extern function void build_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : connect_phase
  // argument      : uvm_phase phase
  // description   : Connect phase of DDR checker
  //////////////////////////////////////////////////////////////////////////
  extern function void connect_phase(uvm_phase phase);

  //////////////////////////////////////////////////////////////////////////
  // function name : MRS_to_MRS_delay_checker
  // argument      : req
	// description   : Checker for delay between two MRS commands
  //////////////////////////////////////////////////////////////////////////
	extern function void MRS_to_MRS_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : MRS_to_Non_MRS_delay_checker
  // argument      : req
  // description   : Checker for delay between MRS and any valid commands
  //////////////////////////////////////////////////////////////////////////
	extern function void MRS_to_Non_MRS_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : tFAW_delay_checker
  // argument      : req
  // description   : Checker for four activation window delay
  //////////////////////////////////////////////////////////////////////////
	extern function void tFAW_delay_checker(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // function name : read_to_precharge_delay_checker
  // argument      : req
  // description   : Checker for delay between read and precharge commands
  //////////////////////////////////////////////////////////////////////////
	extern function void read_to_precharge_delay_checker(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // function name : precharge_to_activation_delay_checker
  // argument      : req
  // description   : Checker for delay between precharge and activation commands
  //////////////////////////////////////////////////////////////////////////
	extern function void precharge_to_activation_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : same_bank_activation_delay_checker
  // argument      : req
  // description   : Checker for delay between two activation commands for same bank
  //////////////////////////////////////////////////////////////////////////
	extern function void same_bank_activation_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : diff_bank_activation_delay_checker
  // argument      : req
  // description   : Checker for delay between two activation commands for different banks
  //////////////////////////////////////////////////////////////////////////
	extern function void diff_bank_activation_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : command_to_command_delay_checker
  // argument      : req
  // description   : Checker for delay between two commands
  //////////////////////////////////////////////////////////////////////////
	extern function void command_to_command_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : activation_to_command_delay_checker
  // argument      : req
  // description   : Checker for delay between activation command to read/write command
  //////////////////////////////////////////////////////////////////////////
	extern function void activation_to_command_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : active_pd_entry_delay_checker
  // argument      : req
  // description   : Checker for active power down entry delay
  //////////////////////////////////////////////////////////////////////////
	extern function void active_pd_entry_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : refresh_to_pd_entry_delay_checker
  // argument      : req
  // description   : Checker for delay between refresh command and power down entry
  //////////////////////////////////////////////////////////////////////////
	extern function void refresh_to_pd_entry_delay_checker(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // function name : rd_to_pd_entry_delay_checker
  // argument      : req
  // description   : Checker for delay between any read command and power down entry
  //////////////////////////////////////////////////////////////////////////
	extern function void rd_to_pd_entry_delay_checker(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // function name : wr_wra_to_pd_entry_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for delay between any read command and power down entry
  //////////////////////////////////////////////////////////////////////////
	extern function void wr_wra_to_pd_entry_delay_checker(ddr_seq_item req, bit [1:0] mr0_a1_a0);
	
	//////////////////////////////////////////////////////////////////////////
  // function name : mrs_to_pd_entry_delay_checker
  // argument      : req
  // description   : Checker for delay between MRS command and power down entry
  //////////////////////////////////////////////////////////////////////////
	extern function void mrs_to_pd_entry_delay_checker(ddr_seq_item req);

  //////////////////////////////////////////////////////////////////////////
  // function name : precharge_pd_entry_delay_checker
  // argument      : req
  // description   : Checker for precharge power down entry delay
  //////////////////////////////////////////////////////////////////////////
	extern function void precharge_pd_entry_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : active_pd_exit_delay_checker
  // argument      : req, dll_on_off pin
  // description   : Checker for power down exit delay
  //////////////////////////////////////////////////////////////////////////
	extern function void active_pd_exit_delay_checker(ddr_seq_item req, bit dll_on_off);

	//////////////////////////////////////////////////////////////////////////
  // function name : precharge_pd_exit_delay_checker
  // argument      : req, dll_on_off pin
  // description   : Checker for precharge power down exit delay
  //////////////////////////////////////////////////////////////////////////
	extern function void precharge_pd_exit_delay_checker(ddr_seq_item req, bit dll_on_off);

	//////////////////////////////////////////////////////////////////////////
  // function name : reset_n_timing_cke_initialization_checker
  // argument      : reset_n, cke
  // description   : Checker for reset initialization and cke initialization sequence 
	//////////////////////////////////////////////////////////////////////////
	extern function void reset_n_timing_cke_initialization_checker(input logic reset_n, input logic cke); //TODO

	//////////////////////////////////////////////////////////////////////////
  // function name : write_command_to_first_data_delay_checker
  // argument      : req, dq
  // description   : Checker for  write command to first data
	//////////////////////////////////////////////////////////////////////////
	extern function void write_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

	//////////////////////////////////////////////////////////////////////////
  // function name : read_command_to_first_data_delay_checker
  // argument      : req, dq
  // description   : Checker for read command to first data
	//////////////////////////////////////////////////////////////////////////
	extern function void read_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

  //////////////////////////////////////////////////////////////////////////
  // function name : internal_write_command_to_first_data_delay_checker
  // argument      : req, dq
  // description   : Checker for internal write command to first data
	//////////////////////////////////////////////////////////////////////////
	extern function void internal_write_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

	//////////////////////////////////////////////////////////////////////////
  // function name : internal_read_command_to_first_data_delay_checker
  // argument      : req, dq
  // description   : Checker for internal read command to first data
	//////////////////////////////////////////////////////////////////////////
	extern function void internal_read_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

	//////////////////////////////////////////////////////////////////////////
  // function name : read_command_to_write_command_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for read command to write command delay
	//////////////////////////////////////////////////////////////////////////
	extern function void read_command_to_write_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0);
	//////////////////////////////////////////////////////////////////////////
  // function name : write_command_to_read_command_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for write command to read command delay
	//////////////////////////////////////////////////////////////////////////
	extern function void write_command_to_read_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0, input logic [`MEM_DQ_WIDTH-1:0] dq);

	//////////////////////////////////////////////////////////////////////////
  // function name : write_command_to_precharge_command_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for write command to precharge command delay
	//////////////////////////////////////////////////////////////////////////
	extern function void write_command_to_precharge_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0, input logic [`MEM_DQ_WIDTH-1:0] dq);

	//////////////////////////////////////////////////////////////////////////
  // function name : ref_to_any_command_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for ref command to any command delay
	//////////////////////////////////////////////////////////////////////////
	extern function void ref_to_any_command_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : ref_to_any_command_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for ref command to ref command delay
	//////////////////////////////////////////////////////////////////////////
	extern function void ref_to_ref_command_delay_checker(ddr_seq_item req);

	//////////////////////////////////////////////////////////////////////////
  // function name : self_refresh_exit_delay_checker
  // argument      : req, mr0[1:0]
  // description   : Checker for self refresh exit delay
	//////////////////////////////////////////////////////////////////////////
	extern function void self_refresh_exit_delay_checker(ddr_seq_item req,bit dll_on_off);

endclass
    
function ddr_checker::new(string name ="ddr_checker",uvm_component parent=null);
  super.new(name,parent);
endfunction
    
function void ddr_checker::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
	if(!uvm_config_db#(ddr_config)::get(this, "", "ddr_config_h", config_h))
	  `uvm_error(get_type_name(),$sformatf("Failed to get config class in checker class!"))
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction
      
function void ddr_checker::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of connect phase....", UVM_LOW)
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "ending of connect phase....", UVM_LOW)
endfunction

function void ddr_checker::MRS_to_MRS_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit mrs_flag;

  if(req.cmd == MRS || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == MRS) begin
	    current_time = $time;
	    if(mrs_flag == 1'b1) begin
		    if((current_time - prev_time) != config_h.tmrd * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[MRS TO MRS DELAY CHECKER] tMRD is %0d instead of %0d",(current_time - prev_time),config_h.tmrd * `TIMEPERIOD))
		  end
	    prev_time = $time;
	    mrs_flag = 1'b1;
		end
	end
	else
	   mrs_flag = 1'b0;

endfunction

function void ddr_checker::MRS_to_Non_MRS_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit mrs_flag;

  if(req.cmd == MRS || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == MRS) begin
	    prev_time = $time;
	    mrs_flag = 1'b1;
		end
	end
	else if(mrs_flag == 1'b1) begin
	  current_time = $time;
		if((current_time - prev_time) != config_h.tmod * `TIMEPERIOD)
			`uvm_error(get_type_name(),$sformatf("[MRS TO NON MRS DELAY CHECKER] tMOD is %0d instead of %0d",(current_time - prev_time),config_h.tmod * `TIMEPERIOD))
		mrs_flag = 1'b0;
	end

endfunction

function void ddr_checker::tFAW_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static int act_count;

	if(req.cmd == ACT) begin
	  current_time = $time;
	  if(req.cmd == ACT && act_count == 4) begin
	   if((current_time - prev_time) < config_h.tfaw * `TIMEPERIOD)
	    `uvm_error(get_type_name(),$sformatf("[FOUR ACTIVATION WINDOW DELAY CHECKER] tFAW is %0d instead of %0d",(current_time - prev_time),config_h.tfaw * `TIMEPERIOD))
	   act_count = 0;
	  return;
	 end
	  if(act_count == 1'b0)
	    prev_time = $time;
	  act_count++;
  end
endfunction

function void ddr_checker::read_to_precharge_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit rd_flag;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == DES || req.cmd == NOP) begin
  	if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8) begin
			rd_flag = 1'b1;
	  	prev_time = $time;
		end
	end
	else if(req.cmd == PRE && rd_flag == 1'b1) begin
	  current_time = $time;
		if((current_time - prev_time) != config_h.trtp * `TIMEPERIOD)
			`uvm_error(get_type_name(),$sformatf("[READ TO PRECHARGE DELAY CHECKER] tRTP is %0d instead of %0d",(current_time - prev_time),config_h.trtp * `TIMEPERIOD))
	  rd_flag = 1'b0;
	end
endfunction

function void ddr_checker::precharge_to_activation_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit pre_flag;

  if(req.cmd == PRE || req.cmd == PREA || req.cmd == DES || req.cmd == NOP) begin
    if(req.cmd == PRE || req.cmd == PREA) begin
	    pre_flag = 1'b1; 
	    prev_time = $time;
	  end
	end
	else if(req.cmd == ACT &&  pre_flag == 1'b1) begin
	  current_time = $time;
		if((current_time - prev_time) != config_h.trp * `TIMEPERIOD)
			`uvm_error(get_type_name(),$sformatf("[PRECHARGE TO ACTIVATION DELAY CHECKER] tRP is %0d instead of %0d",(current_time - prev_time),config_h.trp * `TIMEPERIOD))
		pre_flag = 1'b0;
		end
endfunction

function void ddr_checker::same_bank_activation_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static logic[`MEM_BA_WIDTH-1:0] prev_ba, current_ba;

  if(req.cmd == ACT) begin
	  current_time = $time;
		current_ba = req.ba;
	  if(req.cmd == ACT && (prev_ba == current_ba)) begin
		  if((current_time - prev_time) != config_h.trc * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[ACTIVATION TO ACTIVATION FOR SAME BANK DELAY CHECKER] tRC is %0d instead of %0d",(current_time - prev_time),config_h.trc * `TIMEPERIOD))
		end
	  prev_time = $time;
	  prev_ba = req.ba;
	end
endfunction

function void ddr_checker::diff_bank_activation_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static logic[`MEM_BA_WIDTH-1:0] prev_ba, current_ba;
static bit diff_act_flag;

  if(req.cmd == ACT || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == ACT) begin
	    current_time = $time;
		  current_ba = req.ba;
		  if((prev_ba != current_ba) && diff_act_flag == 1'b1) begin
		    if((current_time - prev_time) != config_h.trrd * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[ACTIVATION TO ACTIVATION FOR DIFF BANK DELAY CHECKER] tRRD is %0d instead of %0d",(current_time - prev_time),config_h.trrd * `TIMEPERIOD))
		  end
		end
		diff_act_flag = 1'b1;
	  prev_time = $time;
	  prev_ba = req.ba;
	end
	else
		diff_act_flag = 1'b0;
endfunction

function void ddr_checker::command_to_command_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit command_flag;

  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8 || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8) begin
	    current_time = $time;
		  if(command_flag == 1'b1) begin
		    if((current_time - prev_time) != config_h.tccd * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO WRITE COMMAND DELAY CHECKER] tCCD is %0d instead of %0d",(current_time - prev_time),config_h.tccd * `TIMEPERIOD))
		  end
	  	command_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else
	  command_flag = 1'b0;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8 || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8) begin
	    current_time = $time;
		  if(command_flag == 1'b1) begin
		    if((current_time - prev_time) != config_h.tccd * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[READ COMMAND TO READ COMMAND DELAY CHECKER] tCCD is %0d instead of %0d",(current_time - prev_time),config_h.tccd * `TIMEPERIOD))
		  end
	  	command_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else
	  command_flag = 1'b0;
	  
endfunction

function void ddr_checker::activation_to_command_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit act_flag;

  if(req.cmd == ACT || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == ACT) begin
		  act_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if((req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8 || req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8) && act_flag == 1'b1) begin
	    current_time = $time;
		    if((current_time - prev_time) != config_h.trcd * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[ACTIVATION COMMAND TO WRITE/READ COMMAND DELAY CHECKER] tRCD is %0d instead of %0d",(current_time - prev_time),config_h.trcd * `TIMEPERIOD))
	  		act_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::active_pd_entry_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit act_pd_flag;

  if(req.cmd == ACT || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == ACT) begin
		  act_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && act_pd_flag == 1'b1) begin
	    current_time = $time;
		  if((current_time - prev_time) != config_h.tactpden * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[ACTIVATION COMMAND TO POWER DOWN ENTRY DELAY CHECKER] tACTPDEN is %0d instead of %0d",(current_time - prev_time),config_h.tactpden * `TIMEPERIOD))
	  	act_pd_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::refresh_to_pd_entry_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit ref_pd_flag;

  if(req.cmd == REF || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == REF) begin
		  ref_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && ref_pd_flag == 1'b1) begin
	    current_time = $time;
		  if((current_time - prev_time) != config_h.trefpden * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[REFRESH COMMAND TO POWER DOWN ENTRY DELAY CHECKER] tREFPDEN is %0d instead of %0d",(current_time - prev_time),config_h.trefpden * `TIMEPERIOD))
	  	ref_pd_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::wr_wra_to_pd_entry_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0);

static time current_time, prev_time;
static bit wr_pd_flag;

  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8) begin
		  wr_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && wr_pd_flag == 1'b1) begin
	    current_time = $time;
      if(mr0_a1_a0 == 2'b10) begin
		    if((current_time - prev_time) != config_h.wrpden_bc4_mrs * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[REFRESH COMMAND TO POWER DOWN ENTRY DELAY CHECKER] wrpden_bc4_mrs is %0d instead of %0d",(current_time - prev_time),config_h.wrpden_bc4_mrs * `TIMEPERIOD))
      end
      else begin
        if((current_time - prev_time) != config_h.wrpden_bl8otf_bl8mrs_bc4_otf * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[REFRESH COMMAND TO POWER DOWN ENTRY DELAY CHECKER] wrpden_bl8otf_bl8mrs_bc4_otf is %0d instead of %0d",(current_time - prev_time),config_h.wrpden_bl8otf_bl8mrs_bc4_otf * `TIMEPERIOD)) 
      end 
	  	wr_pd_flag = 1'b0;
	end

// for write with auto precharge to powerdown	
  if(req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8 || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8) begin
		  wr_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && wr_pd_flag == 1'b1) begin
	    current_time = $time;
      if(mr0_a1_a0 == 2'b10) begin
		    if((current_time - prev_time) != config_h.wrapden_bc4_mrs * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[REFRESH COMMAND TO POWER DOWN ENTRY DELAY CHECKER] wrapden_bc4_mrs is %0d instead of %0d",(current_time - prev_time),config_h.wrapden_bc4_mrs * `TIMEPERIOD))
      end
      else begin
        if((current_time - prev_time) != config_h.wrapden_bl8otf_bl8mrs_bc4_otf * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[REFRESH COMMAND TO POWER DOWN ENTRY DELAY CHECKER] wrapden_bl8otf_bl8mrs_bc4_otf is %0d instead of %0d",(current_time - prev_time),config_h.wrapden_bl8otf_bl8mrs_bc4_otf * `TIMEPERIOD)) 
      end 
	  	wr_pd_flag = 1'b0;
	end
		    
endfunction

function void ddr_checker::rd_to_pd_entry_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit rd_pd_flag;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8 || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8) begin
		  rd_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && rd_pd_flag == 1'b1) begin
	    current_time = $time;
		  if((current_time - prev_time) != config_h.trdpden * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[READ/READ_A COMMAND TO POWER DOWN ENTRY DELAY CHECKER] tRDPDEN is %0d instead of %0d",(current_time - prev_time),config_h.trdpden * `TIMEPERIOD))
	  	rd_pd_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::mrs_to_pd_entry_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit mrs_pd_flag;

  if(req.cmd == MRS || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == MRS) begin
		  mrs_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && mrs_pd_flag == 1'b1) begin
	    current_time = $time;
		  if((current_time - prev_time) != config_h.tmrspden * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[MRS COMMAND TO POWER DOWN ENTRY DELAY CHECKER] tMRSPDEN is %0d instead of %0d",(current_time - prev_time),config_h.tmrspden * `TIMEPERIOD))
	  	mrs_pd_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::precharge_pd_entry_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit pre_pd_flag;

  if(req.cmd == PRE || req.cmd == PREA || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == PRE || req.cmd == PREA) begin
		  pre_pd_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == PDE && pre_pd_flag == 1'b1) begin
	    current_time = $time;
		  if((current_time - prev_time) != config_h.tprepden * `TIMEPERIOD)
			  `uvm_error(get_type_name(),$sformatf("[PRECHARGE COMMAND TO POWER DOWN ENTRY DELAY CHECKER] tPREPDEN is %0d instead of %0d",(current_time - prev_time),config_h.tprepden * `TIMEPERIOD))
	  	pre_pd_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::active_pd_exit_delay_checker(ddr_seq_item req, bit dll_on_off);

static time current_time, prev_time;
static bit pdx_flag;

  if(req.cmd == PDX || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == PDX) begin
		  pdx_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == ACT && pdx_flag == 1'b1) begin
	    current_time = $time;
			if(dll_on_off) begin
		    if((current_time - prev_time) != config_h.txpdll * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[ACTIVE POWER DOWN EXIT DELAY CHECKER] tXPDLL is %0d instead of %0d",(current_time - prev_time),config_h.txpdll * `TIMEPERIOD))
			end
			else begin
		    if((current_time - prev_time) != config_h.txp * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[ACTIVE POWER DOWN EXIT DELAY CHECKER] tXP is %0d instead of %0d",(current_time - prev_time),config_h.txp * `TIMEPERIOD))
			end
	    pdx_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::precharge_pd_exit_delay_checker(ddr_seq_item req, bit dll_on_off);

static time current_time, prev_time;
static bit pre_pdx_flag;

  if(req.cmd == PDX || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == PDX) begin
		  pre_pdx_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(req.cmd == ACT || req.cmd == SRE || req.cmd == REF || req.cmd == MRS || req.cmd == PDE || req.cmd == ZQCL || req.cmd == ZQCS && pre_pdx_flag == 1'b1) begin
	    current_time = $time;
			if(dll_on_off) begin
		    if((current_time - prev_time) != config_h.txpdll * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[PRECHARGE POWER DOWN EXIT DELAY CHECKER] tXPDLL is %0d instead of %0d",(current_time - prev_time),config_h.txpdll * `TIMEPERIOD))
			end
			else begin
		    if((current_time - prev_time) != config_h.txp * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[PRECHARGE POWER DOWN EXIT DELAY CHECKER] tXP is %0d instead of %0d",(current_time - prev_time),config_h.txp * `TIMEPERIOD))
			end
	    pre_pdx_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::reset_n_timing_cke_initialization_checker(input logic reset_n, input logic cke);

static realtime rst_assert_t, rst_deassert_t, cke_low_t, cke_high_t;
static bit prev_rst, prev_cke;

	if((reset_n ^ prev_rst) == 1)
    if(reset_n == 0)
		  rst_assert_t = $realtime;
		else begin
		  rst_deassert_t = $realtime;
		  if((rst_deassert_t - rst_assert_t) < 200us)
			  `uvm_error(get_type_name(),$sformatf("[RESET_n TIMING CHECKER] reset_n must remain asserted at least for 200us"))
		end

	if(($realtime >= (rst_assert_t + 199.99us)) && ($realtime <= (500us + rst_deassert_t)))
		if(cke != 0)
			`uvm_error(get_type_name(),$sformatf("[CKE DEASSERTION CHECKER] cke must be low for 10ns before reset_n deassert"))
		else if((cke ^ prev_cke) == 1)
			return;
		else if((cke | prev_cke) == 0) begin
			if($realtime == (500us + rst_deassert_t))
				return;
		end
	  else
		  `uvm_error(get_type_name(),$sformatf("[CKE INITIALIZATION CHECKER] After reset deassertion, cke must be asserted only after 500us"))
  prev_rst = reset_n;
  prev_cke = cke;	
	  
endfunction
// TODO: two different delays for reset during ramping mode and satble mode

function void ddr_checker::write_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time;
static bit wrt_flag;

  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8 || req.cmd == NOP || req.cmd == DES) begin
    if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8) begin
      wrt_flag = 1'b1;
      prev_time = $time;
    end
  end
	if(((dq != 'bz) || (dq != 'bx)) && wrt_flag == 1'b1) begin
   current_time = $time;
	 if((current_time - prev_time) != config_h.twl * `TIMEPERIOD)
	  `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO FIRST DATA DELAY CHECKER] twl is %0d instead of %0d",(current_time - prev_time),config_h.twl * `TIMEPERIOD))
	 if(((current_time - prev_time) - (config_h.tcwl * `TIMEPERIOD)) != config_h.tal * `TIMEPERIOD)
	   if((config_h.tcwl * 2) - config_h.twl != 1 || (config_h.tcwl * 2) - config_h.twl != 2)
	     `uvm_error(get_type_name(),$sformatf("[ADDITIVE LATENCY DELAY CHECKER] tal is %0d instead of %0d",((config_h.tcwl * 2) - config_h.twl),config_h.tal * `TIMEPERIOD))
   	 wrt_flag = 1'b0;  
  end
	  
endfunction

function void ddr_checker::read_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time;
static bit rd_flag;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8 || req.cmd == NOP || req.cmd == DES) begin
    if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8) begin
      rd_flag = 1'b1;
      prev_time = $time;
    end
  end
	if(((dq != 'bz) || (dq != 'bx)) && rd_flag == 1'b1) begin
   current_time = $time;
	 if((current_time - prev_time) != config_h.trl * `TIMEPERIOD)
	  `uvm_error(get_type_name(),$sformatf("[READ COMMAND TO FIRST DATA DELAY CHECKER] trl is %0d instead of %0d",(current_time - prev_time),config_h.trl * `TIMEPERIOD))
	 if(((current_time - prev_time) - (config_h.tcl * `TIMEPERIOD)) != config_h.tal * `TIMEPERIOD)
	   if((config_h.tcl * 2) - config_h.twl != 1 || (config_h.tcl * 2) - config_h.twl != 2)
	     `uvm_error(get_type_name(),$sformatf("[ADDITIVE LATENCY DELAY CHECKER] tal is %0d instead of %0d",((config_h.tcl * 2) - config_h.twl),config_h.tal * `TIMEPERIOD))
   rd_flag = 1'b0;  
  end
	  
endfunction

function void ddr_checker::internal_write_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time, intr_cmd_time;
static bit intr_wrt_flag;

  if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8 || req.cmd == NOP || req.cmd == DES) begin
    if(req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8 || req.cmd == WRA || req.cmd == WRAS4 || req.cmd == WRAS8) begin
		  intr_cmd_time = $time;
		end
		if($time == intr_cmd_time + config_h.tal * `TIMEPERIOD) begin
      intr_wrt_flag = 1'b1;
      prev_time = $time;
    end
  end
	if(((dq != 'bz) || (dq != 'bx)) && intr_wrt_flag == 1'b1) begin
   current_time = $time;
	 if((current_time - prev_time) != config_h.tcwl * `TIMEPERIOD)
	  `uvm_error(get_type_name(),$sformatf("[INTERNAL WRITE COMMAND TO FIRST DATA DELAY CHECKER] tcwl is %0d instead of %0d",(current_time - prev_time),config_h.tcwl * `TIMEPERIOD))
    intr_wrt_flag = 1'b0;  
  end
	  
endfunction

function void ddr_checker::internal_read_command_to_first_data_delay_checker(ddr_seq_item req, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time, intr_cmd_time;
static bit intr_rd_flag;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8 || req.cmd == NOP || req.cmd == DES) begin
    if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == RDA || req.cmd == RDAS4 || req.cmd == RDAS8) begin
		  intr_cmd_time = $time;
		end
		if($time == intr_cmd_time + config_h.tal * `TIMEPERIOD) begin
      intr_rd_flag = 1'b1;
      prev_time = $time;
    end
  end
	if(((dq != 'bz) || (dq != 'bx)) && intr_rd_flag == 1'b1) begin
   current_time = $time;
	 if((current_time - prev_time) != config_h.tcl * `TIMEPERIOD)
	  `uvm_error(get_type_name(),$sformatf("[INTERNAL READ COMMAND TO FIRST DATA DELAY CHECKER] tcl is %0d instead of %0d",(current_time - prev_time),config_h.tcl * `TIMEPERIOD))
    intr_rd_flag = 1'b0;  
  end
	  
endfunction

function void ddr_checker::read_command_to_write_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0);

static time current_time, prev_time;
static bit rdt_flag;

  if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8 || req.cmd == NOP || req.cmd == DES) begin
    if(req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8) begin
		  prev_time = $time;
			rdt_flag = 1'b1;
		end
	end
  if((req.cmd == WR || req.cmd == WRS4 || req.cmd == WRS8) && rdt_flag == 1'b1) begin
	  current_time = $time;
	 if(mr0_a1_a0 == 2'b10) begin
	   if((current_time - prev_time) != (config_h.trl + (config_h.tccd)/2 + 2 - config_h.twl) * `TIMEPERIOD)
	    `uvm_error(get_type_name(),$sformatf("[READ COMMAND TO WRITE COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time),(config_h.trl + (config_h.tccd)/2 + 2 - config_h.twl) * `TIMEPERIOD))
      end
     else begin
       if((current_time - prev_time) != (config_h.trl + config_h.tccd + 2 - config_h.twl) * `TIMEPERIOD)
	       `uvm_error(get_type_name(),$sformatf("[READ COMMAND TO WRITE COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time),(config_h.trl + config_h.tccd + 2 - config_h.twl) * `TIMEPERIOD)) 
     end
	 	 rdt_flag = 1'b0;
	end
	  
endfunction

function void ddr_checker::write_command_to_read_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time;
static bit wtr_flag;

  
  if(((dq != 'bz) || (dq != 'bx))) begin
		  prev_time = $time;
			wtr_flag = 1'b1;
	end
    if((req.cmd == RD || req.cmd == RDS4 || req.cmd == RDS8) && wtr_flag == 1'b1) begin
		  current_time = $time;
		  if(mr0_a1_a0 == 2'b10) begin
		    if((current_time - prev_time) -2 != (config_h.twtr) * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO READ COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time)-2,config_h.twtr * `TIMEPERIOD))

      end
      else begin
        if((current_time - prev_time)-4 != (config_h.twtr) * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO READ COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time)-4,config_h.twtr * `TIMEPERIOD)) 
      end
      wtr_flag = 1'b0;
		end
	  
endfunction

function void ddr_checker::write_command_to_precharge_command_delay_checker(ddr_seq_item req,bit [1:0] mr0_a1_a0, input logic [`MEM_DQ_WIDTH-1:0] dq);

static time current_time, prev_time;
static bit wp_flag;

  
  if(((dq != 'bz) || (dq != 'bx))) begin
		  prev_time = $time;
			wp_flag = 1'b1;
	end
    if(req.cmd == PRE && wp_flag == 1'b1) begin
		  current_time = $time;
		  if(mr0_a1_a0 == 2'b10) begin
		    if((current_time - prev_time) -2 != (config_h.twr) * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO PRECHARGE COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time)-2,config_h.twr * `TIMEPERIOD))
      end
      else begin
        if((current_time - prev_time)-4 != (config_h.twr) * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[WRITE COMMAND TO PRECHARGE COMMAND DELAY CHECKER] delay is %0d instead of %0d",(current_time - prev_time)-4,config_h.twr * `TIMEPERIOD)) 
      end
      wp_flag = 1'b0;
		end
	  
endfunction

function void ddr_checker::ref_to_any_command_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit ref_flag;

  if(req.cmd == REF || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == REF) begin
	    prev_time = $time;
	    ref_flag = 1'b1;
		end
	end
	else if(ref_flag == 1'b1) begin
	  current_time = $time;
		if((current_time - prev_time) != config_h.trfc * `TIMEPERIOD)
			`uvm_error(get_type_name(),$sformatf("[REFRESH TO ANY COMMAND DELAY CHECKER] tMOD is %0d instead of %0d",(current_time - prev_time),config_h.trfc * `TIMEPERIOD))
		ref_flag = 1'b0;
	end

endfunction

function void ddr_checker::ref_to_ref_command_delay_checker(ddr_seq_item req);

static time current_time, prev_time;
static bit refi_flag;

  if(req.cmd == MRS || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == MRS) begin
	    current_time = $time;
	    if(refi_flag == 1'b1) begin
		    if((current_time - prev_time) != config_h.trefi * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[REFRESH TO REFRESH DELAY CHECKER] tMRD is %0d instead of %0d",(current_time - prev_time),config_h.trefi * `TIMEPERIOD))
		  end
	    prev_time = $time;
	    refi_flag = 1'b1;
		end
	end
	else
	   refi_flag = 1'b0;

endfunction

function void ddr_checker::self_refresh_exit_delay_checker(ddr_seq_item req, bit dll_on_off);

static time current_time, prev_time;
static bit sre_flag;

  if(req.cmd == PDX || req.cmd == DES || req.cmd == NOP) begin
	  if(req.cmd == PDX) begin
		  sre_flag = 1'b1;
	  	prev_time = $time;
	  end
	end
	else if(sre_flag == 1'b1) begin
	    current_time = $time;
			if(dll_on_off) begin
		    if((current_time - prev_time) != config_h.txsdll * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("[SELF REFRESH EXIT DELAY CHECKER] tXPDLL is %0d instead of %0d",(current_time - prev_time),config_h.txsdll * `TIMEPERIOD))
			end
			else begin
		    if((current_time - prev_time) != config_h.txs * `TIMEPERIOD)
			    `uvm_error(get_type_name(),$sformatf("SELF REFRESH EXIT DELAY CHECKER] tXP is %0d instead of %0d",(current_time - prev_time),config_h.txs * `TIMEPERIOD))
			end
	    sre_flag = 1'b0;
	end
	  
endfunction
`endif
