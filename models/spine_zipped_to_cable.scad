
SPINE=3.11;
$fn=30;

module clamp() {
    translate([0, -1])
        rotate([90, 0])
            cylinder(d=SPINE*2+1, h=18, center=true);

    translate([-4, -1, 1.7])
        cube([SPINE*2+1, 18, 3], center=true);    
    translate([-2.5, 0, -2.5])
        cube([SPINE*2+4.25, 20, 3], center=true);
}

module slot() {
    translate([-2, 0])
        cube([3.3, 21, 1.5], center=true);
}

module spine() {
    rotate([90, 0])
        #cylinder(d=SPINE, h=21, center=true);
}

module clamp_holes() {
    #translate([-5, 0]) {
        translate([0, 5]) 
            cylinder(d=3.5, h=5);

        translate([0, -7]) 
            cylinder(d=3.5, h=5);
    
        translate([0, 5]) 
            cylinder(d=2.1, h=20, center=true);

        translate([0, -7]) 
            cylinder(d=2.1, h=20, center=true);    
    }
}

module the_thing() {
    scale([2, 2, .5])
        sphere(d=8);

    translate([0,0, 8])
        scale([2, 2, .5])
            sphere(d=8);

    translate([5, 0, 5]) cylinder(d=3, h=8, center=true);
    translate([0, 5, 5]) cylinder(d=3, h=8, center=true);
    translate([-5, 0, 5]) cylinder(d=3, h=8, center=true);
    translate([0, -5, 5]) cylinder(d=3, h=8, center=true);
}


difference() {
    union() {
        translate([0,19,0])
            rotate([90, 0])
                the_thing();
        clamp();
    }
    spine();
    slot();
    
    clamp_holes();
}
