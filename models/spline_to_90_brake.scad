
SPINE=3.11;
BRAKE=1.35;
$fn=30;

module clamp() {
    rotate([90, 0])
        cylinder(d=SPINE*2+1, h=20, center=true);

    translate([-3.5, 0, 2.5])
        cube([SPINE*2+4.25, 17, 3], center=true);    
    translate([-3.5, 0, -2.5])
        cube([SPINE*2+4.25, 17, 3], center=true);
}

module clamp_holes() {
    translate([-5, 0]) {
        translate([0, 3]) 
            cylinder(d=3.5, h=5);

        translate([0, -3]) 
            cylinder(d=3.5, h=5);
    
        translate([0, 3]) 
            cylinder(d=2.1, h=20, center=true);

        translate([0, -3]) 
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


module brake_cable() {
    cylinder(d=BRAKE, h=50, center=true);
}

module ninety() {
    rotate([0, 90]) 
        difference() {
            cylinder(d=BRAKE*2+3.5, h=5, center=true);
            brake_cable();
        }
}

module parallel() {
    rotate([0 ,0, 90])
        ninety();
}

difference() {
    union() {
        clamp();
        translate([0, -8, -5.5]) 
            ninety();
        translate([0, -8, 5.5]) 
            ninety();
        
        translate([0, 7.5, 5.5])
            parallel();
        translate([0, 7.5, -5.5])
            parallel();
    }
    spine();
    slot();
    
    clamp_holes();
}