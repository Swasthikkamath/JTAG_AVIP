`ifndef JTAGTDIWidth32TEST_INCLUDED_
`define JTAGTDIWidth32TEST_INCLUDED_

class JtagTdiWidth32Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth32Test)

  extern function new(string name = "JtagTdiWidth32Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth32Test


function JtagTdiWidth32Test :: new(string name = "JtagTdiWidth32Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth32Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
endfunction : build_phase



task  JtagTdiWidth32Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif



  
