
`ifndef JTAGTDIWIDTH16UDR_INCLUDED_
`define JTAGTDIWIDTH16UDR_INCLUDED_

class JtagTdiWidth16UDR extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth16UDR)

  extern function new(string name = "JtagTdiWidth16UDR" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth16UDR


    function JtagTdiWidth16UDR :: new(string name = "JtagTdiWidth16UDR" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth16UDR :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagMasterAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
   jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagMasterAgentConfig.jtagInstructionOpcode = userDefinedRegister;
  jtagEnvConfig.jtagSlaveAgentConfig.jtagInstructionOpcode = userDefinedRegister;
endfunction : build_phase



task  JtagTdiWidth16UDR :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
 
  phase.raise_objection(this);
  repeat(2) begin 
  jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
