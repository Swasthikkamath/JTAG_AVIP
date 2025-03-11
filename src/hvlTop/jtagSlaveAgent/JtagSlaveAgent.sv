`ifndef JTAGSLAVEAGENT_INCLUDED_
`define JTAGSLAVEAGENT_INCLUDED_

class JtagSlaveAgent extends uvm_agent;
  `uvm_component_utils(JtagSlaveAgent)

  uvm_analysis_port #(JtagSlaveTransaction) jtagSlaveAnalysisPort;
//  JtagSlaveCoverage jtagSlaveCoverage;
  JtagSlaveMonitor jtagSlaveMonitor;
  JtagSlaveDriver jtagSlaveDriver;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  JtagSlaveSequencer jtagSlaveSequencer;
  extern function new(string name = "JtagSlaveAgent" , uvm_component parent);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : JtagSlaveAgent 

function JtagSlaveAgent::new(string name = "JtagSlaveAgent",uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagSlaveAgent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET SLAVE CONFIG")

  if(jtagSlaveAgentConfig.is_active == UVM_ACTIVE ) begin 
    jtagSlaveDriver = JtagSlaveDriver  :: type_id :: create("jtagSlaveDriver",this);
    jtagSlaveSequencer  = JtagSlaveSequencer :: type_id :: create("jtagSlaveSequencer",this);
  end 
   
  if(jtagSlaveAgentConfig.hasCoverage==1) begin 
  //  jtagSlaveCoverage = JtagSlaveCoverage  :: type_id ::create("jtagSlaveCoverage",this);
  end 

  jtagSlaveMonitor = JtagSlaveMonitor :: type_id :: create("jtagSlaveMonitor",this);
  jtagSlaveAnalysisPort = new("jtagSlaveAnalysisPort",this);
endfunction :  build_phase

function void JtagSlaveAgent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(jtagSlaveAgentConfig.is_active ==UVM_ACTIVE ) begin 
    jtagSlaveDriver.seq_item_port.connect(jtagSlaveSequencer.seq_item_export);
  end 

  if(jtagSlaveAgentConfig.hasCoverage ==1) begin
    //jtagSlaveMonitor.jtagSlaveMonitorAnalysisPort.connect(jtagSlaveCoverage.analysis_export);
  end   

  jtagSlaveMonitor.jtagSlaveMonitorAnalysisPort.connect(this.jtagSlaveAnalysisPort);

endfunction  : connect_phase
`endif
