`ifndef JTAGMASTERDRIVER_INCLUDED_
`define JTAGMASTERDRIVER_INCLUDED_

class JtagMasterDriver extends uvm_driver#(JtagMasterTransaction);
  `uvm_component_utils(JtagMasterDriver)
  virtual JtagMasterDriverBfm jtagMasterDriverBfm;
  JtagMasterAgentConfig jtagMasterAgentConfig;
  extern function new (string name = "JtagMasterDriver", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : JtagMasterDriver

function JtagMasterDriver::new(string name = "JtagMasterDriver",uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void JtagMasterDriver :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG IN MASTER DRIVER")

//    if(!(uvm_config_db #(JtagMasterDriverBfm) :: get(this,"","jtagMasterDriverBfm",jtagMasterDriverBfm)))
  //    `uvm_fatal(get_type_name(),"FAILED TO GET VIRTUAL POINTER TO MASTER DRIVERBFM IN MASTER DRIVER")
endfunction : build_phase

task JtagMasterDriver :: run_phase(uvm_phase phase);
  super.run_phase(phase);

  $display("ENTERED TO DRIVER PROXY SUCCESSFULLY");
  seq_item_port.get_next_item(req);
  #1000;
  seq_item_port.item_done(rsp);
endtask : run_phase

`endif
