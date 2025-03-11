`ifndef JTAGENV_INCLUDED_
`define JTAGENV_INCLUDED_

class JtagEnv extends uvm_env;
  `uvm_component_utils(JtagEnv)

  JtagEnvConfig jtagEnvConfig;
  JtagScoreboard jtagScoreboard;
  JtagVirtualSequencer jtagVirtualSequencer;
  JtagMasterAgent jtagMasterAgent;
  JtagSlaveAgent jtagSlaveAgent;
  
  extern function new(string name = "JtagEnv" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : JtagEnv

function JtagEnv :: new( string name = "JtagEnv" , uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagEnv :: build_phase(uvm_phase phase);

  if(!(uvm_config_db #(JtagEnvConfig) :: get(this,"","jtagEnvConfig",jtagEnvConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET ENV CONFIG")

  if(jtagEnvConfig.hasScoreboard) begin 
    jtagScoreboard = JtagScoreboard :: type_id :: create("JtagScoreboard",this);
  end 

  if(jtagEnvConfig.hasVirtualSequencer) begin 
    jtagVirtualSequencer = JtagVirtualSequencer :: type_id :: create("JtagVirtualSequencer",this);
  end


  jtagMasterAgent = JtagMasterAgent :: type_id :: create("JtagMasterAgent",this);
  jtagSlaveAgent = JtagSlaveAgent :: type_id :: create("JtagSlaveAgent",this);
endfunction : build_phase

function void JtagEnv :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(jtagEnvConfig.hasScoreboard) begin 
    jtagMasterAgent.jtagMasterAnalysisPort.connect(jtagScoreboard.jtagScoreboardMasterAnalysisExport);
    jtagSlaveAgent.jtagSlaveAnalysisPort.connect(jtagScoreboard.jtagScoreboardSlaveAnalysisExport);
  end 

  if(jtagEnvConfig.hasVirtualSequencer)begin 

   jtagVirtualSequencer.jtagMasterSequencer = jtagMasterAgent.jtagMasterSequencer;
   jtagVirtualSequencer.jtagSlaveSequencer = jtagSlaveAgent.jtagSlaveSequencer;
  end 

endfunction : connect_phase

`endif





