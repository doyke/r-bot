use <vslot.scad>;

sectionCountWidth=1;
sectionCountDepth=2;
screwDiameter=5;
tolerance=.9;
wallWidth=2;
profileSize=20;
sideNum = 1;
allTogether = true;

holeDistWidth=83;
holeDistHeight=31;
blockHeight = wallWidth*2 + sectionCountWidth*profileSize;
blockWidth = wallWidth*2 + sectionCountDepth*profileSize;
cubeX = holeDistHeight+screwDiameter+2*wallWidth;
cubeZ = holeDistWidth+screwDiameter+2*wallWidth;

mirror([sideNum == 1 ? 0 : 1, 0, 0])
difference() {
    cube([cubeX,blockWidth,cubeZ]);
    translate([wallWidth+screwDiameter/2, 0, wallWidth+screwDiameter/2])
    {
        rotate([-90,0,0])
            cylinder(r=screwDiameter/2,h=blockWidth, $fn=90);
        translate([0, 0, holeDistWidth])
            rotate([-90,0,0])
            cylinder(r=screwDiameter/2,h=blockWidth, $fn=90);
    }
    translate([wallWidth+screwDiameter/2 + holeDistHeight, 0, wallWidth+screwDiameter/2])
    {
        rotate([-90,0,0])
            cylinder(r=screwDiameter/2,h=blockWidth, $fn=90);
        translate([0, 0, holeDistWidth])
            rotate([-90,0,0])
            cylinder(r=screwDiameter/2,h=blockWidth, $fn=90);
    }
    translate([(cubeX-(sectionCountWidth*profileSize))/2,wallWidth,0])
        drawVslotExtrusion(
            height=cubeZ,
            sectionCountWidth=sectionCountWidth, 
            sectionCountDepth=sectionCountDepth, 
            topIndent=true, 
            rightIndent=true, 
            leftIndent=true, 
            bottomIndent=true, 
            oversize=tolerance,
            //screwOffset,
            topScrewPoints = [cubeZ/2, cubeZ/2 + profileSize]
            //rightScrewPoints = [],
            //topScrewPoints = [],
            //bottomScrewPoints = [],
            //backScrewPoints = []
    );
    if (allTogether != true)
    {
        translate ([sideNum == 1 ? 0 : cubeX, 0, 0])
        mirror([sideNum == 1 ? 0 : 1, 0, 0]) {
            linear_extrude(h=cubeZ) 
                polygon(points=[
                    [0,wallWidth-tolerance/2], 
                    [(cubeX-(sectionCountWidth*profileSize))/2-tolerance/2,wallWidth-tolerance/2],
                    [cubeX-(cubeX-(sectionCountWidth*profileSize))/2+tolerance/2,blockWidth-wallWidth+tolerance/2],
                    [cubeX+tolerance/2, blockWidth-wallWidth+tolerance/2],
                    [cubeX+tolerance/2, blockWidth+tolerance/2],
                    [0, blockWidth]
                ]);
        }
    }
    /*
    translate([-(holeDistHeight-blockHeight)/2+holeDistHeight, 0, cylinderRadius])
        rotate([-90,0,0])
        cylinder(r=cylinderRadius,h=blockWidth, $fn=90);
    translate([-(holeDistHeight-blockHeight)/2+holeDistHeight, 0, cylinderRadius+holeDistWidth])
        rotate([-90,0,0])
        cylinder(r=cylinderRadius,h=blockWidth, $fn=90);
    */
}



