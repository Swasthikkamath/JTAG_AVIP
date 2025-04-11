`ifndef JTAGSLAVEMONITOR_INCLUDED_
`define JTAGSLAVEMONITOR_INCLUDED_

class JtagSlaveMonitor extends uvm_monitor; 
  `uvm_component_utils(JtagSlaveMonitor)
  
  uvm_analysis_port #(JtagSlaveTransaction)jtagSlaveMonitorAnalysisPort;
  virtual JtagSlaveMonitorBfm jtagSlaveMonitorBfm;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  JtagSlaveTransaction jtagSlaveTransaction;
  JtagConfigStruct jtagConfigStruct;
  JtagPacketStruct jtagPacketStruct;
  
  extern function new(string name = "JtagSlaveMonitor" , uvm_component parent);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : JtagSlaveMonitor

function JtagSlaveMonitor :: new( string name = "JtagSlaveMonitor" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagSlaveMonitor :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TP GET Slave AGENT CONFIG IN Slave MONITOR")

    if(!(uvm_config_db #(virtual JtagSlaveMonitorBfm) :: get(this,"","jtagSlaveMonitorBfm",jtagSlaveMonitorBfm)))
    `uvm_fatal(get_type_name(),"FAILED TO GET THE Slave MONITOR BFM IN Slave MONITOR")

      jtagSlaveTransaction = JtagSlaveTransaction :: type_id :: create("jtagSlaveTransaction");
  jtagSlaveMonitorAnalysisPort = new("jtagSlaveMonitorAnalysisPort",this);  
endfunction : build_phase

task JtagSlaveMonitor :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin 
    JtagSlaveConfigConverter :: fromClass (jtagSlaveAgentConfig , jtagConfigStruct);
 jtagSlaveMonitorBfm.waitForReset();
 jtagSlaveMonitorBfm.startMonitoring(jtagPacketStruct,jtagConfigStruct);
  JtagSlaveSeqItemConverter :: toClass (jtagPacketStruct , jtagConfigStruct , jtagSlaveTransaction);
  $display("*****************************************************************************************************************************************************************************************\n");
  $display("THE RECEIVED VECTOR IN TARGET IS %b and instruction is %b",jtagSlaveTransaction.jtagTestVector,jtagSlaveTransaction.jtagInstruction);
jtagSlaveMonitorAnalysisPort.write(jtagSlaveTransaction);
end 
endtask : run_phase
`endif
