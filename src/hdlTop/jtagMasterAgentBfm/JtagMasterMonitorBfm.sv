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
                             input logic  jtagSerialIn
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
	
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagMasterPkg::*;
  
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_MASTER_MONITOR_BFM"; 
	
  

	
endinterface : JtagMasterMonitorBfm
