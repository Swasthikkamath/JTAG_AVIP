
`ifndef JTAGTDIWidth24INSTRUCTIONWIDTH4TEST_INCLUDED_
`define JTAGTDIWidth24INSTRUCTIONWIDTH4TEST_INCLUDED_

class JtagTdiWidth24InstructionWidth4Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth24Test)

  extern function new(string name = "JtagTdiWidth24InstructionWidth4Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth24Test

function JtagTdiWidth24Test :: new(string name = "JtagTdiWidth24InstructionWidth4Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth24InstructionWidth4Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
endfunction : build_phase



task JtagTdiWidth24InstructionWidth4Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
