class ddr_wrapper_cov_class;

  virtual ddr_interface vif;

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
      bins srx2des_or_nop    = (SRX => DES, SRX => NOP);
      bins wr2des_or_nop     = (WR => DES, WR => NOP);
      bins wrs42des_or_nop   = (WRS4 => DES, WRS4 => NOP);
      bins wrs82des_or_nop   = (WRS8 => DES, WRS8 => NOP);
      bins wra2des_or_nop    = (WRA => DES, WRA => NOP);
      bins wras42des_or_nop  = (WRAS4 => DES, WRAS4 => NOP);
      bins wras82des_or_nop  = (WRAS8 => DES, WRAS8 => NOP);
      bins rd2des_or_nop     = (RD => DES, RD => NOP);
      bins rds42des_or_nop   = (RDS4 => DES, RDS4 => NOP);
      bins rds82des_or_nop   = (RDS8 => DES, RDS8 => NOP);
      bins rda2des_or_nop    = (RDA => DES, RDA => NOP);
      bins rdas42des_or_nop  = (RDAS4 => DES, RDAS4 => NOP);
      bins rdas82des_or_nop  = (RDAS8 => DES, RDAS8 => NOP);
    }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to ACT state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_ACT_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    ACT_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2act              = (ACT => ACT);
      bins dec2act_or_nop2act   = (DES => ACT, NOP => ACT);
      bins pre2act              = (PRE => ACT);
      bins prea2act             = (PREA => ACT);
      bins pdx2act              = (PDX => ACT);   
      bins mrs2act              = (MRS => ACT);
      bins zqcl2act             = (ZQCL => ACT);
      bins zqcs2act             = (ZQCS => ACT);
      bins ref2act              = (REF => ACT);
      bins wra2act              = (WRA => ACT);
      bins wras42act            = (WRAS4 => ACT);
      bins wras82act            = (WRAS8 => ACT);
      bins rda2act              = (RDA => ACT);
      bins rdas42act            = (RDAS4 => ACT);
      bins rdas82act            = (RDAS8 => ACT);
      }
  endgroup

  ///////////////////////////////////////////////////////////
  // DDR all possible trascation to WR or WRA state Coverage
  ///////////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_WR_WRA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    WR_WRA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2wr     = (ACT => WR);
      bins act2wrs4   = (ACT => WRS4);
      bins act2wrs8   = (ACT => WRS8);
      bins act2wra    = (ACT => WRA);
      bins act2wras4  = (ACT => WRAS4);
      bins act2wras8  = (ACT => WRAS8);
      bins wr2wr      = (WR => WR);
      bins wrs42wrs4  = (WRS4 => WRS4);
      bins wrs82wrs8  = (WRS8 => WRS8);
      bins wrs42wrs8  = (WRS4 => WRS8);
      bins wrs82wrs4  = (WRS8 => WRS4);
      bins rd2wr      = (RD => WR);
      bins wr2wra     = (WR => WRA);
      bins rd2wra     = (RD => WRA);
      bins pdx2wr     = (PDX => WR);
      bins pdx2wrs4   = (PDX => WRS4);
      bins pdx2wrs8   = (PDX => WRS8);
      }
  endgroup

  ////////////////////////////////////////////////////////////
  // DDR all possible trascation to RD or RDA state Coverage
  ////////////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_RD_RDA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    RD_RDA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins act2rd     = (ACT => RD);
      bins act2rds4   = (ACT => RDS4);
      bins act2rds8   = (ACT => RDS8);
      bins act2rda    = (ACT => RDA);
      bins act2rdas4  = (ACT => RDAS4);
      bins act2rdas8  = (ACT => RDAS8);
      bins rd2rd      = (RD => RD);
      bins rds42rds4  = (RDS4 => RDS4);
      bins rds82rds8  = (RDS8 => RDS8);
      bins rds42rds8  = (RDS4 => RDS8);
      bins rds82rds4  = (RDS8 => RDS4);
      bins wr2rd      = (WR => RD);
      bins rd2rda     = (RD => RDA);
      bins wr2rda     = (WR => RDA);
      bins pdx2rd     = (PDX => RD);
      bins pdx2rds4     = (PDX => RDS4);
      bins pdx2rds8     = (PDX => RDS8);
      }

  endgroup

  //////////////////////////////////////////////////////////////
  // DDR all possible trascation to PRE or PREA state Coverage
  //////////////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_PRE_PREA_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    PRE_PREA_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2pre_or_nop2pre   = (DES => PRE, NOP => PRE);
      bins dec2prea_or_nop2prea = (DES => PREA, NOP => PREA);
      bins pre2pre              = (PRE => PRE);
      bins prea2prea            = (PREA => PRE);
      bins act2pre              = (ACT => PRE);
      bins act2prea             = (ACT => PREA);
      bins wr2pre               = (WR => PRE);
      bins wr2prea              = (WR => PREA);
      bins wrs42pre             = (WRS4 => PRE);
      bins wrs42prea            = (WRS4 => PREA);
      bins wrs82pre             = (WRS8 => PRE);
      bins wrs82prea            = (WRS8 => PREA);
      bins rd2pre               = (RD => PRE);
      bins rd2prea              = (RD => PREA);
      bins rds42pre             = (RDS4 => PRE);
      bins rds42prea            = (RDS4 => PREA);
      bins rds82pre             = (RDS8 => PRE);
      bins rds82prea            = (RDS8 => PREA);
      bins pdx2pre              = (PDX => PRE);
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to MRS state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_MRS_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    MRS_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2mrs_or_nop2mrs   = (DES => MRS, NOP => MRS);
      bins mrs2mrs              = (MRS => MRS);
      bins ref2mrs              = (REF => MRS);
      bins pre2pdx2mrs          = (PRE => PDX => MRS); 
      bins prea2pdx2mrs         = (PREA => PDX => MRS); 
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Self Refresh state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_SELF_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    SELF_REFRESH_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2sre_or_nop2sre   = (DES => PRE, NOP => PRE);
      bins ref2sre              = (REF => SRE); 
      bins mrs2sre              = (MRS => SRE); 
      bins pdx2sre              = (PDX => SRE); 
      bins pre2sre              = (PRE => SRE);
      bins prea2sre             = (PREA => SRE);
      bins wra2sre              = (WRA => SRE);
      bins wras42sre            = (WRAS4 => SRE);
      bins wras82sre            = (WRAS8 => SRE);
      bins rda2sre              = (RDA => SRE); 
      bins rdas42sre            = (RDAS4 => SRE); 
      bins rdas82sre            = (RDAS8 => SRE); 
      bins zqcl2sre             = (ZQCL => SRE);
      bins zqcs2sre             = (ZQCS => SRE);
      }

  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Refresh state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_REFRESH_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    REFRESH_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2ref_or_nop2ref   = (DES => REF, NOP => REF);
      bins ref2ref              = (REF => REF);
      bins srx2ref              = (SRX => REF); 
      bins pdx2ref              = (PDX => REF); 
      bins mrs2ref              = (MRS => REF); 
      bins pre2ref              = (PRE => REF);
      bins prea2ref             = (PREA => REF);
      bins wra2ref              = (WRA => REF);
      bins wras42ref            = (WRAS4 => REF);
      bins wras82ref            = (WRAS8 => REF);
      bins rda2ref              = (RDA => REF); 
      bins rdas42ref            = (RDAS4 => REF); 
      bins rdas82ref            = (RDAS8 => REF); 
      bins zqcl2ref             = (ZQCL => REF);
      bins zqcs2ref             = (ZQCS => REF);
      }
  endgroup

  ///////////////////////////////////////////////////////
  // DDR all possible trascation to Powerdown state Coverage
  ///////////////////////////////////////////////////////

  covergroup DDR_TRANSACTION_TO_POWERDOWN_CG with function sample(ddr_seq_item item);
    option.per_instance = 1;

    POWERDOWN_TRNSACTION_CP : coverpoint item.cmd iff (vif.reset_n==1) {
      bins dec2pde_or_nop2pde   = (DES => PDE, NOP => PDE);
      bins pdx2pde              = (PDX => PDE);
      bins mrs2pde              = (MRS => PDE); 
      bins pre2pde              = (PRE => PDE);
      bins prea2pde             = (PREA => PDE);
      bins wra2pde              = (WRA => PDE);
      bins wras42pde            = (WRAS4 => PDE);
      bins wras82pde            = (WRAS8 => PDE);
      bins rda2pde              = (RDA => PDE);
      bins rdas42pde            = (RDAS4 => PDE);
      bins rdas82pde            = (RDAS8 => PDE);
      bins zqcl2pde             = (ZQCL => PDE);
      bins zqcs2ref             = (ZQCS => PDE);
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
  
     DDR_odt_CP : coverpoint vif.odt iff (vif.reset_n == 1){
   
      bins odt_low = {0};
      bins odt_high = {1};
    }

     DDR_dm_CP : coverpoint vif.dm iff (vif.reset_n == 1){
   
      bins dm_low = {0};
      bins dm_high = {1};
    }

  endgroup


  /////////////////////////////////////////////////////////
  ////////////////////// Burst chop signal ////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_BURSTCHOP_PIN_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_BC_CP : coverpoint vif.a[12] iff (vif.reset_n == 1 && vif.ba == 3'b000 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins burst_chop = {0};
      bins no_burst_chop = {1};
    }
  endgroup

  /////////////////////////////////////////////////////////
  ////////////////////// Auto Precharge signal ////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_AUTO_PRECGARE_PIN_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_AP_CP : coverpoint vif.a[10] iff (vif.reset_n == 1 && vif.cke == 1 && vif.cs_n == 0 && vif.ras_n == 1 && vif.cas_n == 0 && (vif.we_n == 0 || vif.we_n == 1)) {
   
      bins auto_precharge = {0};
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

  
  /////////////////////////////////////////////////////////
  /////////////////////   MR3 Covergae   /////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MR3_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_MPR_ADDRESS_CP : coverpoint vif.a[1:0] iff (vif.reset_n == 1 && vif.ba == 3'b011 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins predefined_pattern = {0};
   // 1 2 3 rfu
   }

    DDR_MPR_OPERATION_CP : coverpoint vif.a[2] iff (vif.reset_n == 1 && vif.ba == 3'b011 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0) {
   
      bins normal_operation = {0};
      bins dataflow_from_mpr = {1};
    }

  //all other are reserved  
  endgroup

  /////////////////////////////////////////////////////////
  // DDR row/column Address range Coverage ///////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_ROW_COL_ADDRESS_CG @(posedge vif.ck_t);//it cover when the act is arrived 
    option.per_instance = 1;

    DDR_ROW_ADDRESS_CP : coverpoint vif.a iff (vif.reset_n == 1 && vif.cke == 1 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 1 && vif.we_n == 1){

      bins min_row_range       = { {`MEM_ROW_WIDTH{1'b0}} };      
      bins max_row_range       = { {`MEM_ROW_WIDTH{1'b1}} };      
      bins mid_row_ranges[3]   = { [{`MEM_ROW_WIDTH{1'b0}} + 1 : {`MEM_ROW_WIDTH{1'b1}} - 1 ] }; 
    }
  
    DDR_COL_ADDRESS_CP : coverpoint vif.a iff (vif.reset_n == 1 && vif.cke == 1 && vif.cs_n == 0 && vif.ras_n == 1 && vif.cas_n == 0 && (vif.we_n == 0 || vif.we_n == 1)){

      bins min_col_range       = { {`MEM_COL_WIDTH{1'b0}} };      
      bins max_col_range       = { {`MEM_COL_WIDTH{1'b1}} };      
      bins mid_col_ranges[3]   = { [{`MEM_COL_WIDTH{1'b0}} + 1 : {`MEM_ROW_WIDTH{1'b1}} - 1 ] }; 
    }

    DDR_ROW_X_COL_CROSS_CP : cross DDR_ROW_ADDRESS_CP,DDR_COL_ADDRESS_CP;
  endgroup


  /////////////////////////////////////////////////////////
  // DDR Data range Coverage //////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_DATA_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_DATA__CP : coverpoint vif.dq iff (vif.reset_n == 1){

      bins min_range       = { {`MEM_DQ_WIDTH{1'b0}} };      
      bins max_range       = { {`MEM_DQ_WIDTH{1'b1}} };      
      bins mid_ranges[3]   = { [{`MEM_DQ_WIDTH{1'b0}} + 1 : {`MEM_DQ_WIDTH{1'b1}} - 1 ] };
   } 
   endgroup

  /////////////////////////////////////////////////////////
  // DDR bank address range Coverage //////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_BANK_ADDRESS_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_BANK_ADDRESS_CP : coverpoint vif.ba iff (vif.reset_n == 1){

      bins bank_address_range[] = {[0:`MEM_BA_WIDTH-1]};
    }

   endgroup

 
  /////////////////////////////////////////////////////////
  // DDR Data range Coverage //////////////////////
  /////////////////////////////////////////////////////////

  covergroup DDR_MRS_INITIAL_TRANSACTION_CG @(posedge vif.ck_t);
    option.per_instance = 1;

    DDR_MRS_INITIAL_TRANSACTION_CP : coverpoint vif.ba iff (vif.reset_n == 1 && vif.cke == 0 && vif.cs_n == 0 && vif.ras_n == 0 && vif.cas_n == 0 && vif.we_n == 0){

      bins mrs_initilization_trasnaction = ( 2 => 3 => 1 => 0);      
    }
   endgroup
 
  ///////////////////////////////////////////////
  // DDR write/read with burstlength cross Coverage
  ///////////////////////////////////////////////

  covergroup DDR_WR_RD_WITH_BL_CROSS_CG;
    option.per_instance = 1;

    DDR_WR_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WR_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wr_bl_cross = binsof(DDR_WRITE_CG.WR_CP) intersect {0,2};
                                     }
    DDR_WRS4_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WRS4_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wrs4_bl_cross = binsof(DDR_WRITE_CG.WRS4_CP) intersect {1};
                                     } 
    DDR_WRS8_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WRS8_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wrs8_bl_cross = binsof(DDR_WRITE_CG.WRS8_CP) intersect {1};
                                     }  
    DDR_WRA_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WRA_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wra_bl_cross = binsof(DDR_WRITE_CG.WRA_CP) intersect {0,2};
                                     } 
    DDR_WRAS4_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WRAS4_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wras4_bl_cross = binsof(DDR_WRITE_CG.WRAS4_CP) intersect {1};
                                     } 
    DDR_WRAS8_WITH_BL_CROSS_CP : cross DDR_WRITE_CG.WRAS8_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins wras8_bl_cross = binsof(DDR_WRITE_CG.WRAS8_CP) intersect {1};
                                     } 
    DDR_RD_WITH_BL_CROSS_CP : cross DDR_READ_CG.RD_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rd_bl_cross = binsof(DDR_READ_CG.RD_CP) intersect {0,2};
                                     }
    DDR_RDS4_WITH_BL_CROSS_CP : cross DDR_READ_CG.RDS4_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rds4_bl_cross = binsof(DDR_READ_CG.RDS4_CP) intersect {1};
                                     } 
    DDR_RDS8_WITH_BL_CROSS_CP : cross DDR_READ_CG.RDS8_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rds8_bl_cross = binsof(DDR_READ_CG.RDS8_CP) intersect {1};
                                     }  
    DDR_RDA_WITH_BL_CROSS_CP : cross DDR_READ_CG.RDA_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rda_bl_cross = binsof(DDR_READ_CG.RDA_CP) intersect {0,2};
                                     } 
    DDR_RDAS4_WITH_BL_CROSS_CP : cross DDR_READ_CG.RDAS4_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rdas4_bl_cross = binsof(DDR_READ_CG.RDAS4_CP) intersect {1};
                                     } 
    DDR_RDAS8_WITH_BL_CROSS_CP : cross DDR_READ_CG.RDAS8_CP,DDR_MR0_CG.DDR_BURST_LENGTH_CP {                                     
                                     bins rdas8_bl_cross = binsof(DDR_READ_CG.RDAS8_CP) intersect {1};
                                     } 
  endgroup

  /////////////////////////////////////////////////////
  // DDR write/read with auto_precharge cross Coverage
  ////////////////////////////////////////////////////

  covergroup DDR_WR_RD_WITH_AP_CROSS_CG;
    option.per_instance = 1;

    DDR_WR_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WR_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins wr_ap_cross = binsof(DDR_WRITE_CG.WR_CP) intersect {0};
                               }
    DDR_WRS4_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WRS4_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP{                                     
                                     bins wrs4_ap_cross = binsof(DDR_WRITE_CG.WRS4_CP) intersect {0};
                               }
    DDR_WRS8_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WRS8_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins wrs8_ap_cross = binsof(DDR_WRITE_CG.WRS8_CP) intersect {0};
                               }
    DDR_WRA_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WRA_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins wra_ap_cross = binsof(DDR_WRITE_CG.WRA_CP) intersect {1};
                               }
    DDR_WRAS4_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WRAS4_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins wras4_ap_cross = binsof(DDR_WRITE_CG.WRAS4_CP) intersect {1};
                               }
    DDR_WRAS8_WITH_AP_CROSS_CP : cross DDR_WRITE_CG.WRAS8_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins wrs8_ap_cross = binsof(DDR_WRITE_CG.WRAS8_CP) intersect {1};
                               }
    DDR_RD_WITH_AP_CROSS_CP : cross DDR_READ_CG.RD_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rd_ap_cross = binsof(DDR_READ_CG.RD_CP) intersect {0};
                               }
    DDR_RDS4_WITH_AP_CROSS_CP : cross DDR_READ_CG.RDS4_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rds4_ap_cross = binsof(DDR_READ_CG.RDS4_CP) intersect {0};
                               }
    DDR_RDS8_WITH_AP_CROSS_CP : cross DDR_READ_CG.RDS8_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rds8_ap_cross = binsof(DDR_READ_CG.RDS8_CP) intersect {0};
                               }
    DDR_RDA_WITH_AP_CROSS_CP : cross DDR_READ_CG.RDA_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rda_ap_cross = binsof(DDR_READ_CG.RDA_CP) intersect {1};
                               }
    DDR_RDAS4_WITH_AP_CROSS_CP : cross DDR_READ_CG.RDAS4_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rdad4_ap_cross = binsof(DDR_READ_CG.RDAS4_CP) intersect {1};
                               }
    DDR_RDAS8_WITH_AP_CROSS_CP : cross DDR_READ_CG.RDAS8_CP,DDR_AUTO_PRECGARE_PIN_CG.DDR_AP_CP {                                     
                                     bins rdas8_ap_cross = binsof(DDR_READ_CG.RDAS8_CP) intersect {1};
                               }
 endgroup

  /////////////////////////////////////////////////////
  // DDR command cross with column Coverage
  ////////////////////////////////////////////////////

  covergroup DDR_WR_RD_WITH_COL_ADDRESS_CROSS_CG;
    option.per_instance = 1;

    DDR_WR_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WR_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    DDR_WRS4_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WRS4_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    DDR_WRS8_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WRS8_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    DDR_WRA_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WRA_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    DDR_WRAS4_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WRAS4_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    DDR_WRAS8_WITH_COL_ADDRESS_CROSS_CP : cross DDR_WRITE_CG.WRAS8_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;                                
    
    DDR_RD_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RD_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;      
    DDR_RDS4_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RDS4_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;      
    DDR_RDS8_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RDS8_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;      
    DDR_RDA_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RDA_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;      
    DDR_RDAS4_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RDAS4_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP;      
    DDR_RDAS8_WITH_COL_ADDRESS_CROSS_CP : cross DDR_READ_CG.RDAS8_CP,DDR_ROW_COL_ADDRESS_CG.DDR_COL_ADDRESS_CP; 
  endgroup 

  /////////////////////////////////////////////////////
  // DDR act with all banks and row address Coverage
  ////////////////////////////////////////////////////

  covergroup DDR_ACT_WITH_ALL_BANKS_AND_ROW_ADDRESS_CROSS_CG;
    option.per_instance = 1;

    DDR_ACT_WITH_ALL_BANKS_CROSS_CP : cross DDR_ACTIVATION_CG.ACT_CP,DDR_BANK_ADDRESS_CG.DDR_BANK_ADDRESS_CP;                                
    DDR_ACT_WITH_ROW_ADDRESS_CROSS_CP : cross DDR_ACTIVATION_CG.ACT_CP,DDR_ROW_COL_ADDRESS_CG.DDR_ROW_ADDRESS_CP;   
                                
  endgroup 

  function new(virtual ddr_interface vif);
    this.vif = vif;
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
    DDR_ROW_COL_ADDRESS_CG = new();
    DDR_BANK_ADDRESS_CG = new();
    DDR_DATA_CG = new();
    DDR_MRS_INITIAL_TRANSACTION_CG = new();

    DDR_WR_RD_WITH_BL_CROSS_CG = new();
    DDR_WR_RD_WITH_AP_CROSS_CG = new();
    DDR_WR_RD_WITH_COL_ADDRESS_CROSS_CG = new();
    DDR_ACT_WITH_ALL_BANKS_AND_ROW_ADDRESS_CROSS_CG = new();

  endfunction
endclass
