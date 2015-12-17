keyHeightTightness = .5;


$fn = 40;
sheetThickness = 3;
wallThickness = 3;
plankLength = .1;
wireDiameter = 1.6;
handleRadius = 15;
crankHeight = 10 + handleRadius;

pullyWidth = 9;
pegLength = wallThickness ;
pegDeapth = sheetThickness + wallThickness;

guideHeight = 4; 
legHeight = crankHeight ;//+ wallThickness * 2 * 3 *($t + 1);
flextureGive = .5;
keyHeight = legHeight/4;
totalKeyHeight = wallThickness + sheetThickness + keyHeight + sheetThickness;

slotPocketDeapth = 2;



baseWidth = pullyWidth + sheetThickness * 2 + wallThickness * 2;
baseLength = wallThickness + legHeight + baseWidth  ;

fingerHoleDiameter = baseWidth -wallThickness*2;

module halfBase()
{
    translate([-baseWidth/2 + .01, 0,0]){
    difference()
    {
        square([baseWidth/2,baseLength]);
        translate([wallThickness,wallThickness,0])
        square([sheetThickness, pegLength]);
        translate([baseWidth/2 -(pullyWidth/2 - slotPocketDeapth),0,0])
        #square([pullyWidth/2 - slotPocketDeapth, legHeight/2 + wallThickness + sheetThickness * 2]);
        translate([wallThickness,wallThickness + legHeight - pegLength,0])
        square([sheetThickness, pegLength]);
        translate([baseWidth/2, baseLength - fingerHoleDiameter/2 - wallThickness,0])
        circle(fingerHoleDiameter/2, center = true);
        
        
    }
}
}




module base()
{
halfBase();
mirror([1,0,0])    
    halfBase();
}
translate([legHeight + baseWidth,0,0]) base();





module legTriangle()
{
    difference(){
    square([legHeight,legHeight]);
    rotate(45) translate([legHeight /1.5, legHeight, 0])
    square([legHeight *2,legHeight* 2], center = true);
  
    } 
}


module legFlexture()
{
    square([legHeight/2, sheetThickness]);
    translate([wallThickness * 1.5,-wallThickness- flextureGive,0])
        square([legHeight/2 - wallThickness*1.5, flextureGive]);
    translate([legHeight/2,-flextureGive - wallThickness,0])
    square([plankLength, flextureGive + wallThickness + sheetThickness]);  
}

module keyHalf()
{

    translate([0,-pegDeapth,0])
    {
    union()
    {
        difference()
        {
        square([ pullyWidth/2, totalKeyHeight]);
                    translate([1.5,totalKeyHeight-6,0])
            #circle(1);
        translate([pullyWidth/2 -slotPocketDeapth,sheetThickness,0])
            square([slotPocketDeapth,sheetThickness]);

        } 
     translate([0,totalKeyHeight- wallThickness,0])
     square([pullyWidth/2 + sheetThickness + wallThickness, wallThickness]);
     translate([pullyWidth/2 + sheetThickness ,totalKeyHeight- wallThickness -slotPocketDeapth ,0])
     square([wallThickness,slotPocketDeapth]);   
    }
    
}

}
//keyHalf();

module key()
{
keyHalf();
mirror(1,0,0) keyHalf();
}
translate([-10,0,0])
key();




module leg()
{
    union()
    {
        difference()
        {
            legTriangle();
            translate([ legHeight - wallThickness ,legHeight - wallThickness *2.25,0])
            #circle(wireDiameter/2);
            
            translate([legHeight/6,keyHeight + keyHeightTightness,0]) rotate(1)
            legFlexture();
        }
        translate([0,-pegDeapth,0])
        square([pegLength, pegDeapth]);
        translate([legHeight- pegLength,-pegDeapth,0])
        square([pegLength, pegDeapth]);
        
                
    }
}

leg();
translate([0,40,0])
leg();