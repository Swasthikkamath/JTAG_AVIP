`ifndef JTAGMASTERSEQITEMCONVERTER_INCLUDED_
`define JTAGMASTERSEQITEMCONVERTER_INCLUDED_

class JtagMasterSeqItemConverter extends uvm_object;
  `uvm_object_utils(JtagMasterSeqItemConverter)

  extern function new(string name = "JtagMasterSeqItemConverter");
  extern static function void fromClass(input JtagMasterTransaction jtagMasterTransaction , input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  extern static function void toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct jtagConfigStruct , inout JtagMasterTransaction jtagMasterTransaction);
 
endclass : JtagMasterSeqItemConverter 

function JtagMasterSeqItemConverter :: new(string  name = "JtagMasterSeqItemConverter");
  super.new(name);
endfunction : new


function void JtagMasterSeqItemConverter :: fromClass(input JtagMasterTransaction jtagMasterTransaction ,          input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
    jtagPacketStruct.jtagTestVector[i] = jtagMasterTransaction.jtagTestVector[i];

  for(int i=0 ; i<32 ; i++)
   jtagPacketStruct.jtagTms[i]= jtagMasterTransaction.jtagTms[i];
 endfunction : fromClass

function void JtagMasterSeqItemConverter :: toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct  jtagConfigStruct , inout JtagMasterTransaction jtagMasterTransaction);
   //for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
     //jtagMasterTransaction.jtagTestVector[i] = jtagPacketStruct.jtagTestVector[i];


   case(jtagConfigStruct.jtagTestVectorWidth)
       'd 8 : jtagMasterTransaction.jtagTestVector[7:0] = jtagPacketStruct.jtagTestVector[53:46];
           'd 16: jtagMasterTransaction.jtagTestVector[15:0]= jtagPacketStruct.jtagTestVector[45:30];
	       'd 24 : jtagMasterTransaction.jtagTestVector[23:0] = jtagPacketStruct.jtagTestVector[37:14];
	           'd 32 : jtagMasterTransaction.jtagTestVector[31:0] = jtagPacketStruct.jtagTestVector[31:0];
		      endcase

   for (int i=0 ;i<jtagPacketStruct.jtagInstruction ; i++)
     jtagMasterTransaction.jtagInstruction = jtagPacketStruct.jtagInstruction[i];

 endfunction : toClass

 `endif
