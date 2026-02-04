///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_pkg.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// 
// Company: Scaledge Technology Pvt.
// 
// Copyright (c) <Year> Scaledge Technology Pvt. All rights reserved.
// 
// This file is part of the project.
// Description: DDR TB package that aggregates all UVM components, sequences, sequence items,
//              configuration objects, and related definitions required for DDR protocol verification.
// Dependencies:
// Notes:
//////////////////////////////////////////////////////////////////////////////////
`include "ddr_defines.sv"
`include "ddr_interface.sv"
`include "ddr_assertions.sv"

package ddr_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "ddr_defines.sv"

`include "ddr_seq_item.sv"
`include "ddr_config.sv"
`include "ddr_checker.sv"
`include "ddr_driver.sv"
`include "ddr_monitor.sv"
`include "ddr_sequencer.sv"
`include "ddr_agent.sv"
`include "ddr_wrapper_cov_class.sv"
`include "ddr_coverage_collcetor.sv"
`include "ddr_scoreboard.sv"
`include "ddr_refrence_model.sv"
`include "ddr_env.sv"
`include "ddr_base_sequence.sv"
`include "ddr_base_test.sv"

endpackage
