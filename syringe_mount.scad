$fs=0.01;

barrelDiameter = 21.4;

extrusionThickness=14.8;

screwRadius = 1.5;
motorWidth = 28.5; // NEMA 11

wallThickness = 5;
partThickness = 8;

frameWidth = motorWidth + (wallThickness + 1)*2;

barrel_mount();

module fake_extrusion(){
    
    translate([wallThickness+1,-50,-(extrusionThickness/2 +wallThickness)])  //voodoo
    {
		rotate([0,0,90]){
			cube([100,extrusionThickness,extrusionThickness]);
		}
    }
    
    translate([wallThickness+motorWidth+extrusionThickness+1,-55,-(extrusionThickness/2 + wallThickness)])
    {
		rotate([0,0,90]){
			cube([100,extrusionThickness,extrusionThickness]);
		}
    }
}

module barrel_mount()
{
	//center the whole thing in X
	translate([-frameWidth/2, 0, 0])
	{
		difference()
		{
			//positive
			union()
			{
				translate([0,0,-(frameWidth+10)/2]){
				cube([frameWidth, partThickness, frameWidth]);
					translate([-12,0,10]){
				cube([frameWidth+24, partThickness, frameWidth/2]);    
					}
			}
		}


		//negative
		fake_extrusion();
		rotate([90, 0, 0])
		// todo remove that rotation
			{
				translate([frameWidth/2+0.5,  -5, -wallThickness])
				{
					translate([0, 0, -10])  //wtf? double voodoo
					cylinder(r=barrelDiameter/2, h=4*wallThickness+1);

				}
				translate([(barrelDiameter/2)-0.6,-5,-10]){
				cube([barrelDiameter,barrelDiameter,barrelDiameter]);
			}
			
		  translate([-frameWidth, -wallThickness, -partThickness/2]){
				rotate([0,90,0]){
					#cylinder(r=screwRadius,h=frameWidth);
				}
			}
		 translate([frameWidth, -wallThickness, -partThickness/2]){
				rotate([0,90,0]){
					#cylinder(r=screwRadius,h=frameWidth);
				}
			}
			
			}
		}
	}
}
