`ifndef JTAGMASTERAGENTCONFIG_INCLUDED_
`define JTAGMASTERAGENTCONFIG_INCLUDED_

class JtagMasterAgentConfig extends uvm_object;

  `uvm_object_utils(JtagMasterAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum   is_active;
  JtagTestVectorWidthEnum   jtagTestVectorWidth;
  JtagInstructionWidthEnum  jtagInstructionWidth;
  JtagInstructionFlagEnum   jtagInstructionFlag;
  JtagInstructionOpcodeEnum jtagInstructionOpcode;
  int NumberOfTests =10;

  extern function new(string name = "JtagMasterAgentConfig");

endclass : JtagMasterAgentConfig

function JtagMasterAgentConfig :: new(string name = "JtagMasterAgentConfig");
  super.new(name);
endfunction : new
`endif
