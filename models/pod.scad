
SPINE = 3.25;
PTFE = 3;
$fn=60;
DIAM=80;
BEAM=.756*25.4;

module _tent_base() {
    translate([15, 0]) cylinder(d=PTFE, h=10, center=true);
    translate([-15, 0]) cylinder(d=PTFE, h=10, center=true);
    translate([0, 15]) cylinder(d=PTFE, h=10, center=true);
    translate([0, -15]) cylinder(d=PTFE, h=10, center=true);
    
    cylinder(d=SPINE, h=10, center=true);
    
    //translate([0, 0, 4])
    //    cube([60, 60, 5], center=true);
}

module tent_base() {
    //for(i = [0 : 60 : 360-60])
    for(i = [0, 120, 240])
        rotate([0, 0, i])
            translate([0, -DIAM/2-10]) 
                rotate([100, 0, 0]) 
                    _tent_base();
}

module beam() {
    cube([BEAM, BEAM, 200], center=true);
}

module the_thing() {
    difference() {
        union() {
            difference() {
                sphere(d=DIAM+30);
                sphere(d=DIAM+20);
                //cylinder(d=DIAM+30, h=50, center=true);
                //cylinder(d=DIAM+20, h=51, center=true);
            }
            
            // cross members
            translate([0, 0, 5]) {
                rotate([0, 0, 30])
                    translate([0,DIAM/4])
                        cube([10, (DIAM+40)/2, 10], center=true);
                rotate([0, 0, -90])
                    translate([0,DIAM/4])
                        cube([10, (DIAM+40)/2, 10], center=true);
                
                rotate([0, 0, 150])
                    translate([0,DIAM/4])
                        cube([10, (DIAM+40)/2, 10], center=true);
            }
                
                /*translate([0, 0, -3])
                rotate([0, 90])
                    scale([1, 2.8, 1])
                        cylinder(d=30, h=10, center=true);*/
            
            
            // center bracket
            difference() {
                    rotate([0,0,45])

               // translate([0,0,5])
                    cube([BEAM+5, BEAM+5, 100], center=true);
                
               /*
                translate([0,0,-10])
                    scale([1, 1, 2])
                        rotate([0, 90])
                            cylinder(d=15, h=BEAM+6, center=true);
                */    
                
                /*translate([0,0,30])
                    rotate([90, 0])
                        cylinder(d=2.25, h=DIAM, center=true);
                */
            }
            
            /*
            translate([0, 0, -22.5]) {
                difference() {
                    cylinder(d=DIAM+25, h=5, center=true);
                    cylinder(d=DIAM+5, h=6, center=true);
                }
            }
            */
        }
        
        // cap
        translate([0, 0, DIAM/2-5])
            cube([DIAM+30, DIAM+30, DIAM/2+10], center=true);
        
        translate([0, 0, -10])
            rotate([0, 0, 30])
                 tent_base();
        rotate([0,0,45])
            beam();
        
        difference() {
            sphere(d=DIAM+50);
            sphere(d=DIAM+30);
        }

    }
}

module cable_idunnos() {
    difference() {
        union() {
            cylinder(d=8, h=4);
            cylinder(d=4, h=6);
        }
        cylinder(d1=2.5, d2=2, h=20, center=true);
    }
}

/*
module cap() {
    difference() {
        union() {
            difference() {
                sphere(d=DIAM+30);
                sphere(d=DIAM+20);
                
                //cylinder(d=DIAM+30, h=50, center=true);
                //cylinder(d=DIAM+20, h=51, center=true);
            }
            
        }
        
        translate([0, 0, -DIAM/2+10])
            cube([DIAM+30, DIAM+30, DIAM/2], center=true);
    }
}
*/

difference() {
the_thing();
    //translate([0, 0, 10]) cube([300, 300, 60], center=true);
    

}

//cable_idunnos();
