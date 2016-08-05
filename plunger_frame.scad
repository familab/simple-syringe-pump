barrelDiameter = 21.4;
barrelSlotThickness = 3;
plungerTravel = 85;
extrusionThickness = 14.8;
wallThickness = 4;
barrelTabsMin = 24.5;
barrelTabsMax = 38.0;
barrelTabsThickness = 2.0;
screwRadius=3.2;
extrusionTabWidth=wallThickness*1.5;


//fixes render oddities
floatCorrection = 0.001; 
floatCorrection2 = 2*floatCorrection; 

// shrinking factor
shrink = 0.3; // this is to be subtracted to all tools beds in order to guarantee a tighter fit

//trap nut
nutAcross = 13.2;
nutDepth = 6.2;

nutWellDepth = nutDepth + 0.05 - shrink; //tight so it won't rattle
//nutWallThicknessFront = plungerWellDepth+3;
nutWallThicknessFront=wallThickness;
//nutWallThicknessBack = 4;
nutWallThicknessBack = 4;

nutSlotSizeX = nutWallThicknessFront;
nutSlotSizeY = nutAcross;
nutSlotSizeZ = nutAcross/2 - 5.5; // 5.5 is a subjective decided amount to compact the design
//nut
nutEdgeLength = nutAcross / (sqrt(3));
correctionFactor = 0.3;

nutCenterX = (mountXSize - nutWellDepth)/2 -floatCorrection;


//plunger frame
plunger_frame_length=plungerTravel+2*wallThickness;
plunger_frame_width=barrelTabsMin+4;
plunger_frame_thickness=extrusionThickness+2*wallThickness;
module plunger_frame(){
     translate([0,-plunger_frame_width/2,-plunger_frame_thickness/2]){
        cube([plunger_frame_length,plunger_frame_width,plunger_frame_thickness]);



    }
}

module plunger_frame_slot(){
            //open space in middle of frame
        translate([wallThickness,(-plunger_frame_width/2)+wallThickness,(-plunger_frame_thickness/2)+wallThickness]){
        cube([plunger_frame_length-wallThickness*2,plunger_frame_width-wallThickness*2,plunger_frame_thickness+floatCorrection2]);
        }
    }

plungerEndDiameter=22.0;
plungerEndThickness=2.15;
plungerStemDiameter=13.0;

module fake_plunger(){
    union(){
            rotate([0,90,0]){
            cylinder(plungerEndThickness,plungerEndDiameter/2,plungerEndDiameter/2);
             cylinder(wallThickness*8,plungerStemDiameter/2,plungerStemDiameter/2);
            }
            translate([0,-plungerEndDiameter/2,0]){
            cube([plungerEndThickness,plungerEndDiameter,plungerEndDiameter]);
            }
            translate([0,-plungerStemDiameter/2,0]){
            cube([wallThickness*8,plungerStemDiameter,plungerStemDiameter]);
            }
        }
}
module fake_extrusion(){
    translate([-plunger_frame_length/4,-extrusionThickness/2,-extrusionThickness/2]){
    cube([plunger_frame_length*2,extrusionThickness,extrusionThickness]);
    }
}

module extrusion_tab(){
    translate([0,-(barrelTabsMin/2+2*wallThickness),-(extrusionThickness/2+wallThickness)]){
    cube([wallThickness*2,barrelTabsMin+4*wallThickness,extrusionThickness+2*wallThickness]);
    }
}


// side opening to slide the nut in place
// used in nutSideHole
module nutSideOpening(){
    rotate([]){
        translate([0,-nutAcross/2,0]){
            cube([nutEdgeLength - 3*correctionFactor,nutAcross + 2*correctionFactor,2*nutWellDepth+floatCorrection2  + correctionFactor]);
        }
    }
}

// union of the nut bed and its side opening + the hole for the threaded rod 
module nutSideHole(){
    // side opening to slide the nut in position
    	translate([nutCenterX,2*centerY,threadedAxisHeight- (nutWellDepth+floatCorrection2  + 2*correctionFactor) ]){
		rotate(a=[90,0,0]){
			nutSideOpening();
	}
}
}
module nutBlock(){
    nutBlockLength=nutDepth+2*wallThickness;
    nutBlockWidth=nutAcross+2*wallThickness;
    nutBlockHeight=nutAcross+2*wallThickness;
    difference(){
        translate([-nutBlockLength/2+wallThickness,-nutBlockWidth/2,-nutBlockHeight/2]){
    cube([nutBlockLength,nutBlockWidth,nutBlockHeight]);
        }
    rotate([90,0,0]){
        nutSideHole();
    }
        
}
}

module whole_thing(){
    
difference(){
    union(){
        plunger_frame();
        translate([-(nutDepth+wallThickness),0,0]){
            rotate([180,0,0]){
        nutBlock();
            }
        }
        translate([-wallThickness,0,0]){
        extrusion_tab();
        }
        translate([plunger_frame_length/2,0,0]){
        extrusion_tab();
        }
        translate([plunger_frame_length,0,0]){
        extrusion_tab();
        }
    }
    union(){
    translate([-20,0,0]){
            rotate([0,90,0]){
            cylinder(plunger_frame_length+40,screwRadius,screwRadius);
            }
        }
        }
        translate([0,barrelTabsMin/2+wallThickness*2,0]){
        fake_extrusion();
        }
        translate([0,-(barrelTabsMin/2+wallThickness*2),0]){
        fake_extrusion();
        }
        translate([0,0,-(wallThickness+floatCorrection)]){
        plunger_frame_slot();
        }
        translate([plunger_frame_length+wallThickness/2,0,0]){
        fake_plunger();
        }
    }
    }
    
 //   whole_thing();


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
			cube([plunger_frame_thickness+floatCorrection2,plunger_frame_width-wallThickness*2,plunger_frame_length-wallThickness*2],center=true);
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