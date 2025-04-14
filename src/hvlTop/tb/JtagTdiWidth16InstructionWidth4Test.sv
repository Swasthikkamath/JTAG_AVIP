
`ifndef JTAGTDIWidth16INSTRUCTIONWIDTH4TEST_INCLUDED_
`define JTAGTDIWidth16INSTRUCTIONWIDTH4TEST_INCLUDED_

class JtagTdiWidth16InstructionWidth4Test extends JtagBaseTest;
  `uvm_component_utils( JtagTdiWidth16InstructionWidth4Test)

  extern function new(string name = "JtagTdiWidth16InstructionWidth4Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass :  JtagTdiWidth16InstructionWidth4Test

function  JtagTdiWidth16InstructionWidth4Test :: new(string name = "JtagTdiWidth16InstructionWidth4Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth16InstructionWidth4Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
endfunction : build_phase



task JtagTdiWidth16InstructionWidth4Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
