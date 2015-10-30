
partsPlateGap = 1;
sheetThickness = 3;
wallThickness = 3;  // minimum wall thickness
camWallThickness = 8; // minumiu wall thinkens on the cam
crankHandleRadius = 20 ;
camSwing = 20;
screwHoleRadius = 1.5;


camOffset = crankHandleRadius;

groveDiameter = 3; // track diamerter
fnGrove = 10; 
groveResolution = 10;
returnGroveDegrees = 90;
shaftOD = 1.35;

groveRevolutions = 2;
groveDegrees = 360 * groveRevolutions;

pegResolution = 4;
screwHoleSize = 2;
baseDiameter = 20;
totalCamRadius = crankHandleRadius + wallThickness * 2 + (crankHandleRadius - camSwing) + groveDiameter;



toothWidth = 5/2;
toothLength = 10/2;
toothTipChopFactor = .3;

intermitantGearRadius = 13;
pivotArmLength = totalCamRadius * 2;

gearMeshTightnessFactor= .5+.1;
handCrankGearRadius = 7;
fn = 20;
camSledLengthFactor = 2;
camArmLength = totalCamRadius + intermitantGearRadius + (toothLength * gearMeshTightnessFactor);
handCrankGearTranslate = totalCamRadius + handCrankGearRadius + (toothLength * gearMeshTightnessFactor);

module shaftHole()
{
    circle(shaftOD/2,  $fn = fn);
}
//#shaftHole();   


module partsPlate()
{
        {
    color("lightgreen")
    crankBottom();
    translate([totalCamRadius*2 + toothLength,0,sheetThickness]) color("lightblue")
    crank();
    }
    translate([totalCamRadius + toothLength, totalCamRadius + toothLength,0]) color("lightpink")
    camArm();
    
    translate([0,camArmLength + wallThickness + toothLength ,0]) color("red")
    intermitantGear();
    
    translate([-baceLengthX + totalCamRadius + toothLength - partsPlateGap , 0,0])
    bace();
    translate([0,-(handCrankGearTranslate + wallThickness + toothLength), 0]) color("pink")
    handCrankGear();
    translate([totalCamRadius + toothLength, -totalCamRadius - toothLength,0]) color("lightpink")
    camSled();
    
    
}
partsPlate();

module assemble()
{
    rotate(90){
    color("lightgreen")
    crankBottom();
    translate([0,0,sheetThickness]) color("lightblue")
    crank();
    }
    translate([0,wallThickness, sheetThickness *2]) color("lightpink")
    camArm();
    
    translate([0,camArmLength + wallThickness ,0]) color("red")
    intermitantGear();
    
    translate([0,0,-10])
    bace();
    translate([0,-(handCrankGearTranslate + wallThickness), 0]) color("pink")
    handCrankGear();
    
}
//assemble();


module handCrankGear()
{
    difference()
   { 
    union()
    {
        gear(handCrankGearRadius);
        circle(handCrankGearRadius, $fn = fn);
    }
    shaftHole();
    translate([handCrankGearRadius - wallThickness/2,0,0])
    shaftHole();
    
}
    
}
//handCrankGear();




baceLengthX = 150;
baceLengthY = 150;

module screwHole()
{
      circle(screwHoleRadius,  $fn = fn);  
}

module bace()
{
    union()
    {
        difference()
        {
            square([baceLengthX,baceLengthY],center = true);
            shaftHole();
            translate([0,(camArmLength + wallThickness), 0])
            shaftHole(); // intermitant gear hole
            translate([0,-(handCrankGearTranslate + wallThickness), 0])
            shaftHole(); // hand crank gear 
            translate([pivotArmLength,wallThickness, 0]) color("red")
            shaftHole();
            for ( screwHoleDeg = [45:90:360 + 45])
            {
                rotate(screwHoleDeg)
                translate([baceLengthX/2 ,0,0])
                screwHole();
            }
        }
    
    }
}
//bace();

module intermitantGear()
{
    
    union()
    {
    difference()
    {
        circle(intermitantGearRadius, $fn = fn);
        shaftHole();
    }
    rotate(4)
    gear(intermitantGearRadius);
    }
    
}

   
//intermitantGear();

module camArm()
{
    
    union()
    {
        
        difference()
        {
        translate([-camWallThickness/2,-camWallThickness/2,0])  
        square([camWallThickness,camArmLength + camWallThickness]);
            
        shaftHole();
            translate([0,camArmLength,0])
            shaftHole();
        }
       
        
        difference()
        {
        translate([camWallThickness/2,-camWallThickness/2,0])
        
        square([pivotArmLength,camWallThickness]);
        translate([pivotArmLength,0,0])
            shaftHole();
        }
        }
    }
