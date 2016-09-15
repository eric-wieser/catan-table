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
// low resoklution
module table_low() {
    scale([3*ft, 3*ft, 1*in]) {
        translate([-0.5, -0.5, -1])
            cube(1);
    }
}

module boat_holes_shape() {

    // boat holes
    for_line2d([
        for (i=[0:len(edge1_pairs)])
            if(floor((i+10) % (30 / 9)) == 0)
                edge1_pairs[i]
    ])
        translate([0, spacing*0.25, 0]) rotate(180)
            offset(r=0.5*mm)
                boat_polygon();
}

module tile_holes_shape() {
    intersection() {
        offset(delta=tile_padding/2)
            polygon(points=[for (p = edge1_pairs) p[0]]);

        union() {
            // tiles
            for_point2d(centers)
                circle(
                    $fn=6,
                    r=1/sqrt(3) * 80 * mm
                );

            // finger / drill helpers
            for_point2d(corners)
                rotate([0, 0, 30])
                    circle(
                        $fn=6,
                        r=0.4*in
                    );
        }
    }
}

module outline_shape() {
    rotate([0, 0, 30])
        circle($fn=6, r=3.25*spacing);
}



module table_cutaway() {

    scale([1, 1, -1])
    union() {
        // make the tile cutouts
        linear_extrude(height=h3) tile_shape();

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


h1 = plexiglass_thickness;
h2 = plexiglass_thickness + card_thickness;
h3 = plexiglass_thickness + card_thickness*2;

module dxfs() {
    difference() {
        outline_shape();
        boat_holes_shape();
        tile_holes_shape();
    }
}

module cut_table() {
    color("brown")
    difference() {
        table_low();

        scale([1, 1, -1]){
            color("red")
                linear_extrude(h1)
                outline_shape();

            color("yellow")
                linear_extrude(h2)
                boat_holes_shape();

            color("green")
                linear_extrude(h3)
                tile_holes_shape();
        }
    }
}

// swap these to generate the other file
! dxfs();
// cut_table();
