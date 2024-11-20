STEP_BASEX = 93.1;
STEP_BASEY = 15.1;
STEP_Z = 14.5;
$fn=20;

module steppers() {
   // color("#109930", alpha=.6)
        translate([0,0,STEP_Z/2+1.45])
            cube([STEP_BASEX, STEP_BASEY, STEP_Z], center=true);
}

module _step_frame() {
//    color("#109930", alpha=.6)
//        translate([0,0,STEP_Z/2+1.5])
//            cube([STEP_BASEX, STEP_BASEY, STEP_Z], center=true);
    
    cube([STEP_BASEX+5, STEP_BASEY+5, 3], center=true);
    
    translate([-STEP_BASEX/2, 0, 2.5])
        cube([5, STEP_BASEY+4.5, 4.5], center=true);
    
    translate([STEP_BASEX/2, 0, 2.5])
        cube([5, STEP_BASEY+4.5, 8], center=true);
}

module cut_out() {
    cube([8, 5.1, 5], center=true);
}

module switch_pos() {
    translate([0,0,-1.5])
        cube([13, 9, 21], center=true);
    
    translate([4, 6, -10.5])
        rotate([0, 0, 45])
            cube([20, 8, 3], center=true);
}

module switch_neg() {
    cube([14.2, 6.5, 22], center=true);
    
    translate([-1, -10, -6]) {
        rotate([0, 90, 90])
            cylinder(d=3, h=20);
    }
    translate([-1, -10, 3.6]) {
        rotate([0, 90, 90])
            cylinder(d=3, h=20);
    }
}

module step_frame() {
    difference() {
        _step_frame();
        
        // 14.3 from start and 13.7 from the end is estimated center of cutouts
        translate([-STEP_BASEX/2 + 14.3, STEP_BASEY/2, 0])
            cut_out();
        translate([-STEP_BASEX/2 + 14.3, -STEP_BASEY/2, 0])
            cut_out();
        translate([STEP_BASEX/2 - 13.2, STEP_BASEY/2, 0])
            cut_out();
        translate([STEP_BASEX/2 - 13.2, -STEP_BASEY/2, 0])
            cut_out();
        
        //color("#109930", alpha=.6)
        //    translate([0,0,STEP_Z/2+1.5])
        //        #cube([STEP_BASEX, STEP_BASEY, STEP_Z], center=true);
    
    }
}

module cable_guide() {
    translate([STEP_BASEX/2,0,STEP_Z/2+7.5])
        cube([5, STEP_BASEY*2, STEP_Z+15], center=true);
}

module triangle () {
    difference(){
        //creating a cube
        cube([10, 5, 15], center=true);
        //rotating the cube
        translate([-8, 0, 5]){
            rotate([0, -60, 0])
                cube([20, 10, 15], center=true);
        }
    }
}

module bevel() {
    translate([STEP_BASEX/2-4,STEP_BASEY/2+2.5,6])
        triangle();
}


module switch() {
    difference() {
        switch_pos();
        switch_neg();
    }
}
            
difference() {
    union() {
        step_frame();
        translate([0, STEP_BASEY+5])
            step_frame();

        translate([2.5, STEP_BASEY/2+2.5,-1.5])
            cable_guide();
        
        bevel();
        
        translate([-STEP_BASEX/2-9, -13.5, 10.5])
            switch();
        
        translate([-STEP_BASEX/2-9, STEP_BASEY+5+13.5, 10.5])
            mirror([0, 1, 0])
                switch();
        
        translate([STEP_BASEX/2+5, STEP_BASEY+5+13.5, 10.5]) {
            rotate([0,0,180])
                switch();
        }
        translate([STEP_BASEX/2+5, -13.5, 10.5]) {
            rotate([0,0,180])
                mirror([0, 1, 0])
                    switch();
        }
        
    }
    
    translate([STEP_BASEX/2-3, STEP_BASEY/2+2.5, 2]) {
        // lower cable guide hole
        translate([0, 0, 19])
             rotate([0, 90])
                   cylinder(d=2.5, h=10);
        translate([0, 0, 15])
             rotate([0, 90])
                   cylinder(d=2.5, h=10);
        // side guide
        translate([0, 3, 22])
             rotate([0, 90])
                   cylinder(d=2.5, h=10);
        translate([0, 7, 22])
             rotate([0, 90])
                   cylinder(d=2.5, h=10);
        // spine
        translate([0, 0, 22])
             rotate([0, 90])
                   cylinder(d=1.6, h=10);
    }
    
    steppers();
    translate([0, STEP_BASEY+5])
        steppers();
    
}
