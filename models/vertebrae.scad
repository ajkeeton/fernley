SPINE = 3.25;
PTFE = 5;
$fn=60;
DIAM=80;
BEAM=.756*25.4;

module horiz_arms(x, y) {          
    hull() {
        translate([x/2, y])
            cylinder(d=8, h=8, center=true);
        
        translate([-x/2, y])
            cylinder(d=8, h=8, center=true);
        
        translate([0, 0])
            cylinder(d=10, h=8, center=true);
    }    
}

module horiz_arms_neg(x) {
    translate([x/2, 0]) {
        cylinder(d=2.5, h=20, center=true);
        rotate([0, 90, 45])
            cylinder(d1=2.5, d2=3, h=8);
    }
    
    translate([-x/2, 0]) {
        cylinder(d=2.5, h=20, center=true);
            
        rotate([0, -90, 45])
           cylinder(d1=2, d2=3, h=9);
    }
}

module the_thing(x, y) {
    difference() {
        union() {
            // Horiz arms
            horiz_arms(x, 0);
            
            // For the screw
            translate([1, 1, 0])
                rotate([0, 90, 45])
                    cylinder(d=8, h=15, center=true);
            
            rotate([0,0,90])
                horiz_arms(y, 0);
        }
        
        horiz_arms_neg(x);
        
        rotate([0,0,90])
            horiz_arms_neg(y);
        
        // Spine/center
        cylinder(d=SPINE, h=20, center=true);
        
        // For the spine screw
        rotate([0, 90, 45])
            cylinder(d1=2, d2=3, h=10);
    }
}

the_thing(35, 30);

translate([0, 35, 0]) {
    the_thing(28, 20);

    translate([0, 25, 0]) {
        the_thing(26, 10);

            translate([0, 20, 0]) {
                the_thing(24, 10);
                
                translate([0, 20, 0]) {
                    the_thing(22, 10);
                }
            }
        }
    }