use <BezierTest.scad>

L=210;
W=140;

CNR=15;

wheel_diam = 35;
wheel_width = 20;

WW_LEN = wheel_diam + 15;

frame_pts = [
    [[W/2,-L/2+CNR,0],[W/2,-L/2+2*CNR,0]],
//    [[W/2,-L/4-WW_LEN/2,0],[
    [[W/2,L/2-CNR,0],[W/2,L/2,0]],
    [[W/2-CNR,L/2,0],[W/2-CNR,L/2,0]],
    [[-W/2+CNR,L/2,0],[-W/2,L/2,0]],
    [[-W/2,L/2-CNR,0],[-W/2,L/2-CNR,0]],
    [[-W/2,-L/2+CNR,0],[-W/2,-L/2,0]],
    [[W/2,-L/2+CNR,0],[W/2,-L/2+2*CNR,0]],
];

N = len(frame_pts)-1;
hollow_tube(od=6,id=3,n=16,
    matrixes= bezier_matrixes([for( t = [-0.05:0.05:N+0.075] ) t ], frame_pts ) );


