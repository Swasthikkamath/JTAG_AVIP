
`ifndef JTAG8BitPATTERNBASEDTEST_INCLUDED_
`define JTAG8BitPATTERNBASEDTEST_INCLUDED_

class Jtag8BitPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(Jtag8BitPatternBasedTest)

  extern function new(string name = "Jtag8BitPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

 JtagMasterPatternBasedVirtualSequence jtagMasterPatternBasedVirtualSequence;
endclass : Jtag8BitPatternBasedTest

function Jtag8BitPatternBasedTest :: new(string name = "Jtag8BitPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void Jtag8BitPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagMasterAgentConfig.patternNeeded = 8'b 10101010;
endfunction : build_phase



task Jtag8BitPatternBasedTest :: run_phase(uvm_phase phase);
  jtagMasterPatternBasedVirtualSequence = JtagMasterPatternBasedVirtualSequence :: type_id :: create("JtagMasterPatternBasedVirtualSequence");
  jtagMasterPatternBasedVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(NO_OF_TESTS) begin 
  jtagMasterPatternBasedVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
