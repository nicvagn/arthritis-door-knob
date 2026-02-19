inner_diameter = 55;

//inner_radius = 21.43;
inner_radius = inner_diameter / 2;
outer_radius = inner_radius + 3;
hole_radius = 15;

grip_count = 12;       // number of grips
grip_radius = 2.9;     // base radius of each grip
grip_height = 20;//25;       // length sticking out
grip_angle = -15;       // tilt angle in degree
grip_Z_translate = 11.5;

module hollow_sphere() {
    difference() {
        sphere(r = outer_radius, $fn = 100);
        sphere(r = inner_radius, $fn = 100);
        cylinder(r = hole_radius, h = outer_radius*2, center = true, $fn = 100);
        translate([0,0,-outer_radius-30])
            cube([outer_radius*4, outer_radius*4, outer_radius*4], center=true);
    }
}


module angled_grips() {
    for(i = [0 : grip_count-1]) {
        rotate([0, 0, i * 360 / grip_count])         // rotate around Z
        translate([outer_radius, 0, grip_Z_translate])             // move to outer surface
        rotate([0, grip_angle, 0])                  // tilt outward
            minkowski() {
            cylinder(r = grip_radius, h = grip_height, center = true);
                sphere(r=2, $fn=48);
    }}
}
angled_grips();
hollow_sphere();
