
DRIVEX = 1.6;
DRIVEY = 6;
DRIVEZ = 5.7;
SCREW = 2.1;
CABLE = 1.2;
ROD = 3.08;
DRIVE = 3.1;
$fn = 20;


module screw() {
    translate([-5, DRIVEY/2-1.5, -.5])
        rotate([0, 90, 0])
            cylinder(d = SCREW, h = 10);
}

module sleeve() {
    cube(center=true, [6, 11, 7]);
}

module cable() {
    hull() {
        translate([-8, 6]) 
            rotate([0, 90])
                cylinder(d=CABLE, h=20);
        translate([-8, 10]) 
            rotate([0, 90])
                cylinder(d=CABLE*.8, h=20);
    }
}

module retainer() {
    translate([0, 5.5])
        cube(center=true, [6,12,7]);
}

module pins() {
    translate([0, 2, -15])
        cylinder(d=2, h=30);
    translate([0, 8, -15])
        cylinder(d=2, h=30);
}

module rod() {
    translate([-8, 11]) 
        rotate([0, 90])
            cylinder(d=ROD, h=20);
}

module the_thing() {
    difference() {
        union() {
            //sleeve();
            retainer();
        }
        
        //#drive();
        //neg_misc();
        cable();
        rod();
    }
}

module for_the_limit() {
    translate([0,3.5,7])
        cube(center=true, [6,8,8]);
}

module bridge() {
    translate([0, 3,-9.5/2])
        cube(center=true, [6,7,7]);
}

module threaded_rod() {
    hull() {
        translate([-8, 12, -5])
            rotate([0, 90])
                cylinder(d=DRIVE, h=20);
        translate([-8, 6, -5])
            rotate([0, 90])
                cylinder(d=DRIVE, h=20);
    }
}

difference() {
    union() {
        the_thing();
        translate([0,0,-10])
            the_thing();
        bridge();
        for_the_limit();
    }
    threaded_rod();
    pins();
}
