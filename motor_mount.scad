$fs=0.01;

y_axis = [0,0,90];

boltDiameter = 4;
boltRadius = boltDiameter/2;

wallThickness = 5;

screwRadius=1.5;

motorDiameter = 23; // NEMA 11
motorRadius = motorDiameter/2;

frameWidth = motorDiameter + wallThickness + 1/2 + (wallThickness + 1)*2;
extrusionThickness = 14.8;

motor_mount(2*wallThickness);


module motor_mount(height){
	difference()
	{
		motor_board(frameWidth+24, frameWidth, height);
		cut_section();	
		
		motor_section(motorRadius, height*2);
		
		translate([0,0,-height])
			bolts_at_corners(motorRadius, motorRadius, height*2, boltRadius); 
		
		#fake_extrusions();   //negative - will be visible in rendering only	
	}
}

module motor_board(length, width, height)
{
	union()
	{
		// motor board
		cube([width, width, height], center=true);
		
		// extrusion support board
		cube([length, width/2, height], center=true);
	}
}

module cut_section(){
	translate([0, 0, frameWidth+wallThickness])
		rotate([45, 0, 0])
			translate([-frameWidth, 0, -frameWidth*2])
				cube(size=[frameWidth*4, frameWidth*2, frameWidth*4]);
	
	translate([frameWidth/2, 0, -partThickness/2]){
			rotate([0,90,0]){
				#cylinder(r=screwRadius,h=frameWidth);
			}
		}
	 translate([-frameWidth*3/2, 0, -partThickness/2]){
			rotate([0,90,0]){
				#cylinder(r=screwRadius,h=frameWidth);
			}
		}
}

module bolt_section(radius, height){
	cylinder(r=radius, h=height);
}

module motor_section(radius, height){
	cylinder(r=radius, h=height, center=true);
}

module bolts_at_corners(length, width, height, radius){
	translate([length, width, 0])
		bolt_section(radius, height);
	translate([-length, width, 0])
		bolt_section(radius, height);
	translate([length, -width, 0])
		bolt_section(radius, height);
	translate([-length, -width, 0])
		bolt_section(radius, height);
}
	
module extrusion_support(width, height){
	cube([width,width, height]);
}

module fake_extrusions(){
    translate([motorRadius+wallThickness/2, -extrusionThickness/2,-(extrusionThickness/2 +wallThickness)])
    {
		extrusion_support(extrusionThickness, 100);
    }
    
    translate([-motorRadius-extrusionThickness-wallThickness/2 ,-extrusionThickness/2,-(extrusionThickness/2 +wallThickness)])
    {
		extrusion_support(extrusionThickness, 100);
    }
}	