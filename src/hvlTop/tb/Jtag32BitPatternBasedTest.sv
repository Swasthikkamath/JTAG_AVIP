

`ifndef JTAG32BitPATTERNBASEDTEST_INCLUDED_
`define JTAG32BitPATTERNBASEDTEST_INCLUDED_

class Jtag32BitPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(Jtag32BitPatternBasedTest)

  extern function new(string name = "Jtag32BitPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

 JtagMasterPatternBasedVirtualSequence jtagMasterPatternBasedVirtualSequence;
endclass : Jtag32BitPatternBasedTest

function Jtag32BitPatternBasedTest :: new(string name = "Jtag32BitPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void Jtag32BitPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagMasterAgentConfig.patternNeeded = 32'b 10101010;
endfunction : build_phase



task Jtag32BitPatternBasedTest :: run_phase(uvm_phase phase);
  jtagMasterPatternBasedVirtualSequence = JtagMasterPatternBasedVirtualSequence :: type_id :: create("JtagMasterPatternBasedVirtualSequence");
  jtagMasterPatternBasedVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterPatternBasedVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
