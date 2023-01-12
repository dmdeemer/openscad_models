function arc1( start, end, radius, major=0, clockwise=1, fn=-1 ) = 1;

// centers = midpoint +- perp_bisect * sqrt(r*r-0.25*norm*norm)

module letter_a() {
    a_points = [[0,0],[10,0],[30,40],[70,40],[90,0],[100,0],[50,100],[35,50],[50,80],[65,50]];
            
    polygon(a_points,[[0,1,2,3,4,5,6,0],[7,8,9]]);
}


module letter_e() {
    e_points = [[0,0],[0,100],[80,100],[80,90],[10,90],
                [10,55],[75,55],[75,45],[10,45],[10,10],
                [80,10],[80,0]];

    polygon(e_points);
}

module letter_f() {
    e_points = [[0,0],[0,100],[80,100],[80,90],[10,90],
                [10,55],[75,55],[75,45],[10,45],[10,0]];

    polygon(e_points);
}


module letter_h() {
    h_points = [
        [0,0],[0,100],[10,100],[10,55],[70,55],
        [70,100],[80,100],[80,0],[70,0],[70,45],
        [10,45],[10,0]
    ];
    
    polygon(h_points);
}

module letter_v() {
    v_points = [
        [0,100], [10,100], [50,20],
        [90,100], [100,100], [50,0]
    ];
    polygon(v_points);
}

module letter_n() {
    n_points = [
        [0,0],[0,100],[10,100],
        [70,15],[70,100],[80,100],
        [80,0],[70,0],[10,85],
        [10,0]
    ];
    polygon(n_points);
}


color("pink") letter_a();
color("pink") translate([100,0,0]) letter_e();
color("pink") translate([200,0,0]) letter_f();
color("pink") translate([300,0,0]) letter_h();
color("pink") translate([400,0,0]) letter_v();

color("pink") {
    translate([0,150,0]) letter_h();
    translate([100,150,0]) letter_e();
    translate([200,150,0]) letter_a();
    translate([280,150,0]) letter_v();
    translate([400,150,0]) letter_e();
    translate([500,150,0]) letter_n();}
