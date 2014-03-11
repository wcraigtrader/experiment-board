// Experiment Board
// Implementation by W. Craig Trader is dual-licensed under 
// Creative Commons Attribution-ShareAlike 3.0 Unported License and
// GNU Lesser GPL 3.0 or later.

include <functions.scad>;

// ----- Measurements ---------------------------------------------------------

BB_WIDTH  = (2+5/32) * inch;
BB_HEIGHT = 6.5 * inch;

$fn=30;

// ----- Parts ----------------------------------------------------------------

module breadboard() {
	x = BB_WIDTH;
	y = BB_HEIGHT;

	hdx = 4.63;
	hdy = 4.63;
	hole = 2;

	holes = [
		[ 0+hdx, 0+hdy ],
		[ x-hdx, 0+hdy ],
		[ 0+hdx, y-hdy ],
		[ x-hdx, y-hdy ]
	];

	difference() {
		square( [x,y] );
		for( h = holes ) {
			translate( h ) circle( d=2 );
		}
	}
}

ardu_shape = [ 
	[  0.0, 0.0 ],
	[  53.34, 0.0 ],
	[  53.34, 66.04 ],
	[  50.8, 66.04 ],
	[  48.26, 68.58 ],
	[  15.24, 68.58 ],
	[  12.7, 66.04 ],
	[  1.27, 66.04 ],
	[  0.0, 64.77 ]
];

ardu_holes = [
	[  2.54, 15.24 ],
	[  17.78, 66.04 ],
	[  45.72, 66.04 ],
	[  50.8, 13.97 ]
];

module arduino() {
	translate( [53.34,68.58] )
	rotate( 180 )
	difference() {
		polygon( ardu_shape );
		for( h = ardu_holes ) {
			translate( h ) circle( d=2.5 );
		}
	}
}

mega_shape = [ 
	[  0.0, 0.0 ],
	[  53.34, 0.0 ],
	[  53.34, 99.06 ],
	[  52.07, 99.06 ],
	[  49.53, 101.6 ],
	[  15.24, 101.6 ],
	[  12.7, 99.06 ],
	[  2.54, 99.06 ],
	[  0.0, 96.52 ]
];

mega_holes = [
	[  2.54, 15.24 ],
	[  17.78, 66.04 ],
	[  45.72, 66.04 ],
	[  50.8, 13.97 ],
	[  2.54, 90.17 ],
	[  50.8, 96.52 ]
];

module mega() {
	translate( [53.34,101.6] )
	rotate( 180 )
	difference() {
		polygon( mega_shape );
		for( h = mega_holes ) {
			translate( h ) circle( d=2.5 );
		}
	}
}

module standoffs(row, col) {
	id = 2.5;
	od = 4.5;
	dc = 5;
	dr = 5;
	for (r=[0:row-1],c=[0:col-1]) {
		translate( [c*dc+dc/2,r*dr+dr/2] )
			difference() {
				circle( d=od );
				circle( d=id );
			}
	}
}

// ----- Boards ---------------------------------------------------------------

module board1() {
	border = 5;

	dx = BB_WIDTH + 1;
	dy = BB_HEIGHT + 5;

	difference() {
		square( [3*dx+2*border-1,dy+101.6+2*border] );

		place( [0*dx+border,border] ) breadboard();
		place( [1*dx+border,border] ) breadboard();
		place( [2*dx+border,border] ) breadboard();
	
		place( [0*dx+border,1*dy+border] ) mega();
		place( [1*dx+border,1*dy+border] ) mega();
		place( [2*dx+border,1*dy+border] ) mega();

	}

	place( [4*dx,border] ) standoffs( 6, 3 );
}

// ----- 

board1();

// standoffs( 3, 6 );
