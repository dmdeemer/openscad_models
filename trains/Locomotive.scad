use <TrainTrack.scad>

module boiler_front(r=20)
{
    cylinder(h=5,r1=r,r2=r/3);

    for( a=[0:20:359] )
    rotate([0,0,a])
    translate([r*0.75,0,0])
    cylinder(r=1.5,h=3,$fn=6);

    translate([0,0,4])
    rotate([0,0,90])
    linear_extrude(2)
    text("R",halign="center",valign="center",size=7);
}

module loco_boiler(L=60)
{
    rotate([0,90,0])
    {
        cylinder(r=20,h=L);
        translate([0,0,L])
        boiler_front(20);
    }
}


module wheel_cutout(W)
rotate([90,0,0])
union()
{
    for( dir=[-1,1] )
    translate([0,0,dir*(W/2-1)-2])
    union()
    {
        cylinder(h=4,r=7,$fn=24);
        translate([0,-7,2])
        cube([14,14,4],center=true);
    }

    translate([0,0,-W/2])
    cylinder(h=W,r=1.3,$fn=32);
}

module loco_base(L,W,WB)
union()
{
    difference()
    {
        translate([0,0,10])
        cube([L,W,20], center=true);

        for( dir=[-1,1] )
        translate([0,dir*((W+WB)/4-1.125),8])
        cube([L-4,(W-WB)/2-1.75,20],center=true);

        for( dir=[-1,1] )
        translate([dir*(L/2-20),0,6])
        wheel_cutout(W);

/*        cube([100,100,100],center=true); */
    }
    for( a=[0,180] )
    rotate([0,-90,a])
    translate([0,0,-L/2+1])
    linear_extrude(L-2)
    {
        polygon([[19,W/2-1],[14,W/2-1],[19,WB/2-1]]);
    }
}

module loco_cab(L=40,W=40)
union()
{
    translate([0,0,W/2+5])
    difference()
    {
        cube([L,W,W+10],center=true);
    }
}

module locomotive(L=75,W=40,WB=21)
union()
{
    loco_base(L,W,WB);
    translate([0,0,38])
    loco_boiler(L/2);
    translate([-L/4,0,19])
    loco_cab(L/2,W);
}

module wheel(r=6,f=2.5)
difference()
{
    union()
    {
        difference()
        {
            union()
            {
                cylinder(r=r+f,h=1);
                translate([0,0,1])
                cylinder(h=1,r1=r+f,r2=r);
                translate([0,0,2])
                cylinder(r=r,h=3);
            }
            translate([0,0,4])
            cylinder(r=r-1,h=2);
        }

        for( a=[0:30:179] )
        rotate([0,0,a])
        translate([0,0,4])
        cube([2*r-1,1,2],center=true);
    }
    translate([0,0,-0.5])
    cylinder(r=1,h=6,$fn=20);
}


/*
rotate([0,0,90])
straight_track(160,0.2);
*/


for( dir = [-1,1] )
translate([0,dir*20,23])
{
    for( a = [-90,90])
    rotate([0,a,0])
    translate([0,0,10.5])
    wheel(r=8);

    rotate([0,90,0])
    translate([0,0,-15.5])
    cylinder(r=1,h=31,$fn=8);
}


translate([0,0,17])
rotate([0,0,90])
locomotive(L=80);