///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_assertion.sv
// 
// Author: Scaledge
// Date: 24/12/2025
// Revision: 1
// Company: Scaledge Technology Pvt.
// Copyright (c) 2025 Scaledge Technology Pvt. All rights reserved.
// This file is part of the  DDR project.
// Description:
// Dependencies:
// Notes:
//////////////////////////////////////////////////////////////////////////

`ifndef DDR_ASSERTION_SV
`define DDR_ASSERTION_SV

module ddr_assertion(ddr_interface inf);

property dqsck_assertion;
  realtime dqs_pos;
  @(posedge inf.ck_t)
  ($rose(inf.dqs_t),dqs_pos = $realtime) |-> @(negedge inf.ck_c) ((($realtime - (`TIMEPERIOD/2) - dqs_pos) >= -400ps) && (($realtime - (`TIMEPERIOD/2) - dqs_pos) <= 400ps));
endproperty

assert property(dqsck_assertion);

/*property dqsq_assertion;
  realtime edge_t;
	@(posedge inf.dqs_t or posedge inf.dqs_c)
	(1, edge_t = $realtime) |-> 
	if(!$isunknown(inf.dq)) 
	  (($realtime - edge_t >= 0) && ($realtime - edge_t <= 200)) ;
endproperty

assert property(dqsq_assertion);*/

endmodule

`endif
