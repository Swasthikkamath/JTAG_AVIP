
`ifndef JTAGPATTERNBASEDTEST_INCLUDED_
`define JTAGPATTERNBASEDTEST_INCLUDED_

class JtagPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(JtagPatternBasedTest)

  extern function new(string name = "JtagPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

 JtagMasterPatternBasedVirtualSequence jtagMasterPatternBasedVirtualSequence;
endclass : JtagPatternBasedTest

function JtagPatternBasedTest :: new(string name = "JtagPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagMasterAgentConfig.patternNeeded = 8'b 10101010;
endfunction : build_phase



task JtagPatternBasedTest :: run_phase(uvm_phase phase);
  jtagMasterPatternBasedVirtualSequence = JtagMasterPatternBasedVirtualSequence :: type_id :: create("JtagMasterPatternBasedVirtualSequence");
  jtagMasterPatternBasedVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterPatternBasedVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
