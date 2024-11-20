
OD = 33.5;
TT_LARGE=6.18;
TT_SMALL=4.15;
WALL=5.5;
HEIGHT=20;

$fn=40;

module PVC() {
    cylinder(d=OD, h=50, center=true);
}

module slot() {
    translate([OD/2, 0, 0])
        cube([HEIGHT, 3, 35], center=true);
}

module clamp_holes() {
    translate([0,0,5]) {
        translate([5, 0])
            cylinder(d=3.5, h=10, center=true);
        
        translate([HEIGHT-5, 0])
            cylinder(d=3.5, h=10, center=true);

        translate([5, 0, -HEIGHT/2]) 
            cylinder(d=2.15, h=10, center=true);

        translate([HEIGHT-5, 0, -HEIGHT/2]) 
            cylinder(d=2.15, h=10, center=true); 
    }   
}

module clamp_clampies() {
    difference() {
        translate([OD/2, 0, 0])
            cube([18, 10, HEIGHT], center=true);
        
        translate([OD/2+5, 0, HEIGHT/2])
            rotate([90, 90])
                clamp_holes();
    }
}

module tt_large_neg() {
     cylinder(d=TT_LARGE, h=HEIGHT+1, center=true);
}

module tt_large() {
        difference() {
            cylinder(d=TT_LARGE+3, h=HEIGHT, center=true);
            //cylinder(d=TT_LARGE, h=HEIGHT+1, center=true);
        }
}

module tube_guides() {
    difference() {
        hull() {
            translate([0, OD/2+WALL+1, 0])
                tt_large();
            
            translate([0, -OD/2-WALL-1, 0])
                tt_large();
        }
        
        translate([0, OD/2+WALL+1, 0])
            tt_large_neg();
        translate([0, -OD/2-WALL-1, 0])
            tt_large_neg();
    }
}

module cable_hole() {
    difference() {
        cylinder(d=6, h=10, center=true);
        cylinder(d=2, h=11, center=true);
    }
}
module cable_holes() {
    translate([(OD/2+WALL)/2+4, (OD/2+WALL)/2+4, -5])
        cable_hole();
    translate([-(OD/2+WALL)/2-4, -(OD/2+WALL)/2-4, -5])
        cable_hole();
    translate([-(OD/2+WALL)+1, 0, -5])
        cable_hole();
    translate([-(OD/2+WALL)/2-4, (OD/2+WALL)/2+4, -5])
        cable_hole();
    translate([(OD/2+WALL)/2+4, -(OD/2+WALL)/2-4, -5])
        cable_hole();
}

module _clamp_type_1() {
    cylinder(d=OD+WALL, h=HEIGHT, center=true);
    clamp_clampies();
    tube_guides();
}

module clamp_type_1() {
    difference() {
        _clamp_type_1();
        slot();
        PVC();
    }
    
    cable_holes();
}

module _clamp_type_2() {
    difference() {
        union() {
            clamp_type_1();
            mirror([180,0,0])
                clamp_type_1();
            tube_guides();
        }
        mirror([180,0,0])
            slot();
    }
}

module clamp_type_2() {
    difference() {
        _clamp_type_2();
        slot();
        PVC();
    }
}

clamp_type_1();

translate([OD*1.75, 0]) clamp_type_2();


