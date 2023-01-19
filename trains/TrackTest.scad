use <TrainTrack.scad>

translate([-40,-40,0])
straight_track(30,m=0.15);

translate([-40,40,0])
straight_track(30,m=0.2);

translate([40,-40,0])
straight_track(30,m=0.25);

translate([40,40,0])
straight_track(30,m=0.3);
