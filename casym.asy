
size(400);
filldraw(box((-10,-10),(10,10)),black,black);
int i;
int numcircles=18;
//obligatory comment
draw(circle((0,0),4),white);
path[] circa = new path[];


for(i=1; i<=numcircles; ++i) {
	circa[i]=circle(4*dir(i*360/numcircles),4);

		draw(circa[i],white);
}


pair[] movespot = new pair[];

movespot = intersectionpoints(circa[2],circa[6]);
for (pair xy: movespot) {
	if (abs(xy.x) + abs(xy.y) > 0.005 ) { 
		filldraw(circle(xy,0.5),red,red);
	}
}


void mumon() {
	//absence of block comments makes me do weird things!
	if (i % 3 == 0) {
		draw(circa[i],red);
	} else if (i % 3 == 1) {
		draw(circa[i],blue);
	} else if (i % 3 == 2) {
		draw(circa[i],green);
	}

	if (i % 4 == 0) {
		draw(circa[i],red);
	} else if (i % 4 == 1) {
		draw(circa[i],blue);
	} else if (i % 4 == 2) {
		draw(circa[i],green);
	} else if (i % 4 == 3) {
		draw(circa[i],yellow);
	}
}