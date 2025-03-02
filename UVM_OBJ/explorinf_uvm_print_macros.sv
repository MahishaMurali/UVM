// to leverage the use of UVM_automation 
//we need to register the variable with the factory

`include "uvm_macros.svh"
import uvm_pkg::*; 
class sample extends uvm_object;
//`uvm_object_utils(sample)
function new(string path = "sample");
super.new(path);
endfunction
  `uvm_object_utils_begin(sample)//registering varaiables to the factory
  `uvm_field_int(a,UVM_BIN)
  `uvm_object_utils_end
  rand bit [4:0] a;
endclass
module tb;
sample s;
initial begin
  s=new("sample");
  repeat(5) begin
  s.randomize();
    // uvm automation
    s.print(uvm_default_tree_printer);// .print()-> field macros so this is not run time efficient 
    s.print(uvm_default_table_printer);
    s.print(uvm_default_line_printer);
    //`uvm_info("TB", $sformatf("the value of a: %0b", s.a),UVM_NONE);
end
end
endmodule
