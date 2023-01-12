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

module loco_body(L=60)
{
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {
                    translate([-L/2,0,30])
                    rotate([0,90,0])
                    {
                        cylinder(r=20,h=L);
                        translate([0,0,L])
                        boiler_front(20);
                    }

                    translate([0,0,10])
                    cube([L,40,15],center=true);
                }

                translate([0,0,8])
                cube([L-4,36,15], center=true);
            }
            translate([0,0,8.5])
            cube([L,20,12],center=true);

            translate([20,0,3.0])
            rotate([90,0,0])
            cylinder(h=20,r=3,$fn=20,center=true);
        }
        translate([20,0,3.0])
        rotate([90,0,0])
        cylinder(h=21,r=1.1,$fn=20,center=true);
    }
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


rotate([0,0,90])
straight_track(120);


translate([0,20,23])
{
    for( a = [-90,90])
    rotate([0,a,0])
    translate([0,0,10.5])
    wheel(r=8);
    
    rotate([0,90,0])
    translate([0,0,-15.5])
    cylinder(r=1,h=31,$fn=8);
}

translate([0,0,20])
rotate([0,0,90])
loco_body(L=80);