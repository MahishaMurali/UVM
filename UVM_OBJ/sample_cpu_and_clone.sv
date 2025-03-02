`include "uvm_macros.svh"
import uvm_pkg::*; 
class sample extends uvm_object;

  rand int a;
function new(string path = "sample");
super.new(path);
endfunction
  `uvm_object_utils_begin(sample)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass
module tb;
sample s1,s2;
initial begin 
  s1=new("s1");
  //s2=new("s2")
  s1.randomize();
  $cast(s2,s1.clone());
  s1.print();
  s2.print();
  //`uvm_info("TB", $sformatf("the value of a: %0d", o.a),UVM_NONE);
end
endmodule
