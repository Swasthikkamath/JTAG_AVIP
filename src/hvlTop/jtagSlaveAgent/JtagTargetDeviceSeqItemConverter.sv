`ifndef JTAGSLAVESEQITEMCONVERTER_INCLUDED_
`define JTAGSLAVESEQITEMCONVERTER_INCLUDED_

class JtagSlaveSeqItemConverter extends uvm_object;
  `uvm_object_utils(JtagSlaveSeqItemConverter)

  extern function new(string name = "JtagSlaveSeqItemConverter");
  extern static function void fromClass(input JtagSlaveTransaction jtagSlaveTransaction , input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  extern static function void toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct jtagConfigStruct , inout JtagSlaveTransaction jtagSlaveTransaction);
 
endclass : JtagSlaveSeqItemConverter 

function JtagSlaveSeqItemConverter :: new(string  name = "JtagSlaveSeqItemConverter");
  super.new(name);
endfunction : new


function void JtagSlaveSeqItemConverter :: fromClass(input JtagSlaveTransaction jtagSlaveTransaction ,          input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
 for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
    jtagPacketStruct.jtagTestVector[i] = jtagSlaveTransaction.jtagTestVector[i];


   

  // for(int i=0 ; i<32 ; i++)
  //  jtagPacketStruct.jtagTms[i]= jtagSlaveTransaction.jtagTms[i];
 endfunction : fromClass

function void JtagSlaveSeqItemConverter :: toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct  jtagConfigStruct , inout JtagSlaveTransaction jtagSlaveTransaction);
 //  for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
   //  jtagSlaveTransaction.jtagTestVector[i] = jtagPacketStruct.jtagTestVector[i];

  int j;
  j=0;

 /*
   case(jtagConfigStruct.jtagTestVectorWidth)
    'd 8 : jtagSlaveTransaction.jtagTestVector[7:0] = jtagPacketStruct.jtagTestVector[61:54];
    'd 16: jtagSlaveTransaction.jtagTestVector[15:0]= jtagPacketStruct.jtagTestVector[61:46];
    'd 24 : jtagSlaveTransaction.jtagTestVector[23:0] = jtagPacketStruct.jtagTestVector[61:38];
    'd 32 : jtagSlaveTransaction.jtagTestVector[31:0] = jtagPacketStruct.jtagTestVector[61:30];
   endcase
*/


  for (int i=0;i<=61;i++)
   if(!($isunknown(jtagPacketStruct.jtagTestVector[i]))) begin 
     jtagSlaveTransaction.jtagTestVector[j++] = jtagPacketStruct.jtagTestVector[i];
   end


   for (int i=0 ;i<jtagConfigStruct.jtagInstructionWidth ; i++)
     jtagSlaveTransaction.jtagInstruction[i] = jtagPacketStruct.jtagInstruction[i];

 endfunction : toClass

 `endif
