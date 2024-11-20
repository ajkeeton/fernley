
DRIVEX = 1.6;
DRIVEY = 6;
DRIVEZ = 5.7;
ROD = 1.6;
SCREW = 2.1;
CABLE = 1.2;
$fn = 20;

module drive() {
    cube(center=true, [DRIVEX, DRIVEY, DRIVEZ]);
    
    translate([-5, -DRIVEY/2+.8, -.5])
        rotate([0, 90, 0])
            cylinder(d = ROD, h=10);
    
    screw();

}


module screw() {
    translate([-5, DRIVEY/2-1.5, -.5])
        rotate([0, 90, 0])
            cylinder(d = SCREW, h = 10);
}

module sleeve() {
    cube(center=true, [6, 11, 7]);
}

module neg_misc() {
    translate([0, -5, 0]) 
        cube(center=true, [DRIVEX, DRIVEY, DRIVEZ]);
    hull() {
        translate([0, -7, 0])
            screw();
        screw();
   
    }
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
    //translate([-2.5, 5]) {
        //difference() {
            //rotate([0, 90])
                //cylinder(r=5, h=5);
        //}
    //}
    translate([0, 7.5])
        cube(center=true, [6,5,7]);
}

module pins() {
    translate([0, -4, -5])
        #cylinder(d=1.5, h=10);
    translate([0, 8, -5])
        #cylinder(d=1.5, h=10);
}

difference() {
    union() {
        sleeve();
        retainer();
    }
    
    #drive();
    neg_misc();
    cable();
    pins();
}