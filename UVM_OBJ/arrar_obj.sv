// to leverage the use of UVM_automation 
//we need to register the variable with the factory

`include "uvm_macros.svh"
import uvm_pkg::*; 
class array extends uvm_object;
//`uvm_object_utils(sample)
  int arr1[3] = {1,2,3};
  int arr2[];
  int arr3[$];
  int arr4[int];
  function new(string path = "array");
   super.new(path);
   endfunction
  `uvm_object_utils_begin(array)//registering varaiables to the factory
  `uvm_field_sarray_int(arr1,UVM_DEFAULT);
  `uvm_field_array_int(arr2,UVM_DEFAULT);
  `uvm_field_queue_int(arr3,UVM_DEFAULT);
  `uvm_field_aa_int_int(arr4,UVM_DEFAULT);
  `uvm_object_utils_end
  task run();
    arr2=new[3];
    arr2[0]=2;
    arr2[1]=2;
    arr2[2]=2;
    arr3.push_front(3);
    arr3.push_front(3);
    arr4[1]=4;
    arr4[2]=4;
    arr4[3]=4;
  endtask
endclass
module tb;
array arr;
initial begin
  arr=new("array");
  arr.run();
  arr.print(uvm_default_line_printer); 
end
endmodule
