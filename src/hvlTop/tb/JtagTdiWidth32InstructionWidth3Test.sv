
`ifndef JTAGTDIWidth32INSTRUCTIONWIDTH3TEST_INCLUDED_
`define JTAGTDIWidth32INSTRUCTIONWIDTH3TEST_INCLUDED_

class JtagTdiWidth32InstructionWidth3Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth32InstructionWidth3Test)

  extern function new(string name = "JtagTdiWidth32InstructionWidth3Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth32InstructionWidth3Test

function JtagTdiWidth32InstructionWidth3Test :: new(string name = "JtagTdiWidth32InstructionWidth3Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth32InstructionWidth3Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
endfunction : build_phase



task JtagTdiWidth32InstructionWidth3Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
