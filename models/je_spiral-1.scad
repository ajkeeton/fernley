
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
THICK=3;
LENGTH=50;
WIDTH=30;

module cross_members(width, D=5) {
    translate([width/2, 0]) {
        scale([1.8, 1, 1]) {
            translate([0, width*.5])
                 cylinder(d=D, h=THICK);
            
            translate([0, -width*.5])
                 cylinder(d=D, h=THICK);
        }
    }
}
module neg_cross_members(width) {
    translate([width/2, width*.5, THICK])
        cylinder(d=3.1, h=THICK*4, center=true);
    
    translate([width/2, -width*.5, THICK])
        cylinder(d=3.1, h=THICK*4, center=true);
}

module _segment(length, width) {
    hull() {
        translate([length/2, 0, 0])
            cylinder(d=width*.7, h=THICK*2);
        translate([length, 0, 0])
            cylinder(d=width*.5, h=THICK*2);
    }

    hull() {
        cylinder(d=width*.7, h=THICK);
        cross_members(width);
        translate([length*.9, 0, 0])
            cylinder(d=width*.5, h=THICK);
    }
    
    translate([0, 0, THICK])
        cross_members(width);
}

module neg_seg(length, width) {
     translate([0, 0, THICK])
        cylinder(d=width*.75, h=THICK+1);
     translate([length, 0, -1])
        scale([1, 2, 1])
            cylinder(d=width+.5, h=THICK+1.01);
    
     cylinder(d=5, h=THICK*5, center=true);
     translate([length, 0, 0])
        cylinder(d=5, h=THICK*5, center=true);
}

module segment(length, width) {
    difference() {
        _segment(length, width);
        neg_seg(length, width);
        neg_cross_members(width);
        
        //translate([length/3, 0, THICK])
        //    scale([1, 1, 1])
        //       # cylinder(d=14, h=THICK*4, center=true);
    }
}
module segments(length, width) {
    segment(length, width);
    //rotate([180, 0]) translate([0,0,-4*THICK]) segment(length, width);
    //translate([length+5, 0])
    //    segment(length, width);
}


 segments(LENGTH-5, WIDTH-(5*.8));
    translate([LENGTH-5, 0, -.25]) {
        segments(LENGTH-10, WIDTH-(10*.8));
        
        translate([LENGTH-10, 0, -.25]) {
            segments(LENGTH-15, WIDTH-(15*.8));
            
            translate([LENGTH-15, 0, -.25])
                segments(LENGTH-20, WIDTH-(20*.8));
        }
    }
/*
for(i = [0: 5: 15]) {
    echo(i, (LENGTH-i+5)*i/5);
    
    translate([(LENGTH-i+5)*i/5, 0]) {
        segments(LENGTH-i, WIDTH-(i*.9));
        
        //translate([0, WIDTH-i+8])
        //    segments(LENGTH-i, WIDTH-i);
    }
}
*/


