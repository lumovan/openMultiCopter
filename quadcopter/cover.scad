/**
 * cover.scad
 * quadcopter cover. It has to hold GPS module
 * 
 * Created by Diego Viejo on 09/Jun/2015
 * 
 * After printing, remove supporting 'cylinder and cones' structure 
 */

include<config.scad>
include<../commons/config.scad>
include<../extras/Write.scad>


perc = 0.55;

difference()
{
    union()
    {
        difference()
        {
            intersection()
            {
                ellipsoid(w = baseWidth, h=baseLength);
                translate([-200, -200, 0]) cube([400, 400, baseWidth*perc]);
            }
    
            difference()
            {
                intersection()
                {
                    translate([0,0,-1]) ellipsoid(w = baseWidth-2, h=baseLength-1);
                    translate([-200, -200, -1]) cube([400, 400, 1+(baseWidth-3)*perc]);
                }
                translate([-3/2, baseLength+5-25, -1]) cube([3, 5+15, 35]);
                translate([-4/2, -baseLength, -1]) cube([4, 5+15, 35]);
                hull()
                {
                    translate([-3/2, baseLength+5-25, baseWidth*0.1]) cube([3, 15, 1]);
                    translate([-3/2, baseLength-50, (baseWidth-3)*perc]) cube([3, 25, 1]);
                }
                mirror([0,1,0]) hull()
                {
                    translate([-4/2, baseLength+5-25, baseWidth*0.1]) cube([4, 15, 1]);
                    translate([-4/2, baseLength-50, (baseWidth-3)*perc]) cube([4, 25, 1]);
                }
                
                //receiver antenna
                translate([0, -baseLength+4,-1]) cylinder(d=9, h=20);
                
                //ends
                translate([-60/2, baseLength*0.89, -1]) cube([60, 20, 4]); 
                translate([-60/2, -baseLength*0.89-20, -1]) cube([60, 20, 4]);
                translate([(baseWidth-6)*0.925, -120/2, -1]) cube([20,120,4]);
                mirror([1,0,0]) translate([(baseWidth-6)*0.925, -120/2, -1]) cube([20,120,4]);

                translate([-16.5/2+((sqrt(1-(0.98*0.98)))*baseWidth)-5, baseLength*0.89, -1]) cube([13, 20, 8]); 
                translate([-9.5/2-((sqrt(1-(0.98*0.98)))*baseWidth)+5, -baseLength*0.89-20, -1]) cube([13, 20, 8]); 
                
                //support cylinders (remove after printing)
                cylinder(d=15, h=baseWidth*0.3+1);
                cylinder(d1=20, d2=10, h=5);
                translate([0, 0, baseWidth*0.3]) 
                    cylinder(d1=15, d2=44, h=(baseWidth-3)*perc-baseWidth*0.3 - 0.33);
                
                
            }
        
        }
    
        
        //GPS support
        translate([0, -baseLength/2+20, 0]) rotate(45) 
        {
            translate([0, 0, baseWidth*perc]) cylinder(d=8, h=2);
            for(i=[0, 90]) 
                translate([0, 0, (baseWidth-1.75)*perc]) rotate(i)
                    hull()
                    {
                        translate([0-4/2, -4/2, 0]) cube([4,4,2.96]);
                        translate([-20-4/2, -4/2, 0]) cube([4,4,1]);
                        translate([20-4/2, -4/2, 0]) cube([4,4,1]);
                    }
        }
        
        //Text - TODO: automatic centering
        text1="Open Multi Copter";
        text2="Quad Prototype";
        translate([49, 5, baseWidth*perc-0.2]) rotate(180)
            write(text1, h=9.5, t=1,space=0.9);
        translate([45, 24, baseWidth*perc-0.2]) rotate(180)
            write(text2, h=10.5, t=1,space=0.9);
    
    }
            
    
    //holes for GPS
    translate([0, -baseLength/2+20, 0])
    {
        translate([0, 0, (baseWidth-3)*perc +0.3]) cylinder(d=3.25, h=5);
        for(i=[45, 135, 225, 315])
            translate([0, 0, (baseWidth-3)*perc + 0.3])
                rotate(i+45)
                    translate([10, 0, 0]) hull()
                    {
                        translate([3.25, 0, 0]) cylinder(r=2.15, h=5);
                        translate([-3.25, 0, 0]) cylinder(r=2.15, h=5);
                    }
    }
    //Antenna openning
    hull()
    {
        translate([20, -baseLength+15, 5]) rotate([90, 0, 0]) cylinder(d=11, h=20);
        translate([20, -baseLength+15, -3]) rotate([90, 0, 0]) cylinder(d=11, h=20);
    }

    //Receiver antenna
    translate([0, -baseLength+4,-1]) cylinder(d=5.25, h=20+2);
    #translate([0, -baseLength+4, 8]) cylinder(d=6.0, h=20+2);
    translate([-2.5/2, -baseLength+4,-1]) cube([2.5, 30, 3]);
    translate([-2/2, -baseLength-5,-1]) cube([2, 10, 13]);
    
    //conections for top cover
    lAux = baseLength*0.98;
    wAux = (sqrt(1-(lAux/baseLength)*(lAux/baseLength)))*baseWidth;
    for(i=[1,-1])
    {
        translate([i*(wAux-5),i*(lAux-5),2]) hull()
        {
            translate([0, i*0.2, 0])rotate(90) cylinder(d=6.5, h=3, $fn=6);
            translate([0, -i*10, 0]) rotate(90) cylinder(d=6.5, h=3, $fn=6);
        }
        translate([i*(wAux-5),i*(lAux-5),-1]) cylinder(d=3.15, h=10);
    }
}


*%translate([0, 0, -baseHeight])
import("output/mainPlatformPart2.stl");

