// This branch was forked early on to provide a laser path for making a board. 
// It is expected to die when it can be faked with high-level behavior, and is
// not destined for merger with the collective.

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
	size(cb.pic,24inches,24inches,(-11.5,-11.5),(11.5,11.5));
	filldraw(cb.pic,box((-12,-12),(12,12)),white,white);
	int i;
	int numcircles=cb.numcircles;
	cb.circa[0] = Circle((0,0),11);
	draw(cb.pic,cb.circa[0],invisible);
	for(i=1; i<=numcircles; ++i) {
		cb.circa[i]=Circle(5.5*dir(i*360/numcircles),5.5);
		draw(cb.pic,cb.circa[i],red);
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

Circoban cb = Circoban(24,18);
unitsize(cb.pic,1inches);
drawcircoban(cb);
shipout(cb.pic);