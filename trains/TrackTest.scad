use <TrainTrack.scad>

translate([-40,-40,0])
straight_track(40,m=0.2);

translate([-40,40,0])
straight_track(40,m=0.4);

translate([40,-40,0])
straight_track(40,m=0.6);

translate([40,40,0])
straight_track(40,m=0.8);
