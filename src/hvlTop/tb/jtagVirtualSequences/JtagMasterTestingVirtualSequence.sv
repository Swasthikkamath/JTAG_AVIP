`ifndef JTAGMASTERTESTINGVIRTUALSEQUENCE_INCLUDED_
`define JTAGMASTERTESTINGVIRTUALSEQUENCE_INCLUDED_

class JtagMasterTestingVirtualSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagMasterTestingVirtualSequence)

  JtagMasterBaseSequence jtagMasterBaseSequence;
  JtagSlaveBaseSequence  jtagSlaveBaseSequence;
  JtagMasterAgentConfig jtagMasterAgentConfig;

  extern function new(string name = "JtagMasterTestingVirtualSequence");
  extern virtual task body();
  extern task setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
endclass : JtagMasterTestingVirtualSequence 


function JtagMasterTestingVirtualSequence ::new(string name = "JtagMasterTestingVirtualSequence");
  super.new(name);
endfunction  : new

task JtagMasterTestingVirtualSequence :: body();
  super.body();
  `uvm_do_on_with(jtagMasterBaseSequence,p_sequencer.jtagMasterSequencer,{numberOfTests == jtagMasterAgentConfig.NumberOfTests;})
endtask : body 

task JtagMasterTestingVirtualSequence :: setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
  this.jtagMasterAgentConfig = jtagMasterAgentConfig;
endtask : setConfig
 
`endif
