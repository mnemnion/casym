import graph; 

struct Move {
	int x,y;
	int num; //positive for moves, negative for other symbols
	bool iswhite; 
	bool special; //both false is black 
	string glyph; //special symbol for stone or at
	string comment;
	pen specialpen; //sends a color or font ; might be needed.
	
	void operator init(int x, int y, int num, bool iswhite = false) {
		this.x = x;
		this.y = y;
		this.num = num;
		this.iswhite = iswhite;
	}
	
	void operator init(int x, int y) {
		this.x = x;
		this.y = y;
	}
}

struct Circoban {
	int size;
	int numcircles;
	int movenum;
	bool whitemove;
	real fontsize;
	picture pic;
	Move[] move;
	
	path[] circa;

	void operator init(int size, int numcircles=12) {
		this.size = size;
		this.numcircles = numcircles;
		this.fontsize = 1; // this.size/(this.lines+2); // borrowed from gasym, needs changing
		this.movenum = 1;
		this.whitemove = false; // black plays first
	}
}





void rendercircoban(Circoban cb) {
	size(cb.pic,cb.size);
	filldraw(cb.pic,box((-10,-10),(10,10)),black,black);
	int i;
	int numcircles=cb.numcircles;
	//obligatory comment
	cb.circa[0] = Circle((0,0),8);
	draw(cb.pic,cb.circa[0],invisible);
	for(i=1; i<=numcircles; ++i) {
		cb.circa[i]=Circle(4*dir(i*360/numcircles),4);
		draw(cb.pic,cb.circa[i],white);
	}
}

void rendermoves(Circoban cb) {
	
	pair[] movespot = new pair[];
	
	for (Move mv: cb.move) {
		movespot = intersectionpoints(cb.circa[mv.x],cb.circa[mv.y]);
		for (pair xy: movespot) {
			if (abs(xy.x) + abs(xy.y) > 0.005 ) { 
				filldraw(cb.pic,Circle(xy,0.5),red,red);
			}	
		}
	}
}

void drawcircoban(Circoban cb) {
	rendercircoban(cb);
	rendermoves(cb);
}

void testsuite (Circoban cb) {
	Move[] newmoves = {Move(3,5),Move(5,9),Move(8,0),Move(1,9)};
	for ( Move mv: newmoves) {
		cb.move.push(mv);
	}
	drawcircoban(cb);
	
	shipout(cb.pic);
}

void mumon() {
	int i;
	path[] circa = new path[];
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

Circoban cb = Circoban(400,18);

testsuite(cb);