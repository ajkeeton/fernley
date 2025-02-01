DIAM=100;
TUBE=.756*25.4;
ANGLE=20;

use <vert_flat_wide.scad>

module body() {
    sphere(d=DIAM);
}

module tube() {
    cube([TUBE, TUBE, DIAM*2], center=true);
}

module platform() {
   translate([DIAM/2, 0, -2])
        rotate([0, ANGLE, 0])
            //cube([6, 50, 20], center=true);
            scale([1,2.5,1])
                cylinder(d=22, h=10, center=true);
}

module platforms() {
    hull() 
        for(i = [0, 120, 240])
            rotate([0, 0, i])
                platform();                               
}

difference() {
    union() {
        body();
        translate([0, 0, 5])
        platforms();
    }
    
    translate([0, 0, 1])
        sphere(d=DIAM-5);

    translate([0, 0, DIAM*.7])
        cube([DIAM, DIAM, DIAM], center=true);
    
    //translate([0, 0, -DIAM*.95])
    //    cube([DIAM, DIAM, DIAM], center=true);
    tube();
    
    for(i = [0, 120, 240])
        rotate([0, 0, 30+i])
            translate([0, 15+DIAM/2, 15])
                rotate([180-ANGLE, 0]) {
                    base_neg();
                    vert_neg(75);
                    
                    translate([0, 5, 29])
                        cylinder(d=15, h=20, center=true);
                 }

    translate([0, 0, -DIAM/2])
        cube([DIAM, DIAM, 20], center=true);
}


difference() {
    translate([0, 0, -DIAM/2+19.5]) {
        cube([TUBE+4, TUBE+4, 20], center=true);
        //translate([0, 0, -7]) 
        //    cube([DIAM/2+30, 5, 5], center=true);
        translate([0, 0, -9]) 
            cylinder(d=55, h=5, center=true);
    }
    tube();

        translate([0, 0, -DIAM/2])
        cube([DIAM, DIAM, 20], center=true);
}

