use <BezierTest.scad>

a_pts = [
    [[50,15,0],[0,1,0]],
    [[48,17,0],[-1,0.5,0]],
    [[0,21.5,0],[-20,0,0]]
];

b_pts = [
    [[0,19.5,0],[10,0,0]],
    [[32,15,0],[1,-1,0]]
];

a_pts2 = bezier_points([0:0.05:2.01],a_pts);
b_pts2 = bezier_points([0:0.05:1.01],b_pts);

color("#aaaaff")
union()
{

    rotate_extrude($fn=80)
    mirror([1,-1,0])
    polygon(
        concat(
            [for (p=a_pts2) [p.x,p.y]],
            [for (p=b_pts2) [p.x,p.y]]
        )
    );
            
    difference()
    {            
        translate([0,0,32])
        cylinder(r=15,h=18,$fn=80);
        translate([0,0,31])
        cylinder(r1=16,r2=2,h=16,$fn=80);
    }
            
    translate([0,0,1])
    rotate_extrude($fn=80)
    translate([19.5,0,0])        
    circle(r=0.5,$fn=12);        

    translate([0,0,49.9])
    scale([0.24,0.24,0.050])
    surface("santa.png",center=true);
}

