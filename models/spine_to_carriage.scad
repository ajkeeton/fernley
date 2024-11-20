
SPINE=3.11;
$fn=30;

module _clamp() {
    difference() {
        union() {
            rotate([90, 0])
                cylinder(d=SPINE*2+1, h=18, center=true);

            translate([-3.5, 0, 2.2])
                cube([SPINE*2+4, 18, 3], center=true);    
            translate([-2.5, 0, -2.5])
                cube([SPINE*2+5.25, 18, 3], center=true);
            }
        spine();
        slot();
        clamp_holes();
    }
}


module screw_hole() {
    cylinder(d=3, h=15, center=true);
}

module carriage_holes_custom() {
    //translate([-4, -7]) screw_hole();
    translate([-4, 7]) screw_hole();
    translate([-10, -3]) screw_hole();
    translate([-10, 3]) screw_hole();

    //translate([4, -7]) screw_hole();
    translate([4, 7]) screw_hole();
    //translate([10, -3]) screw_hole();
    //translate([10, 3]) screw_hole();
    
    //translate([4, -12, -10]) screw_hole();
    //translate([4, 12, -10]) screw_hole();    
    //translate([-4, -12, -10]) screw_hole();
    //translate([-4, 12, -10]) screw_hole();    
}

module clamp_holes() {
    translate([-5, 0]) {
        translate([0, 5]) 
            cylinder(d=3.5, h=5);

        translate([0, -5]) 
            cylinder(d=3.5, h=5);
    
        translate([0, 5]) 
            cylinder(d=2.1, h=20, center=true);

        translate([0, -5]) 
            cylinder(d=2.1, h=20, center=true);    
    }
}

module slot() {
    translate([-2, 0])
        cube([4, 30, 1.5], center=true);
}

module spine() {
    rotate([90, 0])
        cylinder(d=SPINE, h=50, center=true);
}

module carriage() {
    difference() {
        cube([27, 27, 4], center=true);
        translate([0, 0]) {
            translate([10, 10]) 
                cylinder(d=3.2, h=15, center=true);

            translate([-10, -10]) 
                cylinder(d=3.2, h=15, center=true);

            translate([-10, 10]) 
                cylinder(d=3.2, h=15, center=true);

            translate([10, -10]) 
                cylinder(d=3.2, h=15, center=true);    
        }
    }
}

module base() {
    difference() {
        cube([25,25,3], center=true);
            carriage_holes_custom();
        
        translate([3.5, -.25, 5]) 
            rotate([0,0,90])
                clamp_holes();
    }
}

module clamps() {
    translate([3.5, -.25, 5]) 
        rotate([0,0,90])
            _clamp();
   // translate([0, 9, 5]) 
   //     rotate([0,0,-90])
   //         _clamp();    
}

clamps();
base();

/*
difference() {
    union() {
        //translate([0, 0, 5])
            clamp();
        translate([0,0,-5])
            base();
        //translate([0, 0,-6]) carriage();
        //carriage_custom();
    }
    //translate([0, 0, 5]) {
       # spine();
       # slot();
       clamp_holes_basic();
    //}
    
    //clamp_holes_custom();
}
*/