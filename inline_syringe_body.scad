include <syringePumpConstants.scad>

threadedAxisHeight=0;

space_above_floor = 0;

wall_thickness = 5;
//	motor_width = 42; // NEMA 17
motor_width = 28.5; // NEMA 11
frame_width = motor_width + (wall_thickness + 1)*2;
bolt = 4;
//height = 25;
height= threadedAxisHeight;
//	inch = 25.4;
//	screwPlateSize = 25;	
//	screwRadius = 3.25;

inch = 15;
screwPlateSize = 25;	
screwRadius = 1.5;

//these are all the mount point holes.
x1 = -wall_thickness;
y1 = wall_thickness*2;
x2 = frame_width+wall_thickness;
y2 = wall_thickness*2;
x3 = -wall_thickness;
y3 = frame_width-wall_thickness*2;
x4 = frame_width + wall_thickness;
y4 = frame_width-wall_thickness*2;

module fake_extrusion(){
    
    translate([wall_thickness+1,-50,-(extrusionThickness/2 +wall_thickness)])  //voodoo
    {
    rotate([0,0,90]){
        cube([100,extrusionThickness,extrusionThickness]);
    }
    }
    
    //translate([nemaWidth,-50,-(extrusionThickness/2 +wall_thickness)])  //centered
    translate([wall_thickness+nemaWidth+extrusionThickness+1,-55,-(extrusionThickness/2 +wall_thickness)])
    {
    rotate([0,0,90]){
        cube([100,extrusionThickness,extrusionThickness]);
    }
    }
}

translate([0,0,wall_thickness + space_above_floor]){
nema_17_mount();
}
    module nema_17_mount()
    {
        //center the whole thing in X
        translate([-frame_width/2, 0, 0])
        {
            difference()
            {
                //build the main unit.
                //positive

                union()
                {
                    translate([0,0,-(frame_width+10)/2]){
                    //structure
                    //cube([wall_thickness, frame_width, frame_width]); //front face
                    cube([frame_width, wall_thickness, frame_width]); //left face
                        translate([-12,0,10]){
                    cube([frame_width+24, wall_thickness, frame_width/2]); //left face    
                        }
                    //translate([frame_width - wall_thickness, 0, 0])     //right face
                    //    cube([wall_thickness, frame_width, frame_width]);
                        

                }

            }


//negative
            fake_extrusion();
                //nema 11 mount
                rotate([90, 0, 0])
                {
                    translate([frame_width/2+0.5, height - 5, -wall_thickness])
                    {
//                        translate([11.5, 11.5, -10])
//                            #cylinder(r=bolt/2, h=4*wall_thickness+1);
//                        translate([-11.5, 11.5, -10])
//                            cylinder(r=bolt/2, h=4*wall_thickness+1);
//                        translate([11.5, -11.5, -10])
//                            cylinder(r=bolt/2, h=4*wall_thickness+1);
//                        translate([-11.5, -11.5, -10])
//                            cylinder(r=bolt/2, h=4*wall_thickness+1);
                        translate([0, 0, -10])  //wtf? double voodoo
                        cylinder(r=barrelDiameter/2, h=4*wall_thickness+1);

   
                    }
                    translate([(barrelDiameter/2)-0.6,-5,-10]){
                    cube([barrelDiameter,barrelDiameter,barrelDiameter]);
                }
                }

                //back slant cutaway
                translate([0, 0, frame_width+wall_thickness])
                    rotate([45, 0, 0])
                        translate([-frame_width, 0, -frame_width*2])
                            cube(size=[frame_width*4, frame_width*2, frame_width*4]);

            }
        }
    }