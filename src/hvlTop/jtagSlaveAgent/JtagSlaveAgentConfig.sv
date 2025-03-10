`ifndef JTAGSLAVEAGENTCONFIG_INCLUDED_
`define JTAGSLAVEAGENTCONFIG_INCLUDED_

class JtagSlaveAgentConfig extends uvm_object;
  `uvm_object_utils(JtagSlaveAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum is_active;
  JtagTestVectorWidthEnum jtagTestVectorWidth;
  JtagInstructionWidthEnum jtagInstructionWidthEnum;
  JtagInstructionFlagEnum jtagInstructionFlag;
  JtagInstructionOpcodeEnum jtagInstructionOpcodeEnum;

  extern function new(string name = "JtagSlaveAgentConfig");
endclass : JtagSlaveAgentConfig

function JtagSlaveAgentConfig :: new(string name = "JtagSlaveAgentConfig");
  super.new(name);
endfunction  : new

`endif
