///////////////////////////////////////////////////////////////////////////////////
// Filename: ddr_config.sv
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
// Description:
//   Configuration object for DDR3 components.
//   This class holds DDR3 device parameters, JEDEC-defined timing values,
//   feature enable switches, and derived timing calculations.
//   All timing comments are aligned with DDR3-800 JEDEC specification.
// Dependencies:
//   None
// Notes:
//   - Code logic is NOT modified
//   - Only DDR3-related explanatory comments are added
//////////////////////////////////////////////////////////////////////////////////
`ifndef DDR_CONFIG_SV
`define DDR_CONFIG_SV

class ddr_config extends uvm_object;
 
  //////////////////////////////////////////////////////////////////////////
  // Factory registration
  // description : Enables factory-based creation of DDR configuration
  //////////////////////////////////////////////////////////////////////////
  `uvm_object_utils(ddr_config)

  //////////////////////////////////////////////////////////////////////////
  // Constructor
  // description : Initializes DDR3 configuration with JEDEC defaults
  //////////////////////////////////////////////////////////////////////////
  extern function new(string name ="ddr_config");

  //////////////////////////////////////////////////////////////////////////
  // DDR Device Configuration Parameters
  // description : Defines DDR3 physical organization
  //////////////////////////////////////////////////////////////////////////

  // Selected DDR3 configuration
  device_type device;        // JEDEC device width
  device_frequency freq;     // DDR3 speed bin
  device_size siz;           // DDR3 density

  //////////////////////////////////////////////////////////////////////////
  // Feature Enable Controls
  // description : Enables/disables verification features
  //////////////////////////////////////////////////////////////////////////

  bit enable_coverage;        // Functional coverage enable
  bit enable_checkers;        // Protocol & timing checkers
  bit enable_assertions;      // SystemVerilog assertions
  bit enable_scoreboard;      // Data scoreboard

  //////////////////////////////////////////////////////////////////////////
  // DDR Structural Parameters
  // description : Memory organization related parameters
  //////////////////////////////////////////////////////////////////////////

  int page_size;              // Page size (1KB / 2KB as per JEDEC)

  //////////////////////////////////////////////////////////////////////////
  // DDR3 Timing Parameters (Clock-cycle based)
  // description : JEDEC DDR3 command & data timing (in cycles)
  //////////////////////////////////////////////////////////////////////////

  int trcd;   // ACTIVATE to READ/WRITE delay (tRCD)
  int tcl;    // CAS latency (CL)
  int tcwl;   // CAS write latency (CWL)
  int tal;    // Additive latency (AL)

  int trl;    // Read latency = CL + AL
  int twl;    // Write latency = CWL + AL

  int tccd;   // CAS to CAS delay
  int tmrd;   // Mode Register Set command cycle time
  int tmod;   // Mode Register update delay
  int tmprr;  // Multi-Purpose Register Recovery Time
  int trtp;   // READ to PRECHARGE delay
  int twtr;   // WRITE to READ delay
  int trrd;   // ACTIVATE to ACTIVATE delay
  int tcke;   // Minimum CKE pulse width
  int tckesr; // CKE low width for self refresh
  int tcksre; // Valid clock before self refresh entry
  int tcksrx; // Valid clock before self refresh exit
  int txp;    // Power-down exit timing
  int txpdll; // Power-down exit with DLL on
  int tcpded; // Command pass disable delay
  int tpd;    // Power-down entry timing
  int tactpden; // ACT to power-down entry
  int tprpden;  // PRE to power-down entry
  int trdpden;  // READ to power-down entry
  int trefpden; // REF to power-down entry
  int tmrspden; // MRS to power-down entry

  int twlmrd;   // First DQS edge after write leveling mode
  int twldqsen; // DQS delay after write leveling enable
  int twlh;     // Write leveling hold time
  int twlo;     // Write leveling output delay
  int twloe;    // Write leveling output error

  int tpre;     // DQS preamble (ns based)
  int tpst;     // DQS postamble (ns based)
  int tdllk;    // DLL locking time

  int todth4;   // ODT high time BL4
  int todth8;   // ODT high time BL8

  int tzqinit;  // ZQ calibration initial time
  int tzqoper;  // ZQ calibration long
  int tzqcs;    // ZQ calibration short
  int txpr;     // Exit reset timing
  int txs;      // Exit self refresh
  int txsdll;   // Exit self refresh with DLL lock

  //////////////////////////////////////////////////////////////////////////
  // DDR3 Timing Parameters (Time-based, ns or cycles)
  // description : JEDEC absolute timing requirements
  //////////////////////////////////////////////////////////////////////////

  real trp;     // PRECHARGE command period
  real tras;    // ACTIVE to PRECHARGE minimum
  real trc;     // Row cycle time (tRAS + tRP)
  real twr;     // WRITE recovery time
  real tfaw;    // Four activate window
  real tdal;    // Data-in to ACTIVE latency
  real trfc;    // Refresh cycle time
  real temp;    // Operating temperature
  real trefi;   // Refresh interval

  //////////////////////////////////////////////////////////////////////////
  // Power-down & ODT derived timings
  //////////////////////////////////////////////////////////////////////////

  real wrpden_bl8otf_bl8mrs_bc4_otf;  // WR to PD (BL8 OTF/MRS)
  real wrapden_bl8otf_bl8mrs_bc4_otf; // WRA to PD (BL8 OTF/MRS)
  real wrpden_bc4_mrs;                // WR to PD (BC4 MRS)
  real wrapden_bc4_mrs;               // WRA to PD (BC4 MRS)

  //////////////////////////////////////////////////////////////////////////
  // DQS / Data timing parameters (ns)
  // description : DDR3 data & strobe timing from JEDEC tables
  //////////////////////////////////////////////////////////////////////////

  real twls;     // Write leveling setup
  real tqsh;     // DQS output high time
  real tqsl;     // DQS output low time
  real thz;      // DQ/DQS high impedance
  real tdss;     // DQS setup to CK
  real tdsh;     // DQS hold from CK
  real tdqsq;    // DQS-DQ skew
  real tqh;      // DQS output hold
  real tds_base; // Data setup to DQS
  real tdh_base; // Data hold from DQS
  real tdipw;    // DQ/DM input pulse width
  real tis_base; // Command/address setup
  real tih_base; // Command/address hold
  real tipw;     // Command/address pulse width

  //////////////////////////////////////////////////////////////////////////
  // Randomized JEDEC parameters
  // description : Adds skew within JEDEC min/max
  //////////////////////////////////////////////////////////////////////////

  rand int tdqsck_temp;  // DQS to CK skew (±400ps)
  real tdqsck;

  rand int tlz_temp;     // DQ/DQS low-Z timing
  real tlz;

  rand int tdqsl_temp;   // DQS input low pulse width
  real tdqsl;

  rand int tdqsh_temp;   // DQS input high pulse width
  real tdqsh;

  rand int tdqss_temp;   // DQS to CK skew
  real tdqss;

  rand int taonpd_temp;  // RTT turn-on delay (PD)
  real taonpd;

  rand int taofpd_temp;  // RTT turn-off delay (PD)
  real taofpd;

  rand int taon_temp;    // RTT turn-on delay
  real taon;

  rand int taof_temp;    // RTT turn-off delay
  real taof;

  rand int tadc_temp;    // RTT dynamic change skew
  real tadc;

  //////////////////////////////////////////////////////////////////////////
  // Agent Configuration
  // description : Active/passive mode selection
  //////////////////////////////////////////////////////////////////////////

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  //////////////////////////////////////////////////////////////////////////
  // JEDEC-constrained randomization ranges
  //////////////////////////////////////////////////////////////////////////

  constraint dqsck_range {tdqsck_temp inside {[-4:4]};}
  constraint lz_range    {tlz_temp    inside {[-8:4]};}
  constraint dqsl_range  {tdqsl_temp  inside {[1125:1375]};}
  constraint dqsh_range  {tdqsh_temp  inside {[1125:1375]};}
  constraint dqss_range  {tdqss_temp  inside {[-625:625]};}
  constraint aonpd_range {taonpd_temp inside {[20:85]};}
  constraint aofpd_range {taofpd_temp inside {[20:85]};}
  constraint aon_range   {taon_temp   inside {[-4:4]};}
  constraint aof_range   {taof_temp   inside {[75:175]};}
  constraint adc_range   {tadc_temp   inside {[75:175]};}

  //////////////////////////////////////////////////////////////////////////
  // post_randomize
  // description : Converts randomized integer values into ns units
  //////////////////////////////////////////////////////////////////////////

  function void post_randomize();
    tdqsck = tdqsck_temp/10.0;
    tlz    = tlz_temp/10.0;
    tdqsl  = tdqsl_temp/1000.0;
    tdqsh  = tdqsh_temp/1000.0;
    tdqss  = tdqss_temp/1000.0;
    taonpd = taonpd_temp/10.0;
    taofpd = taofpd_temp/10.0;
    taon   = taon_temp/10.0;
    taof   = taof_temp/100.0;
    tadc   = tadc_temp/100.0;
  endfunction
endclass

//////////////////////////////////////////////////////////////////////////
// description : Assigns DDR3-800 JEDEC default timing values
//////////////////////////////////////////////////////////////////////////
function ddr_config::new(string name ="ddr_config");
  super.new(name);

  // Default DDR device configuration
  device = x8;             // Default device width (x8)
  siz = gb4;               // Default device size (4Gb)
  freq = ddr3_800d;        // Default frequency (DDR3-800D)

  // Enable features by default
  enable_coverage = 1;
  enable_checkers = 1;
  enable_assertions = 1;
  enable_scoreboard = 1;
  
  // Default page size configuration
  page_size = 1;              // Page size = 1KB

  // Default write latency parameters
  tcwl = 5;                   // CAS Write Latency
  tal = 0;                    // No additive latency

  // Frequency-dependent timing configuration
  if(freq == 0) begin
    tcl = 5;                  // CAS Latency for DDR3-800D
    trcd = 5;                 // tRCD for DDR3-800D
    trp = 5;                  // tRP for DDR3-800D
  end
  else begin
    tcl = 6;                  // CAS Latency for DDR3-800E
    trcd = 6;                 // tRCD for DDR3-800E
    trp = 6;                  // tRP for DDR3-800E
  end

  // Derived latencies
  trl = tcl + tal;               // Read latency
  twl = tcwl + tal;              // Write latency

  // DDR command timing parameters
  tccd = 4;                   // Minimum delay between column commands
  tmrd = 4;                   // Mode register set delay
  tmod = 12;                  // MRS update delay
  tmprr = 1;                  // MPR read-to-read delay
  trtp = 4;                   // Read to precharge delay
  twtr = 4;                   // Write to read delay
  trrd = 4;                   // Activate to activate delay
  tras = 37.75/(`TIMEPERIOD);               // 15 Minimum active time
  trc = 50/(`TIMEPERIOD);                   // 20 Row cycle time
  twr = 15/(`TIMEPERIOD);                   // 6 Write recovery time
  tcke = 3;
  tckesr = tcke+1;
  tcksre = 5;
  tcksrx = 5;
  txp = 3;
  txpdll = 10;
  tcpded = 1;
  tpd = tcke; // between tcke(min) and 9*trefi 
  tpre = (`TIMEPERIOD);
  tpst = (`TIMEPERIOD/2);
  tdal = twr + int'(trp/(`TIMEPERIOD));
   
  // Page-size dependent four activate window
  if(page_size == 1)
    tfaw = 40/(`TIMEPERIOD);               // 16 tFAW for 1KB page
  else if(page_size == 2)
    tfaw = 50/(`TIMEPERIOD);               // 20 tFAW for 2KB page


  if(siz == mb512)begin
    trfc = 90/(`TIMEPERIOD); //36
  end
  else if(siz == gb1)begin
    trfc = 110/(`TIMEPERIOD); //44
  end
  else if(siz == gb2)begin
    trfc = 160/(`TIMEPERIOD); //64
  end
  else if(siz == gb4)begin
    trfc = 300/(`TIMEPERIOD); //120
  end
  else if(siz == gb8)begin
    trfc = 350/(`TIMEPERIOD); //140
  end  

  if(temp >= 0 && temp <= 85) begin
    trefi = 7800/(`TIMEPERIOD); //3120
  end
  else if(temp >= 85 && temp <= 95) begin
    trefi = 3900/(`TIMEPERIOD); //1560
  end

  tactpden = 1;
  tprpden = 1;
  trdpden = trl+4+1;

  wrpden_bl8otf_bl8mrs_bc4_otf = twl+4+(twr/(`TIMEPERIOD));
  wrapden_bl8otf_bl8mrs_bc4_otf = twl+4+twr+1;
  wrpden_bc4_mrs = twl+2+(twr/(`TIMEPERIOD));
  wrapden_bc4_mrs = twl+2+twr+1;

  trefpden = 1;
  tmrspden = tmod;

  twlmrd = 40;
  twldqsen = 25;
  twls = 0.325/(`TIMEPERIOD);
  twlh = 0.325/(`TIMEPERIOD);
  twlo = 0; // [0:9] - range
  twloe = 0; //[0:2] - range
  
  tqsh = 0.38 *(`TIMEPERIOD);
  tqsl = 0.38 *(`TIMEPERIOD);
  tqh = 0.38 *(`TIMEPERIOD);
  thz = 0.4; //ns
  tdss = 0.2 *(`TIMEPERIOD);
  tdsh = 0.2 *(`TIMEPERIOD);
  tdqsq = 0.2;//ns
  tds_base = 0.075;//ns
  tdipw = 0.6; //ns
  tdllk = 512 ; 
  tis_base = 0.2;//ns
  tih_base = 0.275;//ns
  tipw = 0.9;//ns

  todth4 = 4;
  todth8 = 6;

  tzqinit = 512;
  tzqoper = 256;
  tzqcs = 64;
  txpr = 5;
  txs = 5;
  txsdll = tdllk;

endfunction

`endif