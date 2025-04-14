

`ifndef JTAGTDIWIDTH24UDR_INCLUDED_
`define JTAGTDIWIDTH24UDR_INCLUDED_

class JtagTdiWidth24UDR extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth24UDR)

  extern function new(string name = "JtagTdiWidth24UDR" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth24UDR


    function JtagTdiWidth24UDR :: new(string name = "JtagTdiWidth24UDR" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth24UDR :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionOpcode = userDefinedRegister;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionOpcode = userDefinedRegister;
endfunction : build_phase



task  JtagTdiWidth24UDR :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
