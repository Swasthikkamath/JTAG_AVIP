//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagMasterMonitorBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagMasterMonitorBfm (input  logic   clk,
                              input  logic   reset,
                             input logic  jtagSerialIn,
			     input logic jtagTms
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  JtagTapStates jtagTapState;	
  reg[31:0] temp;
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagMasterPkg::*;
  
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_MASTER_MONITOR_BFM"; 
	
  
task startMonitoring(output JtagPacketStruct jtagPacketStruct,input JtagConfigStruct jtagConfigStruct);
   @(posedge jtagSerialIn or negedge jtagSerialIn);
   repeat(jtagConfigStruct.jtagInstructionWidth) begin 
     repeat(1)@(posedge clk);
     jtagPacketStruct. 


   
endtask 
	
endinterface : JtagMasterMonitorBfm
