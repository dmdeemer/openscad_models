eps=0.01;



module straight_track_raw(L=160)
{
    N=floor(L/20 + 0.5);
    
    union()
    {

    for( y = [-15,15] )
    translate([0,y,11])
    cube([L,4,8],center=true);

    for( i = [0:1:N-1] )
    let( x = i*20-(N-1)*10 )
    translate([x,0,6])
    cube([10,40,10], center=true);

    translate([L/2,0,0])
    rotate([0,-90,0])
    linear_extrude(L)
    polygon([[0,-25],[0,25],[8,15],[8,-15]]);
    }
}




module track_profile()
union()
{
    for( x=[-15,15] )
    translate([x,11])
    polygon([[-2,-4],[-2,4],[2,4],[2,-4]]);
    
    polygon([[-25,0],[25,0],[15,8],[-15,8]]);
}

/* pi has 16 segments, so is 320mm long */
/* pi*r = 320 --> r = 320/pi */
PI = 3.1415926536;
R = 320/PI;

module curved_track_raw(a=90)
{
    N = floor(a/11.25 + 0.5);


    union()
    {
        rotate_extrude(angle=a,convexity=4,$fn=120)
        translate([R,0,0])
        track_profile();
        
        for( i = [0.5:1:N] )
        rotate([0,0,i*11.25])
        translate([R,0,6])
        cube([40,10,10],center=true);
    }
    
}

module hooks()
for( i = [-10,0,10] )
translate([0,i,0])
union()
{
    translate([0,0,1])
    cube([20,4,2],center=true);
    
    translate([10,0,0])
    cylinder(r=2,h=7,$fn=14);
    
    translate([10,0,7])
    sphere(r=2,$fn=14);
    
    translate([-10,0,2])
    rotate([0,90,0])
    cylinder(r=2,h=20,$fn=14);
}

module straight_track(L=160)
difference()
{
    union()
    {
        straight_track_raw(L);
        
        translate([L/2,0,0])
        hooks();
    }
    
    translate([-L/2,0,0])
    hooks();
    translate([-L/2,0,-1])
    hooks();
}

module curved_track(a=90)
difference()
{
    union()
    {
        curved_track_raw(a=a);
        
        translate([R,0,0])
        rotate([0,0,-90])
        hooks();
    }

    for( z = [0,-1] )
    rotate([0,0,a])
    translate([R,0,z])
    rotate([0,0,-90])
    hooks();

}

translate([0,-100,0])
straight_track(160);

translate([0,-160,0])
straight_track(180);

translate([0,-220,0])
straight_track(200);

translate([0,-280,0])
straight_track(220);

translate([-200,0,0])
curved_track(22.5);

translate([-300,0,0])
curved_track(45);

translate([-400,0,0])
curved_track(90);

