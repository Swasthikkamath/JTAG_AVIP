//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagMasterDriverBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagMasterDriverBfm (input  logic   clk,
                              input  logic   reset,
                             output logic  jtagSerialIn,
			     output logic jtagTms
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
  JtagTapStates jtagTapState; 
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_MASTERDRIVER_BFM"; 
	
  task DriveToBfm(JtagPacketStruct jtagPacketStruct , JtagConfigStruct jtagConfigStruct);
   
    int i;
    jtagTms = jtagPacketStruct.jtagTms[i++];
    jtagTapState = jtagIdleState;
    @(posedge clk);

    while(jtagTapState != jtagCaptureIrState)
     begin 
       @(posedge clk);
       jtagTapState = JtagTapStates'(i);
       jtagTms = jtagPacketStruct.jtagTms[i++];
     end 
    
    jtagSerialIn = jtagPacketStruct.jtagTestVector[0];
    @(posedge  clk);
    for(int i=1;i<jtagConfigStruct.jtagTestVectorWidth;i++)
     begin 
       @(posedge clk);
       jtagSerialIn = jtagPacketStruct.jtagTestVector[i];
       jtagTms=0;
     end 
     @(posedge clk);
    jtagTms = 1; 

      
  endtask :DriveToBfm

	
endinterface : JtagMasterDriverBfm
