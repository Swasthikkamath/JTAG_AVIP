
`ifndef JTAGMASTERPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_
`define JTAGMASTERPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_

class JtagMasterPatternBasedVirtualSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagMasterPatternBasedVirtualSequence)

  JtagMasterPatternBasedSequence jtagMasterPatternBasedSequence;
  JtagSlaveBaseSequence  jtagSlaveBaseSequence;
  JtagMasterAgentConfig jtagMasterAgentConfig;

  extern function new(string name = "JtagMasterPatternBasedVirtualSequence");
  extern virtual task body();
  extern task setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
endclass : JtagMasterPatternBasedVirtualSequence 


function JtagMasterPatternBasedVirtualSequence ::new(string name = "JtagMasterPatternBasedVirtualSequence");
  super.new(name);
endfunction  : new

task JtagMasterPatternBasedVirtualSequence :: body();
  super.body();
  `uvm_do_on_with(jtagMasterPatternBasedSequence,p_sequencer.jtagMasterSequencer,{patternNeeded == jtagMasterAgentConfig.patternNeeded;})
endtask : body 

task JtagMasterPatternBasedVirtualSequence :: setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
  this.jtagMasterAgentConfig = jtagMasterAgentConfig;
endtask : setConfig
 
`endif
