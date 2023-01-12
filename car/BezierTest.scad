function bezier(t, v) =
    ((v[3]*(1-t) + v[2])*(1-t) + v[1])*(1-t) + v[0];

function bezier_d(t, v) =
    (3*v[3]*(1-t) + 2*v[2])*(1-t) + v[1];

function bezier_point(t, vec) =
    [
        bezier(t, vec.x),
        bezier(t, vec.y),
        bezier(t, vec.z)
    ];

function bezier_vector(t, vec) =
    [
        bezier_d(t, vec.x),
        bezier_d(t, vec.y),
        bezier_d(t, vec.z)
    ];

function bezier_prep(pts) =
    let( N = len(pts)-1,
         setup_mat =
            [[0, 0, 0, 1],
             [0, 0, 3,-3],
             [0, 3,-6, 3],
             [1,-3, 3,-1]] *
            [[1, 0, 0, 0],
             [0, 1, 0, 0],
             [0, 0, 2,-1],
             [0, 0, 1, 0]] )
    [ for( i=[0:1:len(pts)-2])
        [
            setup_mat * [pts[i][0].x,pts[i][1].x,pts[i+1][0].x,pts[i+1][1].x],
            setup_mat * [pts[i][0].y,pts[i][1].y,pts[i+1][0].y,pts[i+1][1].y],
            setup_mat * [pts[i][0].z,pts[i][1].z,pts[i+1][0].z,pts[i+1][1].z],
        ]
    ];

function bezier_matrixes(t_list, pts, a=[0,0,1]) =
    let( vec = bezier_prep(pts),
         N = len(vec) )
    [ for( t = t_list )
        let(
            i = max(0,min(N-1,floor(t))),
            tt = t-i,
            d = bezier_vector( tt, vec[i] ),
            x = bezier_point( tt,  vec[i] ),
            u = d / norm(d),
            v_ = cross(a,u),
            v = v_ / norm(v_),
            w = cross(u,v) )
            [ [ u.x, v.x, w.x, x.x ],
            [ u.y, v.y, w.y, x.y ],
            [ u.z, v.z, w.z, x.z ]] //,
            //[ 0, 0, 0, 1 ] ];
    ];

a = 70.7;
bez_pts = [
    [[100,0,0],   [100,a,0]],
    [[0,100,50],  [-a,100,80]],
    [[-100,0,100],[-100,-a,130]],
    [[0,-100,150],[a,-100,150]],
    [[100,0,0],   [100,a,0]],
];

module axes(sz=50)
{
    color("red")
      rotate([0,90,0])
      cylinder(d=2,h=sz);

    color("green")
      rotate([-90,0,0])
      cylinder(d=2,h=sz);

    color("blue")
      cylinder(d=2,h=sz);
}

// Produces points and polygons
function path_extrude(points,matrixes) =
    let( N=len(matrixes), P=len(points) )
    [
        [ for( m = matrixes, p = points ) m*[0,p.x,p.y,1] ],
        concat(
            [[for (j=[P-1:-1:0]) j]],
            [for( i = [1:1:N-1], j = [0:P-1] )
                [ i*P+((j+1)%P), i*P+j,
                  (i-1)*P + j, (i-1)*P+((j+1)%P) ]],
            [[for (j = [N*P-P:1:N*P-1]) j]]
        )
    ];

function circle_pts(r=1,n=24,reverse=false) =
    let(step=360/n)
    [ for (i=(reverse ? [n-1:-1:0] : [0:1:n-1])) [r*cos(i*step),r*sin(i*step)] ];

module hollow_tube(od=10,id=5,n=6,matrixes) {
    let( pex_id = path_extrude( circle_pts(id,n=n), matrixes ),
         pex_od = path_extrude( circle_pts(od,n=n), [for (i=[1:1:len(matrixes)-2]) matrixes[i] ] ) )
    difference() {
        polyhedron( pex_od[0], pex_od[1], convexity=10 );
        polyhedron( pex_id[0], pex_id[1], convexity=10 );
    }
}

hollow_tube(od=10,id=4,n=16,
    matrixes= bezier_matrixes([for( t = [-0.05:0.05:4.05] ) t ], bez_pts ) );
