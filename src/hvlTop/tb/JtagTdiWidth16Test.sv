`ifndef JTAGTDIWidth16TEST_INCLUDED_
`define JTAGTDIWidth16TEST_INCLUDED_

class JtagTdiWidth16Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth16Test)

  extern function new(string name = "JtagTdiWidth16Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth16Test


function JtagTdiWidth16Test :: new(string name = "JtagTdiWidth16Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth16Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
endfunction : build_phase



task  JtagTdiWidth16Test :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif



  
