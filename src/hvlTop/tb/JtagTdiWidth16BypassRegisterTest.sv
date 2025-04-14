`ifndef JTAGTDIWIDTH16BYPASSREGISTERTEST_INCLUDED_
`define JTAGTDIWIDTH16BYPASSREGISTERTEST_INCLUDED_

class JtagTdiWidth16BypassRegisterTest extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth16BypassRegisterTest)

  extern function new(string name = "JtagTdiWidth16BypassRegisterTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth16BypassRegisterTest


    function JtagTdiWidth16BypassRegisterTest :: new(string name = "JtagTdiWidth16BypassRegisterTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth16BypassRegisterTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionOpcode = bypassRegister;
  jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionOpcode = bypassRegister;
  
endfunction : build_phase



task  JtagTdiWidth16BypassRegisterTest :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
