include <units.scad>;
include <constants.scad>;
include <util.scad>;

module plexiglass() {
    color([1, 1, 1, 0.5])
        difference() {
            scale([1, 1, -1]) rotate([0, 0, 30])
                cylinder($fn=6, r=3.5*spacing, h=plexiglass_thickness);

            for_line2d(edge_pairs) {
                road();
            }
            
            scale([1, 1, -1]) for_point2d(corners) {
                cylinder(r=12.5*mm, h=2*mm, center=true);
            }
        }
}

plexiglass();
