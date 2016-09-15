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
    h1 = plexiglass_thickness;
    h2 = plexiglass_thickness + plexiglass_gap;
    h3 = plexiglass_thickness + plexiglass_gap + card_thickness;

    scale([1, 1, -1])
    union() {
        // make the tile cutouts
        union() {
            intersection() {
                linear_extrude(height=h3)
                    offset(delta=0.1*in)
                        polygon(points=[for (p = edge1_pairs) p[0]]);

                union() {
                    // tiles
                    for_point2d(centers)
                        cylinder(
                            $fn=6,
                            h=h3,
                            r=1/sqrt(3) * 80 * mm
                        );

                    // finger / drill helpers
                    for_point2d(corners)
                        rotate([0, 0, 30])
                            cylinder(
                                $fn=6,
                                h=h3,
                                r=0.4*in
                            );
                }
            }

            // boat holes
            for_line2d([
                for (i=[0:len(edge1_pairs)])
                    if(floor((i+10) % (30 / 9)) == 0)
                        edge1_pairs[i]
            ])
                linear_extrude(height=h3)
                    translate([0, spacing*0.25, 0]) rotate(180)
                        offset(r=0.5*mm)
                            boat_polygon();
        }

        // the outer hexagons
        rotate([0, 0, 30])
            cylinder(
                $fn=6,
                r=3*spacing,
                h=h2
            );
        rotate([0, 0, 30])
            cylinder(
                $fn=6,
                r=3.5*spacing,
                h=h1
            );
    }
}

module cut_table() {
    color("brown")
    difference() {
        table_low();
        table_cutaway();
    }
}

cut_table();

