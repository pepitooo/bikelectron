$fn=30;

pcb_thickness=1.6;
pcb_length=18;

top_block=[30,6,10];

wire_hole_diameter=3.05;

handle_size = 4;

module resistor_1206(){
  color([1,0,0.5])
    cube([3, 0.5, 1.5], 0);
}
module led_3528(){
  color([0,0,0.5])
    translate([0, -1.9, 0])
      cube([4.5, 1.9, 2.8], 0);
}

module pcb(thickness) {
  color([0,1,0.5])
    cube([pcb_length, thickness, 7], 0);
  
  //translate([7, thickness, 3]) resistor_1206();
  //translate([12, thickness, 3]) resistor_1206();
  //translate([6.3, 0, 2]) led_3528();
  //translate([11.3, 0, 2]) led_3528();
}

module handle() {
  color([1,0.7,0.5])
    translate([30/2 - handle_size + 0.1,-0.5,0]) {
      difference() {
        cube([handle_size, 9, 10]);
        translate([3.5, 0, 0])
          cube([.5,9,.3]);
      }
    }
}

module wire_pass_through(diameter) {
  //rotate([90,270,90])
  translate([14.1,0,1])
  rotate([0,270,0]) {
    //difference() {
    //  cube([9,6,3]);
      translate([3,3,-.1])
        cylinder(h = 11, d=diameter);
      translate([6,3,-.1])
        cylinder(h = 11, d=diameter);
      translate([4.5,3,-.1])
        cylinder(h = 11, d=diameter-1);
    }
}

module led_window() {
  color([1,0.7,0.5])
    //translate([12.5,-.1,2])
    translate([13.5,1.1,2])
      cube([10,5,5]);
}

module case() {  
  difference() {
    cube(top_block);
    led_window();
    wire_pass_through(wire_hole_diameter);
    translate([7,2,1]) pcb(pcb_thickness);
    translate([30 / 2, 0, 2]) {
      handle();
      mirror([1,0,0]) handle();
    }
  }
}

module slide_case() {
  //bottom part
  translate([0,10,0])
  difference() {
    case();
    translate([3,-0.5,2]) cube([25,7,11]);
  }  
  
  rotate([180,0,0])
    translate([0,-6,-10])
  difference() {
    case();
    translate([-.5,-0.5,-8.99]) cube([31,7,11]);
    translate([-.5,-0.5,]) cube([3,7,3]);
    translate([28,-0.5,]) cube([3,7,3]);
  }
}

slide_case();

