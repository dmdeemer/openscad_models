
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

module hook_profile(m=0)
union()
{
    translate([10,0])
    circle(r=5+m,$fn=24);
    square([20,7+2*m],center=true);
}

module positive_hook(m=0)
intersection()
{
    translate([0,0,2.5])
    union()
    {
        rotate([90,0,90])
        rotate_extrude(angle=45,$fn=64)
        translate([10,0,0])
        rotate([0,0,90])
        hook_profile(m);

        translate([0,10,-5])
        linear_extrude(5)
        hook_profile(m);

    }

    translate([0,10,0])
    linear_extrude(5+m)
    hook_profile(m);

}

module negative_hook(m)
intersection()
{
    translate([0,0,2.5])
    cube([100,100,5+2*m],center=true);

    rotate([0,0,180])
    union()
    {
        translate([0,10,-m])
        linear_extrude(5+2*m)
        hook_profile(m);

        translate([0,0,2.5])
        rotate([90,45,90])
        rotate_extrude(angle=45,$fn=64)
        translate([10,0,0])
        rotate([0,0,90])
        hook_profile(m);
    }
}


module straight_track(L=160,m=0.4)
difference()
{
    union()
    {
        straight_track_raw(L);

        translate([L/2,0,0])
        positive_hook();
        translate([-L/2,0,0])
        rotate([0,0,180])
        positive_hook();

        translate([0,0,8])
        rotate([0,0,90])
        scale([0.75,0.75,1])
        linear_extrude(2)
        text(str(m),halign="center",valign="center");
    }

    translate([L/2,0,0])
    negative_hook(m);
    translate([-L/2,0,0])
    rotate([0,0,180])
    negative_hook(m);
}

module curved_track(a=90,m=0.4)
difference()
{
    union()
    {
        curved_track_raw(a=a);

        translate([R,0,0])
        rotate([0,0,-90])
        positive_hook();

        rotate([0,0,a])
        translate([R,0,0])
        rotate([0,0,90])
        positive_hook();
    }

    translate([R,0,0])
    rotate([0,0,-90])
    negative_hook(m);

    rotate([0,0,a])
    translate([R,0,0])
    rotate([0,0,90])
    negative_hook(m);

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


