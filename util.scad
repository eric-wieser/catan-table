include <constants.scad>

function polar(theta) = [sin(theta), cos(theta)];

centers = concat([[0, 0]], [
    for(i = [1:6]) polar(i*60) 
], [
    for(i = [1:6]) 2 * polar(i*60)
], [
    for(i = [1:6]) polar(i*60) + polar(i*60 + 60)
]) * spacing;

module road() {
    cube([1*in, 0.2*in, 0.2*in], center=true);
}

module for_point2d(locs) {
    for (v = locs)
        translate([v[0], v[1], 0])
            children();
}

module for_line2d(locs) {
    for (v = locs) {
        center = 0.5*(v[0] + v[1]);
        diff = v[1] - v[0];
        angle = atan2(diff[1], diff[0]);
        translate([center[0], center[1], 0])
            rotate([0, 0, angle])
                children();
    }
}

dirs = [for(i = [1:6]) 1/sqrt(3) * polar(i*60 + 30)];

corners = spacing * concat(
    [ for(i = [0:5]) dirs[i] ],
    [ for(i = [0:5]) dirs[i]*2 ],
    [ for(i = [0:5]) dirs[i]*2 + dirs[(i+1) % 6] ],
    [ for(i = [0:5]) dirs[i]*2 + dirs[(i+5) % 6] ],
    [ for(i = [0:5]) dirs[i]*3 + dirs[(i+1) % 6] ],
    [ for(i = [0:5]) dirs[i]*3 + dirs[(i+5) % 6] ],
    [ for(i = [0:5]) dirs[i]*3 + dirs[(i+1) % 6]*2 ],
    [ for(i = [0:5]) dirs[i]*3 + dirs[(i+5) % 6]*2 ],
    [ for(i = [0:5]) dirs[i]*4 ]  
);
    
edge_pairs = spacing * concat(
    [for(i = [0:5]) [
        dirs[i], dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i], dirs[i]*2
    ]],
    [for(i = [0:5]) [
        dirs[i]*2,
        dirs[i]*2 + dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*2,
        dirs[i]*2 + dirs[(i+5)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*2 + dirs[(i+1)%6],
        dirs[(i+1)%6]*2 + dirs[i]
    ]],
    [for(i = [0:5]) [
        dirs[i]*2 + dirs[(i+1)%6],
        dirs[(i+1)%6]*2 + dirs[i]
    ]],
    [for(i = [0:5]) [
        dirs[i]*2 + dirs[(i+1)%6],
        dirs[i]*3 + dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*2 + dirs[(i+5)%6],
        dirs[i]*3 + dirs[(i+5)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*4,
        dirs[i]*3 + dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*4,
        dirs[i]*3 + dirs[(i+5)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*4,
        dirs[i]*3 + dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*3 + dirs[(i+1)%6]*2,
        dirs[i]*3 + dirs[(i+1)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*3 + dirs[(i+5)%6]*2,
        dirs[i]*3 + dirs[(i+5)%6]
    ]],
    [for(i = [0:5]) [
        dirs[i]*3 + dirs[(i+1)%6]*2,
        dirs[i]*2 + dirs[(i+1)%6]*3
    ]]
);