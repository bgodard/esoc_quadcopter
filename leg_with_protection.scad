use <hex_trap.scad>
LEG_WIDTH=10.1;
STRENGHTEN_LEG_LENGTH=60;
STRENGHTEN_LEG_THICK=4;
START_X_LEG=16;
LEG_DIAMETER=18.5;
CONNECTOR_WIDTH=5;
CONNECTOR1_LENGTH=30;

CONNECTOR1_X=9;
CONNECTOR1_Y=-18.0;
CONNECTOR2_LENGTH=30;
CONNECTOR2_X=6;

CONNECTOR3_LENGTH=30;
CONNECTOR3_X=1.8;
CONNECTOR3_Y=-44;
CONNECTOR2_Y=(CONNECTOR1_Y+CONNECTOR3_Y)/2;
CONNECTOR_LESS=0.5;
//Screw standards
SCREW_STANDARD_M2=2;
SCREW_STANDARD_M3=3;
SCREW_STANDARD_M6=6;
NUT_HEIGHT_M2=1.6;
NUT_HEIGHT_M3=2.5;
//GUARD MAIN BOX
GUARD_Y_POS=-31.5;
GUARD_HEIGHT1=30;
GUARD_LENGTH=40;
GUARD_WIDTH=LEG_WIDTH+5;
SLICE_HEIGHT=2.8;
ZIPTIE_WIDTH=4;
ZIPTIE_HEIGHT=1.8;
STRENGHTEN_LEG_LENGTH_EXTRA=40;

SCALE_PROPELLER=0.9;
module zip_ties_back()
{
    //CONNECTION SLOT
    translate([39,CONNECTOR1_Y-ZIPTIE_WIDTH-ZIPTIE_WIDTH/2,0]) color([0,1,1]) rotate([0,0,0]) cube([5,ZIPTIE_WIDTH,LEG_WIDTH+0.2],center=true);
    
    translate([39,CONNECTOR2_Y-ZIPTIE_WIDTH-ZIPTIE_WIDTH/2+1,0]) color([0,1,1]) rotate([0,0,0]) cube([5,ZIPTIE_WIDTH,LEG_WIDTH+0.2],center=true);
    
}
module zip_ties_front()
{
    //CONNECTION SLOT
    translate([CONNECTOR1_X-0.7,CONNECTOR1_Y-ZIPTIE_WIDTH-ZIPTIE_WIDTH/2,0]) color([0,1,1]) rotate([0,0,0]) cube([ZIPTIE_HEIGHT,ZIPTIE_WIDTH,LEG_WIDTH*5+0.2],center=true);
    
    translate([CONNECTOR2_X-2.3,CONNECTOR2_Y-ZIPTIE_WIDTH-ZIPTIE_WIDTH/2+1,0]) color([0,1,1]) rotate([0,0,0]) cube([ZIPTIE_HEIGHT,ZIPTIE_WIDTH,LEG_WIDTH*5+0.2],center=true);
    
}
module connectors(less)
{
    //CONNECTION SLOT
    translate([CONNECTOR1_X,CONNECTOR1_Y,-CONNECTOR_LESS/2]) color([0,1,0]) rotate([0,0,-8]) cube([5,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR1_X-CONNECTOR1_LENGTH/2,CONNECTOR1_Y,-CONNECTOR_LESS/2])cube([CONNECTOR1_LENGTH,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR2_X,CONNECTOR2_Y,-CONNECTOR_LESS/2]) color([0,1,0]) rotate([0,0,-8]) cube([5,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR2_X-CONNECTOR2_LENGTH/2,CONNECTOR2_Y,-CONNECTOR_LESS/2])cube([CONNECTOR2_LENGTH,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR3_X,CONNECTOR3_Y,-CONNECTOR_LESS/2]) color([0,1,0]) rotate([0,0,-8]) cube([5,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR3_X-CONNECTOR3_LENGTH/2,CONNECTOR3_Y,-CONNECTOR_LESS/2])cube([CONNECTOR2_LENGTH,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
}
module leg_stl_only()
{
    translate([0,0,-11.7]) import("stls/F450_leg-mine_long.stl", convexity=3);
}
module leg_prop_front_piece()
{
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2-29,-52+STRENGHTEN_LEG_LENGTH_EXTRA/2,0]) rotate([0,0,-21]) #cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH_EXTRA+5,LEG_WIDTH],center=true);
}
module leg_prop()
{
    leg_stl_only();
    //LEG EXTENSION
    translate([START_X_LEG-STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
    
    difference(){
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2,-52+STRENGHTEN_LEG_LENGTH_EXTRA/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH_EXTRA,LEG_WIDTH],center=true);
    zip_ties_back();
    }
    difference(){
    leg_prop_front_piece();
    zip_ties_front();}
    difference()
    {
    translate([START_X_LEG+LEG_DIAMETER/2,-16+STRENGHTEN_LEG_LENGTH,0])  cylinder(h=LEG_WIDTH,r=LEG_DIAMETER/2+STRENGHTEN_LEG_THICK,center=true);
        union()
        {
            translate([START_X_LEG+LEG_DIAMETER/2,-16+STRENGHTEN_LEG_LENGTH,0]) color([1,0,0]) cylinder(h=LEG_WIDTH+0.1,r=LEG_DIAMETER/2,center=true);
    translate([START_X_LEG+LEG_DIAMETER/2,-16+STRENGHTEN_LEG_LENGTH-LEG_DIAMETER/2,0]) color([1,0,0]) cube([LEG_DIAMETER,LEG_DIAMETER,LEG_WIDTH+0.1],center=true);
        }
    }
    difference()
    {
        connectors(less=CONNECTOR_LESS);
        union()
        {
        guardhole();
        zip_ties_front();
        }
    }
    //guardhole();
    //connectors(less=0);
}
module sub_guard()
{
    difference(){
    
    translate([12,0,0])scale([SCALE_PROPELLER,SCALE_PROPELLER,1]) import("stls/Protection_hlices_v6.stl", convexity=3);
    translate([120,10,8.0])cube([400,400,10],center=true);
    }
}
module sub_guard_slice()
{

