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
// internal bed for the nut
//used in nutSideHole
module nutWell(){
	//compose the outline of the 6-sided nut using 3 cubes. Yay geometry.

   rotate(a=[0,0,-30]){
	translate([-nutEdgeLength/2, -nutAcross/2, 0]){
		cube(size=[nutEdgeLength + correctionFactor,nutAcross + correctionFactor,nutWellDepth+floatCorrection2  + correctionFactor ]);
	}}

		rotate(a=[0,0,90]){
			translate([-nutEdgeLength/2, -nutAcross/2, 0]){
				cube(size=[nutEdgeLength + correctionFactor,nutAcross + correctionFactor,nutWellDepth+floatCorrection2  + correctionFactor ]);
			}
		}
	
		rotate(a=[0,0,-150]){
			translate([-nutEdgeLength/2, -nutAcross/2, 0]){
				cube(size=[nutEdgeLength + correctionFactor,nutAcross + correctionFactor,nutWellDepth+floatCorrection2  + correctionFactor ]);
			}
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
    union(){
    //nut
	translate([nutCenterX,centerY,threadedAxisHeight]){
		rotate(a=[0,90,0]){
			nutWell();
		}
	}
    
    // side opening to slide the nut in position
    	translate([nutCenterX,2*centerY,threadedAxisHeight- (nutWellDepth+floatCorrection2  + 2*correctionFactor) ]){
		rotate(a=[90,0,0]){
			nutSideOpening();
		}
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
        nutWell();
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
    
    whole_thing();
    //nutBlock();

    //    }
    
    