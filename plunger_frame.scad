plungerTravel = 85;
extrusionThickness = 14.8;
wallThickness = 4;
barrelTabsMin = 24.5;
screwRadius=3.2;

//plunger frame
plunger_frame_length=plungerTravel+2*wallThickness;
plunger_frame_width=barrelTabsMin+4;
plunger_frame_thickness=extrusionThickness+2*wallThickness;

nutAcross = 13.2;
nutDepth = 6.2;
nutBlockLength=nutDepth+2*wallThickness;
nutBlockWidth=nutAcross+2*wallThickness;
nutBlockHeight=nutAcross+wallThickness;
plungerEndDiameter=22.0;
plungerEndThickness=2.15;
plungerStemDiameter=13.0;

difference() {
	union() {
		//main frame
		difference() {
			union() {
				cube([plunger_frame_thickness,plunger_frame_width,plunger_frame_length],center=true); // main frame
				cube([extrusionThickness+2*wallThickness,barrelTabsMin+4*wallThickness,wallThickness*2],center=true);
				translate([0,0,plunger_frame_length/2-wallThickness])
					cube([extrusionThickness+2*wallThickness,barrelTabsMin+4*wallThickness,wallThickness*2],center=true);
				translate([0,0,-plunger_frame_length/2+wallThickness])
					cube([extrusionThickness+2*wallThickness,barrelTabsMin+4*wallThickness,wallThickness*2],center=true);
			}
			cube([2*plunger_frame_thickness,plunger_frame_width-wallThickness*2,plunger_frame_length-wallThickness*2],center=true);
		}
		
		//captive nut
		difference() {
			translate([0,0,plunger_frame_length/2+wallThickness]) // captive nut
				cube([nutBlockHeight,nutBlockWidth,nutBlockLength],center=true);
			translate([0,0,plunger_frame_length/2+nutDepth/2])
				cube([plunger_frame_thickness,nutAcross,nutDepth],center=true);
		}
		
		//plunger holder
		difference() {
			translate([0,0,-plunger_frame_length/2-(plungerEndThickness+wallThickness)/2]) // plunger 
				cube([plunger_frame_thickness,plunger_frame_width,plungerEndThickness+wallThickness],center=true);
			translate([0,0,-plunger_frame_length/2-plungerEndThickness/2])
				cube([plunger_frame_thickness*2,plungerEndDiameter,plungerEndThickness],center=true);
			translate([0,0,-wallThickness-plunger_frame_length/2])
				cylinder(wallThickness*2,d=plungerStemDiameter,center=true);
			translate([plungerStemDiameter/2,0,-wallThickness-plunger_frame_length/2])
				cube([plungerStemDiameter,plungerStemDiameter,wallThickness*2],center=true);
		}
	}
	//threaded rod
	cylinder(plunger_frame_length+40,screwRadius,screwRadius,center=true);
	//aluminum extrusions
	translate([0,barrelTabsMin/2+wallThickness*2,0])
		cube([extrusionThickness,extrusionThickness,plunger_frame_length*2],center=true);
	translate([0,-(barrelTabsMin/2+wallThickness*2),0])
		cube([extrusionThickness,extrusionThickness,plunger_frame_length*2],center=true);
}