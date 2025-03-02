// to leverage the use of UVM_automation 
//we need to register the variable with the factory

`include "uvm_macros.svh"
import uvm_pkg::*; 
class sample extends uvm_object;
//`uvm_object_utils(sample)
  typedef enum bit [1:0] {s0,s1,s2,s3} state;
  rand state s;
function new(string path = "sample");
super.new(path);
endfunction
  `uvm_object_utils_begin(sample)//registering varaiables to the factory
  `uvm_field_enum(state,s,UVM_DEFAULT)
  `uvm_object_utils_end

endclass
module tb;
sample s;
initial begin
  s=new("sample");
  repeat(5) begin
  s.randomize();
    // uvm automation
    s.print(uvm_default_tree_printer);// .print()-> field macros so this is 
    
end
end
endmodule