    intersection(){
    sub_guard();
    translate([120,10,0.1+SLICE_HEIGHT/2]) cube([400,400,SLICE_HEIGHT],center=true);}
   
    
}
module guard()
{
    sub_guard();

    translate([0,0,-SLICE_HEIGHT]) sub_guard_slice();

}
module guardhole()
{
    translate([-GUARD_LENGTH/2+13,GUARD_Y_POS-GUARD_HEIGHT1/2-0.1,0]) color([0,0,1])rotate([90,0,0]) hex_hole(h_trap=NUT_HEIGHT_M3+0.1,h_hole=GUARD_HEIGHT1-NUT_HEIGHT_M3+1.1,r_trap=SCREW_STANDARD_M3,rot=180);
}
module guard2()
{
    
    difference(){
        union(){
    translate([16-GUARD_LENGTH/2-5,GUARD_Y_POS-GUARD_HEIGHT1/2+SLICE_HEIGHT,0]) cube([GUARD_LENGTH+10,SLICE_HEIGHT*2,GUARD_WIDTH*2+5],center=true);
    translate([16-GUARD_LENGTH/2,GUARD_Y_POS,0]) cube([GUARD_LENGTH,GUARD_HEIGHT1,GUARD_WIDTH],center=true);
        }
    union(){
        guardhole();
        connectors(less=0);
        leg_prop_front_piece();
        translate([0,0,10])  leg_stl_only();
         leg_stl_only();
        translate([0,0,-10])  leg_stl_only();
        translate([9-GUARD_LENGTH,GUARD_Y_POS+GUARD_HEIGHT1/2,0]) rotate([0,0,60]) cube([GUARD_LENGTH,GUARD_HEIGHT1,GUARD_WIDTH],center=true);
        translate([18,-30,0]) rotate([0,0,-20]) cube([15,60,60],center=true);
        zip_ties_front();
        }
    }
}
module propeller_guard()
{
    difference(){
        translate([0,-43.5,-118.5]) rotate([0,-90,90]) guard();
        union(){
        connectors(less=0);
        zip_ties_front();
        }
    }
    guard2();
}

module main()
{

mirror([0,0,1]) leg_prop();    
propeller_guard();
}




main();

//temporary artifacts
//leg_prop();//the output of this command should be reloaded in the meshmixer and used to regenerate "leg_combined.stl" 

//final artifacts
//rotate([0,180,0]) mirror([0,0,1]) import("stls/leg_combined.stl", convexity=3);

//rotate([90,0,0]) propeller_guard();

//guard2();

//TEMPORARY
/*
difference()
    {
        connectors(less=CONNECTOR_LESS);
        guardhole();
    }
*/
//fit_test
/*
    intersection()
{
    leg_prop();
    translate([0,-35,0])#cube([60,60,60],center=true);
}*/
//translate([0,20,GUARD_HEIGHT1+LEG_WIDTH]) rotate([90,0,0]) guard2();
