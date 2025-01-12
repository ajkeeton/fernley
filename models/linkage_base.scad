
SPINE=6.4;
TUBE=6.18;
$fn=100;

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
    translate([0, -TUBE-4]) 
        cylinder(d=TUBE, h=150, center=true);
}

module tube_channel() {
    translate([0, -TUBE-4]) 
        cylinder(d=TUBE+4, h=20, center=true);
}

module spine() {
    cylinder(d=SPINE, h=150, center=true);
}

module channel_and_clamp() {     
    difference() {
        union() {
            hull() {
                clamp();
                //rotate([0, 45]) 
                    tube_channel();
            }
            clampies();
        }
        
        clampies_neg();
    }
}

module linkage_conn() {
    difference() {
        hull() {
            translate([0, -3, 15])
                rotate([90, 0])
                    cylinder(d=10, h=5);
            
            translate([0, -3, -15])
                rotate([90, 0])
                    cylinder(d=10, h=5);
            
            translate([12, -3])
                rotate([90, 0])
                    cylinder(d=15, h=5); 
            
            translate([-12, -3])
                rotate([90, 0])
                    cylinder(d=15, h=5); 
        }  
    
        translate([12, -2])
            rotate([90, 0])
                cylinder(d=8, h=10); 
        
        translate([-12, -2])
            rotate([90, 0])
                cylinder(d=8, h=10); 
    }
}

module thing() {
    difference() {
        union() {
            channel_and_clamp();
            translate([0,0,-50])
                channel_and_clamp();
            
            translate([0,0,-60])
                cylinder(h=70, d=13);
            
            translate([0, 0, -25])
                linkage_conn();
        }
        
        translate([0, 9.75, -20])
            cube([50, 20, 100], center=true);
        //rotate([0, 45])
           tube_channel_neg();
        
        spine();
    }
}

module linkage1() {
    difference() {
        hull() {
            cylinder(d=15, h=5, center=true);
            translate([75, 0])
                cylinder(d=15, h=5, center=true);
        }
        
        cylinder(d=8, h=6, center=true);
        translate([75, 0])
            cylinder(d=8, h=6, center=true);
        
        hull() {
            translate([15, 0])
                cylinder(d=8, h=6, center=true);
            translate([60, 0])
                cylinder(d=8, h=6, center=true);    
        }
    }
}

module linkage2() {
    difference() {
        hull() {
            cylinder(d=15, h=5, center=true);
            translate([80, 0])
                cylinder(d=15, h=5, center=true);
        }
        
        cylinder(d=8, h=6, center=true);
        translate([80, 0])
            cylinder(d=8, h=6, center=true);
        
        for(i = [15 : 10 : 65]) {
            echo(i);
            translate([i, 0])
                cylinder(d=8, h=6, center=true);
        }
    }
}

/*
translate([20, 0, -25])
    rotate([90, 0])
        linkage1();

translate([20, 0, 25])
    rotate([90, 0])
        linkage2();
*/

thing();

