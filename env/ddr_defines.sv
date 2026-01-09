///////////////////////////////////////////////////////////////////////////////////
// Filename:ddr_defines.sv
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
// Dependencies:
// Notes:
//////////////////////////////////////////////////////////////////////////////////

`define TIMEPERIOD 2.5 //((1/(FREQUENCY))*(1000)) = (1/400)*1000 frq in MHZ 
`define MEM_DQ_WIDTH 8
`define MEM_BA_WIDTH 3
`define MEM_ROW_WIDTH 13
`define MEM_COL_WIDTH 13
`define AL 3
`define CWL 5
`define CL 5

// Device data width (JEDEC x4/x8/x16)
typedef enum bit[1:0]{x4,x8,x16} device_type; 

// Device density as per DDR3 SDRAM part sizes
typedef enum bit[2:0]{mb512,gb1,gb2,gb4,gb8} device_size; 

// DDR3 speed grade selection (800D / 800E)
typedef enum bit{ddr3_800d,ddr3_800e} device_frequency;

//DDR3 commands
typedef enum {    
  MRS,    // Mode Register Set
  REF,    // Refresh
  SRE,    // Self Refresh Entry
  SRX,    // Self Refresh Exit
  PRE,    // Single Bank Precharge
  PREA,   // Precharge All Banks
  ACT,    // Bank Activate

  WR,     // Write (Fixed BL8 or BC4)
  WRS4,   // Write (BC4, on-the-fly)
  WRS8,   // Write (BL8, on-the-fly)

  WRA,    // Write with Auto Precharge (Fixed BL8 or BC4)
  WRAS4,  // Write with Auto Precharge (BC4, on-the-fly)
  WRAS8,  // Write with Auto Precharge (BL8, on-the-fly)

  RD,     // Read (Fixed BL8 or BC4)
  RDS4,   // Read (BC4, on-the-fly)
  RDS8,   // Read (BL8, on-the-fly)

  RDA,    // Read with Auto Precharge (Fixed BL8 or BC4)
  RDAS4,  // Read with Auto Precharge (BC4, on-the-fly)
  RDAS8,  // Read with Auto Precharge (BL8, on-the-fly)

  NOP,    // No Operation
  DES,    // Device Deselected

  PDE,    // Power Down Entry
  PDX,    // Power Down Exit

  ZQCL,   // ZQ Calibration Long
  ZQCS    // ZQ Calibration Short
} command_e;