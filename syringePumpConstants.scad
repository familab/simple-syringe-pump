
$fs = 0.1;

inch = 25.4; //for mm conversion
/* === Project-universal Constants === */

//Not all of these variables are used in this specific model,
//but the same variable set is used across all models in this project.


//width of base

// 8020 profile is 1 inch wide
//baseSizeY = 2*inch;
//screwPlateSize = 25;	
//screwRadius = 3.5;

// OpenBeam is 15mm wide
baseSizeY = 2*15;
screwPlateSize = 15;	
screwRadius = 1.5;

centerY = baseSizeY / 2; //both axes go right down the middle of the base

//stepper motor
stepperZSize = 42;
stepperYSize = 42;

//608 bearing 
bearing608Height = 8.5;
bearing608Diameter = 22.5;

//height of holder for 80/20 screws
mountPlateHeight = 5;

//axis heights
threadedAxisHeight = stepperZSize/2 + mountPlateHeight + 4;
echo("threadedAxisHeight ", threadedAxisHeight);
smoothAxisHeight = (threadedAxisHeight-6.6) / 2;
smoothRodRadius = 4.2;

//syringe properties
//barrelDiameter = 25;
//
//barrelSlotThickness = 3;
//barrelSlotHeight = 28;

// 20ml BD plastic disposable syringe REF 302830
barrelDiameter = 21.5;
barrelSlotThickness = 3;
barrelSlotHeight = 28;

syringeCenterHeight = threadedAxisHeight + bearing608Diameter/2 + 4 + barrelDiameter/2;

//fixes render oddities
floatCorrection = 0.001; 
floatCorrection2 = 2*floatCorrection; 

barrelDiameter = 21.4;
barrelSlotThickness = 3;
plungerTravel = 85;
extrusionThickness = 14.8;
wallThickness = 3;
barrelTabsMin = 24.5;
nemaWidth=28.5;
barrelTabsMax = 38.0;
barrelTabsThickness = 2.0;
//screwRadius=3.2;
//screwRadius=3.875; //wtf where did that come from?
extrusionTabWidth=wallThickness*1.5;
