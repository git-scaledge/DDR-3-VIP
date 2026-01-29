//////////////////////////////////////////////////////////////////////////
// Filename: ddr_assertion.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// Company: Scaledge Technology Pvt.
// Copyright (c) 2025 Scaledge Technology Pvt. All rights reserved.
// This file is part of the DDR project.
//
// Description:
//   This module contains SystemVerilog Assertions (SVA) for DDR timing checks
//   related to DQS, DQ, and CK signals as per DDR timing specifications.
//
// Notes:
//   Each assertion checks a specific DDR timing parameter such as DQSCK,
//   DQSS, DQSQ, QH, QSH, QSL, DSS, and DSH.
//   All assertions are written at interface level for protocol compliance.
//
// Dependencies:
//   ddr_interface
//
//////////////////////////////////////////////////////////////////////////

`ifndef DDR_ASSERTION_SV
`define DDR_ASSERTION_SV

module ddr_assertion(ddr_interface inf);

  //--------------------------------------------------------------------------
  // dqsck_assertion
  // Description:
  //   Checks that DQSCK / DQSS timing lies between DQSCKmin and DQSCKmax.
  //   Measures the timing difference between the rising edge of DQS_t
  //   and the falling edge of CK_c.
  //--------------------------------------------------------------------------

property dqsck_assertion;
  realtime dqs_pos;
  @(posedge inf.ck_t)
  ($rose(inf.dqs_t), dqs_pos = $realtime) |-> 
    @(negedge inf.ck_c)
      ((($realtime - (`TIMEPERIOD/2) - dqs_pos) >= -400ps) &&
       (($realtime - (`TIMEPERIOD/2) - dqs_pos) <= 400ps));
endproperty

assert property(dqsck_assertion);
cover  property(dqsck_assertion);

  //--------------------------------------------------------------------------
  // qsh_assertion / dqsh_assertion
  // Description:
  //   Checks DQS/DQS# differential output HIGH time.
  //   Measures the time between posedge of DQS_t and posedge of DQS_c.
  //--------------------------------------------------------------------------

property qsh_assertion;
  realtime dqst_pos;
  @(posedge inf.dqs_t)
    (1, dqst_pos = $realtime) |-> 
      @(posedge inf.dqs_c)
        (($realtime - dqst_pos) == 0.38 * `TIMEPERIOD);
endproperty

assert property(qsh_assertion);
cover  property(qsh_assertion);

  //--------------------------------------------------------------------------
  // qsl_assertion / dqsl_assertion
  // Description:
  //   Checks DQS/DQS# differential output LOW time.
  //   Measures the time between negedge of DQS_t and negedge of DQS_c.
  //--------------------------------------------------------------------------

property qsl_assertion;
  realtime dqst_neg;
  @(negedge inf.dqs_t)
    (1, dqst_neg = $realtime) |-> 
      @(negedge inf.dqs_c)
        (($realtime - dqst_neg) == 0.38 * `TIMEPERIOD);
endproperty

assert property(qsl_assertion);
cover  property(qsl_assertion);

  //--------------------------------------------------------------------------
  // dss_assertion
  // Description:
  //   Checks DSS timing.
  //   Ensures the delay from negedge of DQS_t to posedge of CK_t
  //   meets the specified timing requirement.
  //--------------------------------------------------------------------------

property dss_assertion;
  realtime dqs_neg;
  @(negedge inf.dqs_t)
    (1, dqs_neg = $realtime) |-> 
      @(posedge inf.ck_t)
        (($realtime - dqs_neg) == 0.2 * `TIMEPERIOD);
endproperty

assert property(dss_assertion);
cover  property(dss_assertion);

  //--------------------------------------------------------------------------
  // dsh_assertion
  // Description:
  //   Checks DSH timing.
  //   Ensures the delay from posedge of CK_t to negedge of DQS_t
  //   meets the specified timing requirement.
  //--------------------------------------------------------------------------

property dsh_assertion;
  realtime clk_pos;
  @(posedge inf.ck_t)
    (1, clk_pos = $realtime) |-> 
      @(negedge inf.dqs_t)
        (($realtime - clk_pos) == 0.2 * `TIMEPERIOD);
endproperty

assert property(dsh_assertion);
cover  property(dsh_assertion);

endmodule

`endif
