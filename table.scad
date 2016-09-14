include <units.scad>;
include <constants.scad>;
include <util.scad>;

module table() {
    minkowski() {
        scale([3*ft, 3*ft, 0.5*in]) {
            translate([-0.5, -0.5, -1])
                cube(1);
        }
        translate([0, 0, -0.5*in]) cylinder(r=1.25*in, h=0.5*in);
    };
}

module table_low() {
    scale([3*ft, 3*ft, 1*in]) {
        translate([-0.5, -0.5, -1])
            cube(1);
    }
}

module table_cutaway() {
    // rotate([0, 0, 15])
    scale([1, 1, -1]) union() {
        for_point2d(centers)
            cylinder(
                $fn=6,
                h=plexiglass_thickness + plexiglass_gap + card_thickness,
                r=1/sqrt(3) * 80 * mm
            );
        for_point2d(corners)
            rotate([0, 0, 30])
                cylinder(
                    $fn=20,
                    h=plexiglass_thickness + plexiglass_gap + card_thickness,
                    r=0.4*in
                );
        rotate([0, 0, 30])
            cylinder(
                $fn=6,
                r=3*spacing,
                h=plexiglass_thickness + plexiglass_gap
            ); 
        rotate([0, 0, 30])
            cylinder(
                $fn=6,
                r=3.5*spacing,
                h=plexiglass_thickness
            ); 
    }
}

module cut_table() {
    color("brown")
//    table_cutaway();
    difference() {
        table_low();
        table_cutaway();
    }
}

cut_table();

