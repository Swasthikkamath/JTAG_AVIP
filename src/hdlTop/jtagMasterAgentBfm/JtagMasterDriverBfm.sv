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
	

  task waitForReset();
    jtagTapState = jtagResetState;
  endtask : waitForReset
  task DriveToBfm(JtagPacketStruct jtagPacketStruct , JtagConfigStruct jtagConfigStruct);
    int  i,k ,m;
    i=0; 
    m=0;
    k=0;
    $display("THE RECEIVED IS %b i=%0d",jtagPacketStruct.jtagTms,i);
    for(int j=0 ; j< $bits(jtagPacketStruct.jtagTms);j++)
      begin
      @(posedge clk) jtagTms = jtagPacketStruct.jtagTms[i++];
        $display("THE STATE IN MASTER IS %s and tms is %b",jtagTapState.name(),jtagTms);
	case(jtagTapState)

          jtagResetState :begin 
          
	    if(jtagTms == 1) begin 
	      jtagTapState = jtagResetState;
	    end 
	    else if(jtagTms ==0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end


	  jtagIdleState : begin 
	   
	   if(jtagTms ==0) begin 
             jtagTapState = jtagIdleState;
	   end 
	   else if(jtagTms == 1) begin 
             jtagTapState = jtagDrScanState;
	   end 
	  end


          jtagDrScanState : begin 
	   
	   if(jtagTms == 1) begin 
             jtagTapState = jtagIrScanState;
	   end
	   else if(jtagTms == 0) begin 
             jtagTapState = jtagCaptureDrState;
	   end
	  end 

	  
	  jtagCaptureDrState : begin 
	    
	    if(jtagTms == 1) begin 
             jtagTapState = jtagExit1DrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagShiftDrState;
	    end 
	  end 

	  
	  jtagShiftDrState : begin 
           $display("### CONTROLLER DRIVER ### IS IN SHIFT DR STATE AT %0t\n",$time);	    
	    if(jtagTms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end 
	    jtagSerialIn=jtagPacketStruct.jtagTestVector[k++];
	  $display("### CONTROLLER DRIVER ### THE SERIAL DATA SENT OUT FROM CONTROLLER IS %b AT %0t \n",jtagSerialIn,$time);
	  end 
          
	  
	  jtagExit1DrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagPauseDrState;
	    end 

	  end 
          

          jtagPauseDrState : begin 
	    
	    if(jtagTms ==1) begin 
              jtagTapState = jtagExit2DrState;
 	    end 
	    else if(jtagTms ==0) begin
              jtagTapState = jtagPauseDrState;
	    end 
	  end 


          jtagExit2DrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
 	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftDrState;
            end 
	  end 

	  jtagUpdateDrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagDrScanState;
	    end  
	    else if(jtagTms == 0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end 

	  jtagIrScanState : begin 
	    
            if(jtagTms == 1) begin 
	      jtagTapState = jtagResetState;
            end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagCaptureIrState;
	    end
	  end 

	  jtagCaptureIrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
	  end 


	  jtagShiftIrState : begin 
            $display("### CONTROLLER DRIVER ### IS IN SHIFT IR STATE AT %0t \n",$time);
	    if(jtagTms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
	    jtagSerialIn = jtagConfigStruct.jtagInstructionOpcode[m++];
	    $display("### CONTROLLER DRIVER ### THE INSTRUCTION SENT OUT IS %b\n",jtagSerialIn);
	  end 
 
    
          jtagExit1IrState : begin 
            
 	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateIrState ;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end 
	  end 


	  jtagPauseIrState : begin 
  
            if(jtagTms == 1) begin 
              jtagTapState = jtagExit2IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end
	  end 

	  jtagExit2IrState : begin 
      
            if(jtagTms ==0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
	    else if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateIrState;
	    end 
	  end

	  jtagUpdateIrState: begin 
            
	    if(jtagTms == 1) begin 
	      jtagTapState = jtagDrScanState;
            end
	    else if(jtagTms == 0) begin 
               jtagTapState = jtagIdleState;
	    end
	  end 
          
	endcase  
           //@(posedge clk);
	   //$display("IN MASTER TMS IS %b @%0t",jtagTms,$time);
      end  
      @(posedge clk);
  endtask :DriveToBfm

	
endinterface : JtagMasterDriverBfm
