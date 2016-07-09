include <syringePumpConstants.scad>

wall_thickness = 5;
//	motor_width = 42; // NEMA 17
motor_width = 28.5; // NEMA 11
frame_width = motor_width + (wall_thickness + 1)*2;
bolt = 4;
height=0;



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
    translate([wall_thickness+nemaWidth+extrusionThickness+1,-55,-(extrusionThickness/2 +wall_thickness)])
    {
    rotate([0,0,90]){
        cube([100,extrusionThickness,extrusionThickness]);
    }
    }
}

translate([0,0,wall_thickness]){
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
                    translate([0,0,-(frame_width+2*wall_thickness)/2]){
                    cube([frame_width, 2*wall_thickness, frame_width]);
                       //todo where do the 12 and 24 come from? 
                        translate([-12,0,2*wall_thickness]){
                    cube([frame_width+24, 2*wall_thickness, frame_width/2]);
                        }
                }
            }

//negative
            fake_extrusion();
                //nema 11 mount
                rotate([90, 0, 0])
                {
                    translate([frame_width/2+0.5, height - 5, -wall_thickness])
                    {
                        //todo where are all of these 10's and 11's coming from?
                        translate([11.5, 11.5, -2*wall_thickness])
                            cylinder(r=bolt/2, h=4*wall_thickness+1);
                        translate([-11.5, 11.5, -2*wall_thickness])
                            cylinder(r=bolt/2, h=4*wall_thickness+1);
                        translate([11.5, -11.5, -2*wall_thickness])
                            cylinder(r=bolt/2, h=4*wall_thickness+1);
                        translate([-11.5, -11.5, -2*wall_thickness])
                            cylinder(r=bolt/2, h=4*wall_thickness+1);
                        translate([0, 0, -2*wall_thickness])
                            cylinder(r=11.5, h=4*wall_thickness+1);
                        
                    }
                }
                translate([-frame_width, wall_thickness, -wall_thickness]){
                    rotate([0,90,0]){
                        cylinder(r=screwRadius,h=frame_width);
                    }
                }
              translate([frame_width, wall_thickness, -wall_thickness]){
                    rotate([0,90,0]){
                        cylinder(r=screwRadius,h=frame_width);
                    }
                }
            }
        }
    }