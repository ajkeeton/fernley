CABLE = 3.2;
AXLE = 3.1;

$fn = 40;

module cable_whatever() {
    difference() {
        cylinder(h=10, d=CABLE*2+4, center=true);
        //cylinder(h=5.1, d=CABLE, center=true);
    }
}

module other_thing() {
    difference() {
        cylinder(h=10, d=AXLE*2+4, center=true);
        //cylinder(h=5.1, d=AXLE, center=true);
    }
}

module cable_whatever_neg() {
    cylinder(h=12, d=CABLE, center=true);
}

module other_thing_neg() {
    cylinder(h=12, d=AXLE, center=true);
}

module hinge() {
    difference() {
        hull() {
            cable_whatever();
            translate([0,CABLE*2-2,0])
                rotate([0, 90])
                     other_thing();
        }
        cable_whatever_neg();
        translate([0,CABLE*2-2,0])
            rotate([0, 90])
                 other_thing_neg();
    }
}

hinge();