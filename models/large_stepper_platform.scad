/*
NOTE:
    top of rod is 19.7mm
    half rod diam: 4mm
    bearing center: 19.7-4 = 15.7mm
    stepper center: 42.3/2 = 21.15mm
        diff: 5.45
*/
NEMA_DROP = 5.45; // see notes above

// Rods are 10"
// Prusa print surface is around 8" (M2 is technically 10")
LENGTH = 25.4*8;
WIDTH = 55;
HEIGHT = 4;
BEARING_HOLES = 4.7;

STEP = 42.35;
STEP_HOLES = 3;
$fn=30;

// space for the coupler 
SPACE_C = 26;


module triangle() {
    rotate([0, -90, -90])
        translate([0,0, -1.5])
            linear_extrude(height=3) 
                polygon(points=[[0,0],[30,0],[0,-30]], paths=[[0,1,2]]);
}

module nema_bevel() {
    translate([2.5, 0, -STEP/2 - NEMA_DROP + 5.45]) {
        translate([0, STEP/2]) 
            triangle();
        translate([0, -STEP/2]) 
            triangle();
    }
}

module nema_screw() {
    cylinder(d=STEP_HOLES, h=10);
    
    // room at the base
    translate([0, 0, 7.5])
        cylinder(d=STEP_HOLES+5, h=20);
}

module nema_neg() {
    translate([-LENGTH/2+2.5-30, 0, STEP/2+2]) {
        rotate([90, 0, 90]) {
            translate([0, 0, -5]) {
                // screw holes are 31mm apart
                translate([-31/2, 31/2]) {
                    nema_screw();
                }
                translate([31/2, -31/2]) {
                    nema_screw();
                }
                translate([31/2, 31/2]) {
                    nema_screw();
                }
                translate([-31/2, -31/2]) {
                    nema_screw();
                }
                
                cylinder(d=22.25, h=10);
            }
        }
    
        translate([-23.5, 0])
            cube([STEP, STEP, STEP], center=true);
    }
}

module lower_plate_rear() {
    translate([0, 0, -HEIGHT-2])
        difference() {
            translate([-LENGTH/2-15, 0]) {
                cube([100, WIDTH, HEIGHT*2], center=true);

            }
            bearing_holes();
            translate([-LENGTH/2, 0])
                cube([50, 30, 10], center=true);
            translate([-LENGTH/2-45, 0])
                cube([30, 20, 10], center=true);
        }   
}
             
module _nema_mount() {
    translate([-LENGTH/2+2.5-30, 0, STEP/2+2 - NEMA_DROP]) {
        nema_bevel();
        cube([5, STEP, STEP], center=true);
    }
    
    lower_plate_rear();

}

module nema_mount() {
    difference() {
        _nema_mount();
        translate([0, 0, -HEIGHT-2])
           nema_neg();
    }
}

module bearing_hole() {
    translate([0, -0, -12.5])
       # cylinder(d=BEARING_HOLES, h=15);
}

module _bearing_holes() {
    translate([0, 41.5/2])
        bearing_hole();
    translate([0, -41.5/2])
        bearing_hole();
}

module bearing_holes() {
    for(i = [-LENGTH/2-20:10:LENGTH/2+40]) {
        translate([i, 0])
            _bearing_holes();
    }       
}

module switch_pos() {
    translate([0,0,-1.5])
        cube([13, 11, 27], center=true);
}

module switch_neg() {
    cube([14.2, 6.5, 30], center=true);
    
    translate([-1, -10, -5.5]) {
        rotate([0, 90, 90])
            cylinder(d=3, h=20);
    }
    translate([-1, -10, 4.1]) {
        rotate([0, 90, 90])
            cylinder(d=3, h=20);
    }
}

module switch() {
    difference() {
        switch_pos();
        switch_neg();
    }
}

module platform() {
    difference() {
        cube([LENGTH, WIDTH, HEIGHT], center=true);
        //bearing_holes();
        cube([LENGTH-40, 10, 20], center=true);
    }

    //translate([-LENGTH/2+45, WIDTH/2-5.5, HEIGHT+9])
    //    switch();    
    translate([-LENGTH/2+40, WIDTH/2-13, HEIGHT+9])
        switch();
    translate([LENGTH/2-7, WIDTH/2-13, HEIGHT+9])
        rotate([0, 0, 180])
            switch();
}

module lower_plate() {
    difference() {
        //cube([90, WIDTH, HEIGHT*2], center=true);
        //cube([65, 25, 10], center=true);
        cube([68, WIDTH, HEIGHT*2], center=true);
        cube([50, WIDTH/2, 10], center=true);
    }   
}

module lower_plate_mid() {
    translate([0, 0, -HEIGHT-2])
        lower_plate();
}

module lower_plate_end() {
    translate([LENGTH/2-3, 0, -HEIGHT-2]) {
        lower_plate();
        translate([18, 0, 2])
            difference() {
                cube([30,WIDTH,12], center=true);
                cube([20,WIDTH/2,13], center=true);
            }
    }
}

difference() {
    union() {
        platform();
        nema_mount();
        lower_plate_mid();
        lower_plate_end();
    }
    bearing_holes();
}