`ifndef JTAGSCOREBOARD_INCLUDED_
`define JTAGSCOREBOARD_INCLUDED_

class JtagScoreboard extends uvm_scoreboard;
 `uvm_component_utils(JtagScoreboard)

 uvm_analysis_export #(JtagMasterTransaction) jtagScoreboarMasterAnalysisExport;
 uvm_analysis_export #(JtagSlaveTransaction)  jtagScoreboardSlaveAnalysisExport;

 uvm_tlm_analysis_fifo #(JtagMasterTransaction) jtagScoreboardMasterAnalysisFifo;
 uvm_tlm_analysis_fifo #(JtagSlaveTransaction) jtagScoreboardSlaveAnalysisFifo; 
 
 extern function new(string name = "JtagScoreboard" , uvm_component parent);
 extern virtual function void build_phase(uvm_phase phase);
 extern virtual function void connect_phase(uvm_phase phase);
 extern virtual task run_phase(uvm_phase phase);

endclass : JtagScoreboard


function JtagScoreboard  :: new (string name = "JtagScoreboard",uvm_component parent);
  super.new(name,parent);
endfunction : new

function JtagScoreboard :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagScoreboarMasterAnalysisExport = new("jtagScoreboarMasterAnalysisExport",this);
  jtagScoreboardSlaveAnalysisExport = new("jtagScoreboardSlaveAnalysisExport",this);
  jtagScoreboardMasterAnalysisFifo = new("jtagScoreboardMasterAnalysisFifo",this);
  jtagScoreboardSlaveAnalysisFifo = new("jtagScoreboardSlaveAnalysisFifo",this);
 
endfunction : build_phase

function JtagScoreboard :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  jtagScoreboarMasterAnalysisExport.connect(jtagScoreboardMasterAnalysisFifo.analysis_export);
  jtagScoreboardSlaveAnalysisExport.connect(jtagScoreboardSlaveAnalysisFifo.analysis_export);

endfunction:connect_phase

task JtagScoreboard :: run_phase(uvm_phase phase);
  super.run_phase(phase);
endtask : JtagScoreboard 

`endif
