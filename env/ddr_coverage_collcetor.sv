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

  ////////////////////////////////
  // DDR Activation Coverage
  ////////////////////////////////

  covergroup DDR_ACTIVATION_CG with function sample(ddr_seq_item item);
   option.per_instance = 1;

    ACT_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins act = {ACT};
    }
  endgroup

  covergroup DDR_FOUR_ACTIVATION_CG with function sample(ddr_seq_item item);
   option.per_instance = 1;
    FAW_CP : coverpoint item.cmd iff (vif.reset_n ==1)  {
      bins four_act = (ACT [=4]);
    }
  endgroup

  ////////////////////////////////
  // DDR Precharge Coverage
  ////////////////////////////////
  
  covergroup DDR_PRECHARGE_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    PRE_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins pre = {PRE};
    }

    PREA_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins prea = {PREA};
    }
  endgroup

  ////////////////////////////////
  // DDR Write Coverage
  ////////////////////////////////
  covergroup DDR_WRITE_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    WR_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wr = {WR};
    }

    WRS4_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wrs4 = {WRS4};
    }

    WRS8_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wrs8 = {WRS8};
    }

    WRA_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wra = {WRA};
    }

    WRAS4_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wras4 = {WRAS4};
    }

    WRAS8_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins wras8 = {WRAS8};
    }

  endgroup

  ////////////////////////////////
  // DDR Read Coverage
  ////////////////////////////////

  covergroup DDR_READ_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    RD_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rd = {RD};
    }

    RDS4_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rds4 = {RDS4};
    }

    RDS8_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rds8 = {RDS8};
    }

    RDA_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rda = {RDA};
    }

    RDAS4_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rdas4 = {RDAS4};
    }

    RDAS8_CP : coverpoint item.cmd iff (item.reset_n == 1) {
      bins rdas8 = {RDAS8};
    }
  endgroup

  ////////////////////////////////
  // DDR NOP Coverage
  ////////////////////////////////

  covergroup DDR_NOP_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    NOP_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins nop = {NOP};
    }
  endgroup

  ////////////////////////////////
  // DDR NOP Coverage
  ////////////////////////////////

  covergroup DDR_DES_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    DES_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins des = {DES};
    }
  endgroup

  ////////////////////////////////
  // DDR powerdown Coverage
  ////////////////////////////////

  covergroup DDR_POWERDOWN_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    PDE_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins pda = {PDE};
    }

    PDX_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins pdx = {PDX};
    }

  endgroup

   ////////////////////////////////
  // DDR ZQ Calibration Coverage
  ////////////////////////////////

  covergroup DDR_ZQCALIBRATION_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    ZQCL_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins zqcl = {ZQCL};
    }

    ZQCS_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins zqcs = {ZQCS};
    }

  endgroup

  ////////////////////////////////
  // DDR Refresh Coverage
  ////////////////////////////////

  covergroup DDR_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    REF_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins refe = {REF};
    }

  endgroup
  
  ////////////////////////////////
  // DDR MRS Coverage
  ////////////////////////////////

  covergroup DDR_MRS_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    REF_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins mrs = {MRS};
    }

  endgroup

  ////////////////////////////////
  // DDR Self Refresh Coverage
  ////////////////////////////////

  covergroup DDR_SELF_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    SRE_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins sre = {SRE};
    }

    SRX_CP : coverpoint item.cmd iff (item.reset_n==1) {
      bins srx = {SRX};
    }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to IDLE state Coverage
  ///////////////////////////////////////////////////////

    covergroup DDR_TRANSACTION_TO_IDLE_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    IDLE_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2des_or_nop2nop   = (DES => DES, NOP => NOP);
      bins zqcl2des_or_nop   = (ZQCL => DES, ZQCL => NOP);
      bins zqcs2des_or_nop   = (ZQCS => DES, ZQCS => NOP);
      bins mrs2des_or_nop    = (MRS => DES, MRS => NOP);
      bins pre2des_or_nop    = (PRE => DES, PRE => NOP);
      bins prea2des_or_nop   = (PREA => DES, PREA => NOP);
      bins ref2des_or_nop    = (REF => DES, REF => NOP);
      bins pdx2des_or_nop    = (PDX => DES, PDX => NOP);
      bins srx2des_or_nop    = (SRX => DES, SRX => NOP);//?
      bins wr2des_or_nop     = (WR => DES, WR => NOP);//todo
      bins wrs42des_or_nop   = (WRS4 => DES, WRS4 => NOP);//todo
      bins wrs82des_or_nop   = (WRS8 => DES, WRS8 => NOP);//todo
      bins wra2des_or_nop    = (WRA => DES, WRA => NOP);//todo
      bins wras42des_or_nop  = (WRAS4 => DES, WRAS4 => NOP);//todo
      bins wras82des_or_nop  = (WRAS8 => DES, WRAS8 => NOP);//todo
      bins rd2des_or_nop     = (RD => DES, RD => NOP);//todo
      bins rds42des_or_nop   = (RDS4 => DES, RDS4 => NOP);//todo
      bins rds82des_or_nop   = (RDS8 => DES, RDS8 => NOP);//todo
      bins rda2des_or_nop    = (RDA => DES, RDA => NOP);//todo
      bins rdas42des_or_nop  = (RDAS4 => DES, RDAS4 => NOP);//todo
      bins rdas82des_or_nop  = (RDAS8 => DES, RDAS8 => NOP);//todo
    }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to ACT state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_ACT_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    ACT_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2act              = (ACT => ACT);
      bins dec2act_or_nop2act   = (DES => ACT, NOP => ACT);//todo
      bins pre2act              = (PRE => ACT);
      bins prea2act             = (PREA => ACT);
      bins pdx2act              = (PDX => ACT);   
      bins mrs2act              = (MRS => ACT);
      bins zqcl2act             = (ZQCL => ACT);
      bins zqcs2act             = (ZQCS => ACT);
      bins ref2act              = (REF => ACT);//not possible 
      bins wr2act               = (WR => ACT);// ?
      bins wra2act              = (WRA => ACT);
      bins rd2act               = (RD => ACT);// ?
      bins rda2act              = (RDA => ACT);// burst4 and burst 8 is needed or not 
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to WR or WRA state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_WR_WRA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    WR_WRA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2wr     = (ACT => WR);
      bins act2wra    = (ACT => WRA);
      bins wr2wr      = (WR => WR);
      bins rd2wr      = (RD => WR);
      bins wr2wra     = (WR => WRA);
      bins rd2wra     = (RD => WRA);
      bins pdx2wr     = (PDX => WR);// wrs all possible ot the cross with MRS 
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to RD or RDA state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_RD_RDA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    RD_RDA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2rd     = (ACT => RD);
      bins act2rda    = (ACT => RDA);
      bins rd2rd      = (RD => RD);
      bins wr2rd      = (WR => RD);
      bins rd2rda     = (RD => RDA);
      bins wr2rda     = (WR => RDA);
      bins pdx2rd     = (PDX => RD);// wrs all possible ot the cross with MRS 
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to PRE or PREA state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_PRE_PREA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    PRE_PREA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2pre_or_nop2pre   = (DES => PRE, NOP => PRE);//todo ?
      bins dec2prea_or_nop2prea = (DES => PREA, NOP => PREA);//todo ?
      bins pre2pre              = (PRE => PRE);//?
      bins prea2prea            = (PRE => PRE);//?
      bins act2pre              = (ACT => PRE);
      bins act2prea             = (ACT => PREA);
      bins wr2pre               = (WR => PRE);
      bins wr2prea              = (WR => PREA);
      bins rd2pre               = (RD => PRE);
      bins rd2prea              = (RD => PREA);// all posiible witbrdas3 ro pre or the MR cross
      bins pdx2pre              = (PDX => PRE);//?
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to MRS state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_MRS_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    MRS_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2mrs_or_nop2mrs   = (DES => MRS, NOP => MRS);//todo ?
      bins mrs2mrs              = (MRS => MRS);
      bins ref2mrs              = (REF => MRS);
      bins srx2mrs              = (SRX => MRS);//? maybe no bcz SRX only REF first
      bins pdx2mrs              = (PDX => MRS); //?
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Self Refresh state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_SELF_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    SELF_REFRESH_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2sre_or_nop2sre   = (DES => PRE, NOP => PRE);//todo ?
      bins srx2sre              = (SRX => SRE);//?
      bins ref2sre              = (REF => SRE); 
      bins mrs2sre              = (MRS => SRE); //?
      bins pdx2sre              = (PDX => SRE); 
      bins pre2sre              = (PRE => SRE);
      bins prea2sre             = (PREA => SRE);
      bins wra2sre              = (WRA => SRE);
      bins rda2sre              = (RDA => SRE);//wras4 to or the cross mr 
      bins zqcl2sre             = (ZQCL => SRE);//todo
      bins zqcs2sre             = (ZQCS => SRE);//todo
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Refresh state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    REFRESH_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2ref_or_nop2ref   = (DES => REF, NOP => REF);//todo ?
      bins ref2ref              = (REF => REF);
      bins srx2ref              = (SRX => REF); 
      bins pdx2ref              = (PDX => REF); 
      bins mrs2ref              = (MRS => REF); 
      bins pre2ref              = (PRE => REF);//?
      bins prea2ref             = (PREA => REF);//?
      bins wra2ref              = (WRA => REF);
      bins rda2ref              = (RDA => REF);//wras4 to or the cross mr 
      bins zqcl2ref             = (ZQCL => REF);//todo
      bins zqcs2ref             = (ZQCS => REF);//todo
      }
  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Powerdown state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_POWERDOWN_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    POWERDOWN_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2pde_or_nop2pde   = (DES => PDE, NOP => PDE);//todo ?
      bins pdx2pde              = (PDX => PDE);// possible ?
      bins srx2pde              = (SRX => PDE);//not possible bzc after ref shold come 
      bins mrs2pde              = (MRS => PDE); 
      bins pre2pde              = (PRE => PDE);//?
      bins prea2pde             = (PREA => PDE);//?
      bins wra2pde              = (WRA => PDE);
      bins rda2pde              = (RDA => PDE);//wras4 to or the cross mr 
      bins zqcl2pde             = (ZQCL => PDE);//todo
      bins zqcs2ref             = (ZQCS => PDE);//todo
      }
  endgroup

  //////////////////////////////////////////////////////////
  /////////////////// Reset Signal Coverage ////////////////
  //////////////////////////////////////////////////////////

  covergroup DDR_RESET_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_RESET_CP : coverpoint vif.reset_n {
   
      bins reset_low_asserted = {0};
      bins reset_high_desserted = {1};
    }
  endgroup

  //////////////////////////////////////////////////////////
  //////////////////Control Signal Coverage ////////////////
  //////////////////////////////////////////////////////////
  
  covergroup DDR_CONTROL_SIGNAL_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_CKE_CP : coverpoint vif.cke iff (vif.reset_n == 1){
   
      bins cke_low = {0};
      bins cke_high = {1};
    }

    DDR_CS_n_CP : coverpoint vif.cs_n iff (vif.reset_n == 1){
   
      bins cs_n_low = {0};
      bins cs_n_high = {1};
    }

    DDR_WR_n_CP : coverpoint vif.we_n iff (vif.reset_n == 1){
   
      bins we_n_low = {0};
      bins wr_n_high = {1};
    }
  
     DDR_ras_n_CP : coverpoint vif.ras_n iff (vif.reset_n == 1){
   
      bins ras_n_low = {0};
      bins ras_n_high = {1};
    }

     DDR_cas_n_CP : coverpoint vif.cas_n iff (vif.reset_n == 1){
   
      bins cas_n_low = {0};
      bins cas_n_high = {1};
    }
  
    //odt cover here or not?

  endgroup

  // how cover the dqs and the dm

  /////////////////////////////////////////////////////////
  ////////////////////// Burst chop signal ////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_BURSTCHOP_PIN_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_BC_CP : coverpoint vif.a[12] iff (vif.reset_n == 1 ) {
   
      bins burst_chop = {0};// is this right to cover
      bins no_burst_chop = {1};
    }
  endgroup

  /////////////////////////////////////////////////////////
  ////////////////////// Auto Precharge signal ////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_AUTO_PRECGARE_PIN_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_AP_CP : coverpoint vif.a[10] iff (vif.reset_n == 1) {//uis there need for the cmd 
    //DDR_AP_CP : coverpoint vif.a[10] iff (vif.reset_n == 1 && cmd == (WRA || RDA)) {
   
      bins auto_precharge = {0};// is this right to cover
      bins no_auto_precharge = {1};
    }
  endgroup
  
  /////////////////////////////////////////////////////////
  //////////////////////   MR0 Covergae   /////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MR0_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_BURST_LENGTH_CP : coverpoint vif.a[1:0] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins bl8 = {0};
      bins otf = {1};
      bins bl4 = {2};
    }

    DDR_READ_BURST_TYPE_CP : coverpoint vif.a[3] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {

      bins sequntial = {0};
      bins inteleaved = {1};
     }

    DDR_TM_MODE_CP : coverpoint vif.a[7] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {

      bins tm_normal = {0};
      bins tm_test = {1};
    }

    DDR_DLL_RESET_CP : coverpoint vif.a[8] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {

      bins dll_reset_off = {0};
      bins dll_reset_on = {1};
    }

    DDR_DLL_CONTROL_FOR_PRECHARGE_PD_CP : coverpoint vif.a[12] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {

      bins dll_off_slow_exit = {0};
      bins dll_on_fast_exit = {1};
    }

    DDR_WR_CYCLE_CP : coverpoint vif.a[11:9] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {

      bins wr_10 = {1};// 10 or the 5**2
      bins wr_12 = {2};// 6 **2
      bins wr_14 = {3};// 7 **2
      bins wr_16 = {4};// 8 **2
      bins wr_20 = {5};// 10 ** 2
      bins wr_24 = {6}; // 12 **2

     // find which wr use for DDR3only this cover else ignore
    }

    DDR_CAS_LATENCY_CP : coverpoint vif.a[6:2] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) { // how i write 6,4,2range 

      bins cas_5 = {2};// in our tb this only applicable bcz DDR3_600 we use 
      bins cas_6 = {4};
      bins cas_7 = {6};
      bins cas_8 = {8};
      bins cas_9 = {10};
      bins cas_10 = {12}; 
    }

  endgroup

  /////////////////////////////////////////////////////////
  //////////////////////   MR1 Covergae   /////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MR1_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_DLL_ENABLE_CP : coverpoint vif.a[0] iff (vif.reset_n == 1 && vif.ba == 3'b001 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins dll_enable = {0};
      bins dll_disable = {1};
    }
  
    DDR_ADDITIVE_LATENCY_CP : coverpoint vif.a[3:2] iff (vif.reset_n == 1 && vif.ba == 3'b001 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins al_disable = {0};
      bins al_cl_minus_1 = {1};
      bins al_cl_minus_2 = {2};
    }

    DDR_WRITE_LEVELLING_CP : coverpoint vif.a[7] iff (vif.reset_n == 1 && vif.ba == 3'b001 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins write_levelling_disable = {0};
      bins write_levelling_enable = {1};
    }

    DDR_TDQS_CP : coverpoint vif.a[11] iff (vif.reset_n == 1 && vif.ba == 3'b001 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins tdqs_disable = {0};
      bins tdqs_enable = {1};
    }

  //output buffer and RZ is want to include or not?
  endgroup

  /////////////////////////////////////////////////////////
  //////////////////////   MR2 Covergae   /////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MR2_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_CAS_WRITE_LATENCY_CP : coverpoint vif.a[5:3] iff (vif.reset_n == 1 && vif.ba == 3'b010 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins cwl_5 = {0};
      bins cwl_6 = {1};
      bins cwl_7 = {2};
      bins cwl_8 = {3};// which one i want to cover and reserved are going to ignore bins or not?
    }

    DDR_ASR_CP : coverpoint vif.a[6] iff (vif.reset_n == 1 && vif.ba == 3'b010 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins manual_sr_refrence_srt = {0};
      bins asr_enable = {1};
    }

  // rtt and partial arry self arr ignore or not ?
  endgroup

  
  /////////////////////   MR3 Covergae   /////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MR3_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_MPR_ADDRESS_CP : coverpoint vif.a[1:0] iff (vif.reset_n == 1 && vif.ba == 3'b011 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins predefined_pattern = {0};
   // 1 2 3 rfu
   // is need to cover ?
   }

    DDR_MPR_OPERATION_CP : coverpoint vif.a[2] iff (vif.reset_n == 1 && vif.ba == 3'b011 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins normal_operation = {0};
      bins dataflow_from_mpr = {1};
    }

  //all other are reserved  
  endgroup
  /////////////////////////////////////////////////////////
  // DDR row Address range Coverage ///////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_ROW_ADDRESS_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_ROW_ADDRESS_CP : coverpoint vif.a iff (vif.reset_n == 1){

      bins min_range       = { {`MEM_ROW_WIDTH{1'b0}} };      
      bins max_range       = { {`MEM_ROW_WIDTH{1'b1}} };      
      bins mid_ranges[3]   = { [{`MEM_ROW_WIDTH{1'b0}} + 1 : {`MEM_ROW_WIDTH{1'b1}} - 1 ] }; 
    }
  endgroup
  
  /////////////////////////////////////////////////////////
  // DDR column Address range Coverage /////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_COLUMN_ADDRESS_CG @(posedge vif.ck_t);//in seq item or the @posdege and the whichsignal applied
    option.per_instance = 1;

    DDR_COL_ADDRESS_CP : coverpoint vif.a iff (vif.reset_n == 1){

      bins min_range       = { {`MEM_COL_WIDTH{1'b0}} };      
      bins max_range       = { {`MEM_COL_WIDTH{1'b1}} };      
      bins mid_ranges[3]   = { [{`MEM_COL_WIDTH{1'b0}} + 1 : {`MEM_ROW_WIDTH{1'b1}} - 1 ] }; 
    }
  endgroup

  /////////////////////////////////////////////////////////
  // DDR bank address range Coverage //////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_BANK_ADDRESS_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_BANK_ADDRESS_CP : coverpoint vif.ba iff (vif.reset_n == 1){

      bins bank_address_range = {[0:`MEM_BA_WIDTH-1]};//?
    }

   endgroup

  /////////////////////////////////////////////////////////
  // DDR Data range Coverage //////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_DATA_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_DATA_CP : coverpoint vif.dq iff (vif.reset_n == 1){

      bins min_range       = { {`MEM_DQ_WIDTH{1'b0}} };      
      bins max_range       = { {`MEM_DQ_WIDTH{1'b1}} };      
      bins mid_ranges[3]   = { [{`MEM_DQ_WIDTH{1'b0}} + 1 : {`MEM_DQ_WIDTH{1'b1}} - 1 ] };
   } 
   endgroup


 endclass
    
function ddr_coverage_collector::new(string name ="ddr_coverage_collector",uvm_component parent=null);
  super.new(name,parent);
  DDR_FOUR_ACTIVATION_CG = new();
  DDR_ACTIVATION_CG = new();
  DDR_PRECHARGE_CG = new();
  DDR_WRITE_CG = new();
  DDR_READ_CG = new();
  DDR_DES_CG = new();
  DDR_NOP_CG = new();
  DDR_MRS_CG = new();
  DDR_POWERDOWN_CG = new();
  DDR_REFRESH_CG = new();
  DDR_SELF_REFRESH_CG = new();
  DDR_ZQCALIBRATION_CG = new();
  DDR_REFRESH_CG = new();
  DDR_MRS_CG = new();
  DDR_SELF_REFRESH_CG = new();
  DDR_TRANSACTION_TO_IDLE_CG = new();
  DDR_TRANSACTION_TO_ACT_CG = new();
  DDR_TRANSACTION_TO_WR_WRA_CG = new();
  DDR_TRANSACTION_TO_RD_RDA_CG = new();
  DDR_TRANSACTION_TO_MRS_CG = new();
  DDR_TRANSACTION_TO_SELF_REFRESH_CG = new();
  DDR_TRANSACTION_TO_REFRESH_CG = new();
  DDR_TRANSACTION_TO_POWERDOWN_CG = new();
  DDR_RESET_CG = new();
  DDR_CONTROL_SIGNAL_CG = new();
  DDR_BURSTCHOP_PIN_CG = new();
  DDR_AUTO_PRECGARE_PIN_CG = new();
  DDR_MR0_CG = new();
  DDR_MR1_CG = new();
  DDR_MR2_CG = new();
  DDR_MR3_CG = new();
  DDR_ROW_ADDRESS_CG = new();
  DDR_COLUMN_ADDRESS_CG = new();
  DDR_BANK_ADDRESS_CG = new();
  DDR_DATA_CG = new();

endfunction

    
function void ddr_coverage_collector::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "starting of build phase....", UVM_LOW)
  super.build_phase(phase);
  ddr_coverage_collector_imp_port = new("ddr_coverage_collector_imp_port",this);

  if(!uvm_config_db #(virtual ddr_interface)::get(this,"","vif",vif))
    `uvm_error(get_type_name(),"can not able to get inteface in coverage class")
  `uvm_info(get_type_name(), "ending of build phase....", UVM_LOW)
endfunction

function void ddr_coverage_collector::write(ddr_seq_item req);
  DDR_FOUR_ACTIVATION_CG.sample(req);
  DDR_ACTIVATION_CG.sample(req);
  DDR_PRECHARGE_CG.sample(req);
  DDR_WRITE_CG.sample(req);
  DDR_READ_CG.sample(req);
  DDR_DES_CG.sample(req);
  DDR_NOP_CG.sample(req);
  DDR_MRS_CG.sample(req);
  DDR_POWERDOWN_CG.sample(req);
  DDR_REFRESH_CG.sample(req);
  DDR_SELF_REFRESH_CG.sample(req);
  DDR_ZQCALIBRATION_CG.sample(req);
  DDR_REFRESH_CG.sample(req);
  DDR_MRS_CG.sample(req);
  DDR_SELF_REFRESH_CG.sample(req);
  DDR_TRANSACTION_TO_IDLE_CG.sample(req);
  DDR_TRANSACTION_TO_ACT_CG.sample(req);
  DDR_TRANSACTION_TO_WR_WRA_CG.sample(req);
  DDR_TRANSACTION_TO_RD_RDA_CG.sample(req);
  DDR_TRANSACTION_TO_MRS_CG.sample(req);
  DDR_TRANSACTION_TO_SELF_REFRESH_CG.sample(req);
  DDR_TRANSACTION_TO_REFRESH_CG.sample(req);
  DDR_TRANSACTION_TO_POWERDOWN_CG.sample(req);
endfunction
    
`endif
