use <BezierTest.scad>


module heart(a=1.0,r=0.75)
let( f  = sqrt(a*a+1),
     cy = 10*(a+r/f),
     cx = 10*(1-a*r/f) )
translate( [0,-cy/2-5*r] )
{

    polygon( [[0,0],[10,10*a],
              [cx,cy],[-cx,cy],
              [-10,10*a]] );
    for( x=[-cx,cx] )
    translate( [x,cy] )
    circle( 10*r );
}

module bottlecap(r0=19.5,l=50,top="heart")
union()
{
    a_pts = [
        [[l,15,0],[0,1,0]],
        [[l-2,17,0],[-1,0.5,0]],
        [[0,r0+1.5,0],[-20,0,0]]
    ];

    b_pts = [
        [[0,r0,0],[10,0,0]],
        [[l-17,15,0],[1,-1,0]]
    ];

    a_pts2 = bezier_points([0:0.05:2.01],a_pts);
    b_pts2 = bezier_points([0:0.05:1.01],b_pts);

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
        translate([0,0,l-18])
        cylinder(r=15,h=18,$fn=80);
        translate([0,0,l-19])
        cylinder(r1=16,r2=2,h=16,$fn=80);
    }

    difference()
    {
        union()
        {
            cylinder(h=10,r=r0+2,$fn=18);
            translate([0,0,10])
            cylinder(h=3,r1=r0+2,r2=r0,$fn=18);
        }
        translate([0,0,-1])
        cylinder(h=15,r=r0+0.5);
    }

    translate([0,0,1])
    rotate_extrude($fn=80)
    translate([r0,0,0])
    circle(r=0.5,$fn=12);

    if(top=="santa")
    translate([0,0,l-0.1])
    scale([0.24,0.24,0.04])
    surface("santa.png",center=true);

    if(top=="heart")
    color("pink")
    translate([0,-1,l-0.1])
    linear_extrude(1)
    heart(a=1,r=0.65);

}



if(true)
//color("#aaaaff")
bottlecap(19.5,55);

