`ifndef JTAGWIDTH8TEST_INCLUDED_
`define JTAGWIDTH8TEST_INCLUDED_

class JtagWidth8Test extends JtagBaseTest;
  `uvm_component_utils(JtagWidth8Test)

  extern function new(string name = "JtagWidth8Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagWidth8Test


function JtagWidth8Test :: new(string name = "JtagWidth8Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagWidth8Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
endfunction : build_phase



task  JtagWidth8Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
