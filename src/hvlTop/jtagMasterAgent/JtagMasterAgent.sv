`ifndef JTAGMASTERAGENT_INCLUDED_
`define JTAGMASTERAGENT_INCLUDED_

class JtagMasterAgent extends uvm_agent;
  `uvm_component_utils(JtagMasterAgent)

  uvm_analysis_port #(JtagMasterTransaction) jtagMasterAnalysisPort;

  JtagMasterAgentConfig jtagMasterAgentConfig;

  JtagMasterDriver jtagMasterDriver;
 
  JtagMasterMonitor jtagMasterMonitor;

  JtagMasterSequencer jtagMasterSequencer;

  //JtagMasterCoverage jtagMasterCoverage;


  extern function new(string name ="JtagMasterAgent", uvm_component parent);
  
  extern virtual function void build_phase(uvm_phase phase);

  extern virtual function void connect_phase(uvm_phase phase);

endclass : JtagMasterAgent

function JtagMasterAgent :: new(string name ="JtagMasterAgent", uvm_component parent);
  super.new(name , parent);
endfunction  : new

function void  JtagMasterAgent ::build_phase (uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this ,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET AGENT CONFIG IN MASTER")

  

  if(jtagMasterAgentConfig.is_active == UVM_ACTIVE) begin 
    jtagMasterDriver = JtagMasterDriver :: type_id :: create("jtagMasterDriver",this);
    jtagMasterSequencer = JtagMasterSequencer :: type_id :: create("jtagMasterSequencer",this);
  end 

  jtagMasterMonitor = JtagMasterMonitor :: type_id :: create("jtagMasterMonitor",this);

  if(jtagMasterAgentConfig.hasCoverage == 1) begin 
   //jtagMasterCoverage = JtagMasterCoverage :: type_id :: create("jtagMasterCoverage",this);
  end

  jtagMasterAnalysisPort = new("jtagMasterAnalysisPort",this);
endfunction  : build_phase

function void JtagMasterAgent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(jtagMasterAgentConfig.is_active == UVM_ACTIVE) begin 
    $display("CONNECTING DRIVER AND SEQUENCER");
    jtagMasterDriver.seq_item_port.connect(jtagMasterSequencer.seq_item_export);
  end  

  if(jtagMasterAgentConfig.hasCoverage ==1) begin 
  //jtagMasterMonitor.jtagMasterMonitorAnalysisPort.connect(jtagMasterCoverage.analysis_export);
  end 

  jtagMasterMonitor.jtagMasterMonitorAnalysisPort.connect(this.jtagMasterAnalysisPort);
endfunction : connect_phase
`endif
