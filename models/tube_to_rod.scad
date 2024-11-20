
SPINE=6.4;
TUBE=6.18;
$fn=40;

module clamp() {
    cylinder(d=SPINE*2+1, h=20, center=true);
}

module cylinder_hole(D, H) {
    rotate([90, 0])
        cylinder(d=D, h=H, center=true);
}

module clampies_neg() {
    translate([SPINE+2, -4.5])
        cylinder_hole(2.3, 10);
    translate([-SPINE-2, -2.5])
        cylinder_hole(3.2, 10);
    translate([-SPINE-2, -8])
        cylinder_hole(6.5, 10);
}

module clampies() {    
    hull() {
        translate([SPINE+2, -2.5])
            cylinder_hole(7, 6);

        translate([-SPINE-2, -1.5])
            cylinder_hole(7, 5);
    } 
}

module tube_channel_neg() {
    translate([0, -TUBE-2]) 
        cylinder(d=TUBE, h=30, center=true);
}

module tube_channel() {
    translate([0, -TUBE-2]) 
        cylinder(d=TUBE+4, h=20, center=true);
}

module spine() {
    cylinder(d=SPINE, h=50, center=true);
}

difference() {
    union() {
        hull() {
            clamp();
            //rotate([0, 45]) 
                tube_channel();
        }
        clampies();
    }
    spine();
    
    clampies_neg();
    
    translate([0, 9.75])
        cube([SPINE*2+20, 20, 21], center=true);
    //rotate([0, 45])
        tube_channel_neg();
}