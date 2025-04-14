
`ifndef JTAGPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_
`define JTAGPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_

class JtagPatternBasedVirtualSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagPatternBasedVirtualSequence)

  JtagMasterPatternBasedSequence jtagMasterPatternBasedSequence;
  JtagSlaveBaseSequence  jtagSlaveBaseSequence;
  JtagMasterAgentConfig jtagMasterAgentConfig;

  extern function new(string name = "JtagPatternBasedVirtualSequence");
  extern virtual task body();
  extern task setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
endclass : JtagPatternBasedVirtualSequence 


function JtagPatternBasedVirtualSequence ::new(string name = "JtagPatternBasedVirtualSequence");
  super.new(name);
endfunction  : new

task JtagPatternBasedVirtualSequence :: body();
  super.body();
  `uvm_do_on_with(jtagMasterPatternBasedSequence,p_sequencer.jtagMasterSequencer,{patternNeeded == jtagMasterAgentConfig.patternNeeded;})
endtask : body 

task JtagPatternBasedVirtualSequence :: setConfig(JtagMasterAgentConfig jtagMasterAgentConfig);
  this.jtagMasterAgentConfig = jtagMasterAgentConfig;
endtask : setConfig
 
`endif
