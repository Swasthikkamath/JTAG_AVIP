`ifndef JTAGTDIWIDTH8BYPASSREGISTERTEST_INCLUDED_
`define JTAGTDIWIDTH8BYPASSREGISTERTEST_INCLUDED_

class JtagTdiWidth8BypassRegisterTest extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth8BypassRegisterTest)

  extern function new(string name = "JtagTdiWidth8BypassRegisterTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth8BypassRegisterTest


    function JtagTdiWidth8BypassRegisterTest :: new(string name = "JtagTdiWidth8BypassRegisterTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth8BypassRegisterTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
endfunction : build_phase



task  JtagTdiWidth8BypassRegisterTest :: run_phase(uvm_phase phase);
  jtagControllerDeviceTestingVirtualSequence = JtagControllerDeviceTestingVirtualSequence :: type_id :: create("JtagControllerDeviceTestingVirtualSequence");
  jtagControllerDeviceTestingVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDeviceTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
