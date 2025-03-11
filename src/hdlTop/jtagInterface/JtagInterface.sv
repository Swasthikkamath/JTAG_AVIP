//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------

import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagIf
// Declaration of pin level signals for Jtag interface
//--------------------------------------------------------------------------------------------

interface JtagIf (input clk, input reset);
  
  logic jtagSerialIn;

  logic jtagSerialOut;

  logic jtagTms;
  
endinterface : JtagIf 
