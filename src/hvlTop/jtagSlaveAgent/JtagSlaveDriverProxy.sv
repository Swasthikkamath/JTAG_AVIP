`ifndef JTAGSLAVEDRIVER_INCLUDED_
`define JTAGSLAVEDRIVER_INCLUDED_

class JtagSlaveDriver extends uvm_driver#(JtagSlaveTransaction);
  `uvm_component_utils(JtagSlaveDriver)
  virtual JtagSlaveDriverBfm jtagSlaveDriverBfm;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  extern function new (string name = "JtagSlaveDriver", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : JtagSlaveDriver

function JtagSlaveDriver::new(string name = "JtagSlaveDriver",uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void JtagSlaveDriver :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG IN Slave DRIVER")

//    if(!(uvm_config_db #(JtagSlaveDriverBfm) :: get(this,"","jtagSlaveDriverBfm",jtagSlaveDriverBfm)))
  //    `uvm_fatal(get_type_name(),"FAILED TO GET VIRTUAL POINTER TO Slave DRIVERBFM IN Slave DRIVER")
endfunction : build_phase

task JtagSlaveDriver :: run_phase(uvm_phase phase);
  super.run_phase(phase);
endtask : run_phase

`endif
