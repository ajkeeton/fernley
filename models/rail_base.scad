NEMA_DROP = 5.45; // see notes above
STEP = 42.35;
STEP_HOLES = 3;

NUTD_OUTER = 22.1;
NUTD_INNER = 10.1;
NUT_LEN = 13.4;
NUT_HOLE_SPACING = 15.4;
ROD = 10;
$fn = 30;

module switch_pos() {
    translate([-1,0,-1.5])
        cube([12, 11, 27], center=true);
}

module switch_neg() {
    cube([14.2, 6.5, 21], center=true);
    
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

module nut_hole() {
    translate([0, 0, -15])
        cylinder(d=3.2, h=NUT_LEN*3);
}

module nut_holes() {
    translate([NUT_HOLE_SPACING/2, 0]) nut_hole();
    translate([0, NUT_HOLE_SPACING/2]) nut_hole();
    translate([0, -NUT_HOLE_SPACING/2]) nut_hole();
    translate([-NUT_HOLE_SPACING/2, 0]) nut_hole();   
}

module nut() {
    rotate([0, 90]) {
        cylinder(d=NUTD_OUTER, h=NUT_LEN*2);
        translate([0, 0, -5]) {
            nut_holes();
            cylinder(d=NUTD_INNER, h=NUT_LEN*2);
        }
    }
}

module slide() {
    translate([0,0,-23.7])
        cube([45.8, 27.2, 10.15], center=true);
}

module slide_hole() {
    cylinder(d=3.5, h=40);
}

module slide_holes() {
    translate([10, 10, 5]) slide_hole();
    translate([10, -10, 5]) slide_hole();
    translate([-10, 10, 5]) slide_hole();
    translate([-10, -10, 5]) slide_hole();  
}

module rail_hole() {
    cylinder(d=3.5, h=40);
}

module rail_holes() {
    translate([112, 0, -40])
        rail_hole();
    translate([88, 0, -40])
        rail_hole();
    translate([63, 0, -40])
        rail_hole();
}

module rail() {
    translate([0, 0, -16 - 11]) {
        cube([250.1, 12.1, 8.01], center=true);
        slide_holes();
    }
    
    rail_holes();
}

module carriage_top_hole() {
    cylinder(d=8, h=20);
}

module screw_hole() {
    cylinder(d=2.2, h=15);
}

module carriage_top_holes() {
    translate([10, 10, -10]) carriage_top_hole();
    translate([10, -10, -10]) carriage_top_hole();
    
    translate([-10, 10, -10]) carriage_top_hole();
    translate([-10, -10, -10]) carriage_top_hole();

    translate([4, -12, -10]) screw_hole();
    translate([4, 12, -10]) screw_hole();    
    translate([-4, -12, -10]) screw_hole();
    translate([-4, 12, -10]) screw_hole();    

    translate([0, 0, -10]) {
        translate([-4, -7]) screw_hole();
        translate([-4, 7]) screw_hole();
        translate([-10, -3]) screw_hole();
        translate([-10, 3]) screw_hole();

        translate([4, -7]) screw_hole();
        translate([4, 7]) screw_hole();
        translate([10, -3]) screw_hole();
        translate([10, 3]) screw_hole();
    }
}

module carriage_top() {
    difference() {
        cube([30, 30, 5], center=true);
        carriage_top_holes();
    }
}

module carriage() {
    difference() {
        union() {
            translate([0, 0, -13])
                cube([30, 30, 5], center=true);
            cube([6, 30, 29], center=true);
            translate([0, 0, 14])
                carriage_top();
        } 
        
        rotate([0, 90]) {
            translate([NUT_HOLE_SPACING/2, 0, -20]) 
                cylinder(d=6, h=17);
            translate([-NUT_HOLE_SPACING/2, 0, -20]) 
                cylinder(d=6, h=17);
        }
    }
    
    translate([0, 15, .5])
        difference() {
            cube([45, 3, 32], center=true);
            cube([39, 4, 20], center=true);
        }
}

module rod() {
    rotate([0, 90])
        translate([0, 0, -125])
            cylinder(d=ROD, h=250);
}

module bearing_riser() {
    translate([100, 0, -18]) {
        translate([10, 0, -4]) {
            difference() {
                cube([13.2, 55, 5], center=true);
            
                translate([0, 21, -20])
                   cylinder(d=5.5, h=40);
                translate([0, -21, -20])
                   cylinder(d=5.5, h=40);
            }
        }
        translate([-10, 15, 9])
            rotate([0, 0, 180])
                switch();
        translate([-10, 8, -5])
            cube([8, 25 , 7], center=true);
        translate([5, 0, -7.25])
            cube([42, 20 , 11.5], center=true);
    }
}

module bearing() {
    rotate([0, 90])
        translate([0, 0, 95])
            cylinder(d=29.4, h=9.6);
}


module nema_screw() {
    cylinder(d=STEP_HOLES, h=10);
    
    // room at the base
    translate([0, 0, 7.5])
        cylinder(d=STEP_HOLES+5, h=20);
}

module nema_neg() {
    translate([0, 0, 1]) {//-LENGTH/2+2.5-30, 0, STEP/2+2]) {
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
    
    translate([-20,0,-STEP/2])
        cube([30, 28, 15], center=true);
    
     translate([0, 0,-STEP/2-10]) {        
        translate([9, 8]) cylinder(d=3.5, h=20);
        translate([9, -8]) cylinder(d=3.5, h=20);
        translate([26, 19]) cylinder(d=3.5, h=20);
        translate([26, -19]) cylinder(d=3.5, h=20);
    }
}

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

module nema_flange_rear() {
    translate([-30, 0, -23.5]) {
        difference() {
            cube([8, STEP*1.5, 5], center=true);
            translate([0, STEP*1.5/2-4]) 
                cylinder(d=4, h=10, center=true);
            translate([0, -STEP*1.5/2+4]) 
                cylinder(d=4, h=10, center=true);
        }
    }
}

module nema_flange_front() {
    translate([55, 5, -23.5]) {
        difference() {
            cube([8, 50, 5], center=true);
            translate([0, 20]) 
               # cylinder(d=4, h=10, center=true);
            translate([0, -20]) 
               # cylinder(d=4, h=10, center=true);
        }
    }
}

module nema_mount() {
    mirror([180,0,0])
        bearing_riser();

    translate([-120-25, 0, -5]) {
        difference() {
            union() {
                //translate([-5, 0, -21.999]) {
                  //  cube([70, STEP/2, 8], center=true);
                translate([10, 0, -21])
                    cube([25, STEP/2+2, 10], center=true);
            
                translate([-20, 0, -21])
                    cube([45, STEP+3, 10], center=true);
                
                // the vertical part
                translate([0, 0, 1]) 
                    cube([5, STEP-1, STEP-1], center=true);
                

                nema_flange_front();                
                nema_flange_rear();                
                nema_bevel();
            }
                
            nema_neg();
        }
    }
}

difference() {
    union() {
        translate([0, 0, -4.7])
            carriage();
        //bearing_riser();
        
        //nema_mount();
    }
    translate([0, 0, -4.7])
        nut();
    
    #slide();
    rail();
    mirror([180,0,0])
        rail_holes();

    translate([0, 0, -4.7]) {
       # rod();
        translate([10, 0]) 
            bearing();
    }
}

