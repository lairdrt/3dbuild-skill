// Minimal parametric example for the 3D Print Collaborator skill.
// 3D design source is normally maintained by the chat assistant in GitHub.
// Units: millimeters.
// With the defaults below: 104 x 32 x 25 mm.

compartments = 3;
inside_length = 32;
inside_width  = 28;
inside_depth  = 21;
wall = 2.0;
floor = 4.0;
$fn = 48;

assert(compartments >= 1, "Must have at least one compartment");
assert(wall >= 1, "Wall must be strong enough to print");
assert(inside_length > 0 && inside_width > 0 && inside_depth > 0);

length = compartments * inside_length + (compartments + 1) * wall;
width = inside_width + 2*wall;
height = inside_depth + floor;

difference() {
    cube([length, width, height]);
    for (i = [0:compartments-1]) {
        translate([wall + i*(inside_length+wall), wall, floor])
            cube([inside_length, inside_width, inside_depth + 0.1]);
    }
}
