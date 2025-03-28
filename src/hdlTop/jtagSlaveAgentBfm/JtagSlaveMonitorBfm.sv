//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagSlaveMonitorBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagSlaveMonitorBfm (input  logic   clk,
                              input  logic   reset,
                             input logic  jtagSerialIn,
			     input logic jtagTms
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
	
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagSlavePkg::*;
  JtagTapStates jtagTapState;
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_Slave_MONITOR_BFM"; 

  task startMonitoring(output JtagPacketStruct jtagPacketStruct,input JtagConfigStruct jtagConfigStruct);
  int  i,k ,m;
    for(int j=0 ; j<$bits(jtagPacketStruct.jtagTms);j++)
      begin
        @(posedge clk);

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
	    
	    if(jtagTms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end 
		  jtagPacketStruct.jtagTestVector = {jtagSerialIn , jtagPacketStruct.jtagTestVector[61:1]};       
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

	    if(jtagTms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
		  jtagPacketStruct.jtagInstruction[m++] = jtagSerialIn;
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
	      $display("********************\n  in SLAVE THE STATE IS %s @%t and jtag instruction obtained is %b and data is %b",jtagTapState.name(),$time,jtagPacketStruct.jtagInstruction,jtagPacketStruct.jtagTestVector);
      end  


  
  endtask 
	
endinterface : JtagSlaveMonitorBfm
