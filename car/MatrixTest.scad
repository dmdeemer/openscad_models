A = [[1,0],[-4,4],[0,2]];

b = [1,2];

echo(A[1][1]);
echo(b);
echo(A*b);

angle = 15;

X = [[cos(angle),-sin(angle),0,0],[sin(angle),cos(angle),0,0],[0,0,1,0],[0,0,0,1]];

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

multmatrix(X) axes(25);