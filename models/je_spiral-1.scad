
// Ref:
//  http://www.johnedmark.com/purchase
//  http://www.johnedmark.com/spirals1/2016/4/29/roll-up-spiral
//  https://www.thingiverse.com/thing:4860603 
//
// Also consider: https://www.instructables.com/Curling-Spiral-Kinetic-Sculpture/

include <Round-Anything/polyround.scad>


/*
polygon(polyRound([
  [0, 0, 0],
  [10,0, 1],
  [0, 10,0]
],10));
*/

$fn=40;
HINGE_OFF=40;
THICK=3;

module a_hinge(DO=25, DI=15) {
    difference() {
        cylinder(center=true, d=DO, h=THICK*2);
        translate([-10, -10])
            cube([20,20,10], center=true);
        cylinder(center=true, d=DI, h=10);
    }
}

module a() {
    union() {
        difference() {
            /*union() {
                hull() {
                    cylinder(center=true, d=30);
                    translate([30, 0, 0])
                        cylinder(center=true, d=10);
                }
            }*/
            
            translate([10, 40, 0])
                cylinder(center=true, d=150, h=THICK*2);
            translate([0, 72, 0])
                scale([1.5, 1])
                   cylinder(center=true, d=145, h=THICK*2);
        
            translate([-200,-50])
                cube([200,200,THICK*2], center=true);
     
            translate([68, 6])
                a_hinge();
            
            translate([91,0])
                rotate([0,0,45])
                    cube([200,200,5], center=true);
         }

        translate([0, -17])
            cylinder(center=true, d=34, h=THICK*2);
     }

}


module _b() {
    //translate([0, -30]) {
        polygon(
            polyRound([
                [-10, -15, 10],
                [-10, 10, 20],
        
                [15, 0, 30],

                [30, 5, 20],
                [33, -5, 1],
                /*
                [40, 10, 10],
                [40, 0, 10],
                [35, 0, 10],
                */
        
                [15, -20, 20],
            ]));
        translate([35, -3])
            cylinder(center=true, d=10);
    //}   
}

module _b_neg() {
    rotate([0, 0, 35])
        translate([-35, 3])
           _b();
    rotate([0, 0, -10])
        translate([-35, 3])
           _b();
}

module b() {
    difference() {
        _b();
        translate([0, -8])
            _b_neg();
    }
}

//b();
//translate([39, 3.5]) {
//    rotate([0, 0, -40])
//        b();
//}


module _c(D1, D2, DN1, DN2) {
    difference() {
        union() {
            hull() {
                cylinder(center=true, d=D1, h=THICK);
                translate([35, 0])
                    cylinder(center=true, d=D2*.95, h=THICK);
            }
            translate([40, 0, 0])
                cylinder(center=true, d=DN2, h=THICK);
        }
        translate([HINGE_OFF, 0]) {
            a_hinge(DN1, DN2);  
        }
    }
}

module c(start, inc, to) {
    //D2 = .5 * D1;
    
    for(i = [start : inc : to]) {
        yoff = (start - i) * 20-start;
        D2 = i * .5;
        D1N = i-1;
        D2N = D1N * .5;
        
        echo(i, D2, D1N, D2N, yoff);
        
        translate([0, yoff]) {
            difference() {
                _c(i, D2, D1N, D2N);
                
                translate([HINGE_OFF, 0])
                    cylinder(center=true, d=3, h=THICK*2);
                
                translate([8, -i/2*.75])
                    cylinder(center=true, d=3, h=THICK*2);
                                
                translate([HINGE_OFF*.75, -i*.2])
                    cylinder(center=true, d=3, h=THICK*2);
                
                translate([HINGE_OFF*.5, i*.28])
                    cylinder(center=true, d=3, h=THICK*2);
                
                for(j = [-10 : 20 : 40] )
                    rotate([0, 0, j])
                        translate([-40, 0])
                            scale([1,1,1.5])
                                _c(i, D2, D1N, D2N);
                
            }
            
            translate([0, 0, -THICK/2])
                difference() {
                    cylinder(center=true, d=i-10, h=THICK);
                    cylinder(center=true, d=3, h=THICK*2);
                    //translate([7, -i/2*.75])
                    //    cylinder(center=true, d=3, h=THICK*2);
                }
        }
    }
}

c(20, -2, 14);
translate([0, 50, 0]) 
    mirror([0, 0, 1])
        c(20, -2, 14);

/*
translate([0, -30]) {
    difference() {
        cylinder(d=30, h=2, center=true);
        cylinder(d=3, h=20, center=true);
    }
}


translate([50, 0, 0]) {
    rotate([180, 0]) {
        mirror([0, 0, 1])
            linear_extrude(2) c(30, -2, 28);

        translate([0, -30]) {
            difference() {
                cylinder(d=30, h=2, center=true);
                cylinder(d=3, h=20, center=true);
            }
        }
    }
}
*/


/*
linear_extrude(2) c(30, -2, 30);

translate([0, 35, 6]) {
    difference() {
        cylinder(d=30, h=2, center=true);
        cylinder(d=3, h=20, center=true);
    }
}
*/

// rotate([0,0, 45]) translate([-35.5, -.5])  c();
