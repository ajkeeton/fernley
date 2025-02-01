$fn=50;
SPINE=3.11+.25;
WIDTH=75;
HEIGHT=5;

module arch(w) {
    scale([.74, .4, 1])
        translate([0, -w*.75])
            rotate([0, 0, 50])
                rotate_extrude(angle=78, convexity=10)
                    translate([w, 0]) 
                        square(HEIGHT*3);
}

module arches(w) {
    difference() {
        arch(w);
        translate([-WIDTH, -WIDTH, HEIGHT])
            cube([WIDTH*2, WIDTH*2, HEIGHT*3]);
    }
}

module spine() {
    difference() {
        cylinder(d=6, h=HEIGHT);
        cylinder(d=SPINE, h=HEIGHT+1);
    }
}

module lateral_guides(w) {
    translate([w/2+2, 1])
       // scale([1.5, 1.1, 1])
            cylinder(d=10, h=HEIGHT);

    translate([-w/2-2, 1])
        //scale([1.5, 1, 1])
            cylinder(d=10, h=HEIGHT);
}

module neg_lateral_guides(w) {
    translate([w/2+2, 1]) {
        translate([0, 0, -.5])
            cylinder(d=SPINE, h=50+1);


        translate([.5, 0, HEIGHT/2])
            rotate([-90, 0, 110]) {
                cylinder(d2=3.1, d1=2.5, h=10);
                translate([0,0,5])
                    cylinder(d=6, h=5);

            }
    }

    translate([-w/2-2, 1]) {
        translate([0, 0, -.5])        
            cylinder(d=SPINE, h=50);
        
        translate([.5, 0, HEIGHT/2])
            rotate([-90, 0, -110]) {
               cylinder(d2=3.1, d1=2.5, h=10);
               translate([0,0,4])
                   // scale([1,2,1])
                        cylinder(d=6, h=5);
            }
    }
}

module vert_neg(w) {
    neg_lateral_guides(w);
    
    translate([0, w*.15, 0])
        cylinder(d=2.5, h=150, center=true);   
}

module vert(w) {
    difference() {
        union() {
            arches(w);
            lateral_guides(w);
            translate([0, w*.15])
                scale([1.2, 1, 1])
                    cylinder(d=6, h=HEIGHT);
        }
        
        vert_neg(w);
    }
}

module base_neg() {  
    neg_lateral_guides(WIDTH);

    translate([0, 4, -.5])
        cylinder(d=6.5, h=50, center=true);
    
    translate([-WIDTH*.4, 5, -.5])
        cylinder(d=3.5, h=HEIGHT+1);
    translate([WIDTH*.4, 5, -.5])
        cylinder(d=3.5, h=HEIGHT+1);
    
    translate([-WIDTH*.2, 8, -.5])
        cylinder(d=3.5, h=50);
    translate([WIDTH*.2, 8, -.5])
        cylinder(d=3.5, h=50);
}

module base() {
    difference() {
        union() {   
            vert(WIDTH);
            translate([-WIDTH/2+2, -1])
                cube([WIDTH-4, 9, HEIGHT]);
        }
        base_neg();
    }
}

vert(WIDTH);

for(i = [0: 1: 4]) 
    translate([0, 15*i])
        vert(WIDTH-i*10);

translate([0, -15])
    base();

