use <TrainTrack.scad>

translate([-40,-40,0])
straight_track(40,m=0.12);

translate([-40,40,0])
straight_track(40,m=0.16);

translate([40,-40,0])
straight_track(40,m=0.20);

translate([40,40,0])
straight_track(40,m=0.24);