//#camArm();

module camSled()
{
    difference()
    {
        resize([groveDiameter * camSledLengthFactor ,0,0]){
        circle(groveDiameter/2, $fn = fn);   }
        circle(shaftOD/2,  $fn = fn);
    }
        
}
//camSled();

module camTrackPegs()
{
    for ( i = [0:200:groveDegrees * pegResolution])
    {
        
        rotate(i/pegResolution + 180)
        translate([i* (camSwing/groveDegrees/pegResolution) + wallThickness,0,0])
        circle(shaftOD/2, center = true, $fn = fnGrove);
        rotate(i/pegResolution)
        translate([totalCamRadius -wallThickness,0,0])
        circle(shaftOD/2, center = true, $fn = fnGrove);
    }
 //   translate([-3,-1,0]) rotate(10)
 //   {
    
 //       for ( i = [0:-20:-returnGroveDegrees * groveResolution])
 //       {
        
 //           rotate(i/groveResolution - returnGroveDegrees)
//            translate([i* (camSwing/returnGroveDegrees/groveResolution) - groveDiameter,0,0])
//            #circle(groveDiameter/2, center = true, $fn = fnGrove);
//        }
//    }
    
    
}




module camTrack()
{
    for ( i = [0:20:groveDegrees * groveResolution])
    {
        
        rotate(i/groveResolution)
        translate([i* (camSwing/groveDegrees/groveResolution) + wallThickness,0,0])
        circle(groveDiameter/2, center = true, $fn = fnGrove);
    }
 //   translate([-3,-1,0]) rotate(10)
 //   {
    
 //       for ( i = [0:-20:-returnGroveDegrees * groveResolution])
 //       {
        
 //           rotate(i/groveResolution - returnGroveDegrees)
//            translate([i* (camSwing/returnGroveDegrees/groveResolution) - groveDiameter,0,0])
//            #circle(groveDiameter/2, center = true, $fn = fnGrove);
//        }
//    }
    
    
}


module crank()
{
    difference()
    {   
        
        circle(totalCamRadius, center = true);
        camTrack();
        camTrackPegs();
        circle(shaftOD/2,center = true, $fn=fn);
    }
}

//crank();

module crankBottom()
{ 
    union(){
    difference()
    {   
        
        circle(totalCamRadius, center = true);
        camTrackPegs();
        circle(shaftOD/2,center = true,$fn=fn);
    }
    gear(totalCamRadius);
}
}
//crankBottom();

module tooth()
{
    difference()
    {
    rotate(90)
    resize([toothLength,toothWidth,0])
    translate([0,0,0])
    circle(toothWidth, $fn = 3, center = false);
    translate([0,toothLength - toothLength * toothTipChopFactor,0])
    square(toothWidth, center = true);
    translate([toothWidth/3,-toothLength/2,0])
    square([toothWidth, toothLength]);
        translate([-toothWidth/3-toothWidth,-toothLength/2,0])
    square([toothWidth, toothLength]);
        
    }
}
//tooth();

module gearNTeeth(NTeeth)
{
    gearRadius = NTeeth * toothWidth/ (3.14 * 2);
    cercumfrance = 3.14 * gearRadius * 2;
    echo(cercumfrance);
    teethPerGear = cercumfrance/ toothWidth;
    degreesPerTooth = 360 / teethPerGear;
    echo("gearDiameter = ",gearRadius * 2);
    
for (y = [0:1:teethPerGear])
{
    echo(y);
    rotate(y * degreesPerTooth)
    translate([0,gearRadius,0]) tooth();
        
}
}

//gearNTeeth(100);

module gear(aimRadius) // will round the aim radius so that the teeth closest number of teeth fit. 
{
    
    aimCercumfrance = (aimRadius + toothLength/4) * 3.14 * 2;
    teethInAimCercumfrance = round(aimCercumfrance / toothWidth);
    cercumfrance = teethInAimCercumfrance * toothWidth;
    gearRadius = cercumfrance / (2 * 3.14);
    
    
 
    
    
    teethPerGear = cercumfrance/ toothWidth;
    degreesPerTooth = 360 / teethPerGear;
    echo("gearDiameter = ",gearRadius * 2);
    
for (y = [1:1:teethPerGear])
{
    echo(y);
    rotate(y * degreesPerTooth)
    translate([0,gearRadius,0]) tooth();
        
}
}

//gear(50);



