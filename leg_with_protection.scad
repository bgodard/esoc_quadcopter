use <hex_trap.scad>
LEG_WIDTH=10.1;
STRENGHTEN_LEG_LENGTH=120;
STRENGHTEN_LEG_THICK=4;
START_X_LEG=16;
LEG_DIAMETER=17.5;
CONNECTOR_WIDTH=5;
CONNECTOR1_LENGTH=45;
CONNECTOR1_X=10;
CONNECTOR1_Y=-24;
CONNECTOR2_LENGTH=40;
CONNECTOR2_X=4;
CONNECTOR2_Y=-40;
CONNECTOR_LESS=0.2;
//Screw standards
SCREW_STANDARD_M2=2;
SCREW_STANDARD_M3=3;
SCREW_STANDARD_M6=6;
NUT_HEIGHT_M2=1.6;
NUT_HEIGHT_M3=2.5;
//GUARD MAIN BOX
GUARD_Y_POS=-31.5;
GUARD_HEIGHT1=30;
GUARD_LENGTH=30;
module connectors(less)
{
    //CONNECTION SLOT
    translate([CONNECTOR1_X,CONNECTOR1_Y,0]) color([0,1,0]) rotate([0,0,-8]) cube([5,CONNECTOR_WIDTH,LEG_WIDTH],center=true);
    translate([CONNECTOR1_X-CONNECTOR1_LENGTH/2,CONNECTOR1_Y,0])cube([CONNECTOR1_LENGTH,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
    translate([CONNECTOR2_X,CONNECTOR2_Y,0]) color([0,1,0]) rotate([0,0,-8]) cube([5,CONNECTOR_WIDTH,LEG_WIDTH],center=true);
    translate([CONNECTOR2_X-CONNECTOR2_LENGTH/2,CONNECTOR2_Y,0])cube([CONNECTOR2_LENGTH,CONNECTOR_WIDTH-less,LEG_WIDTH-less],center=true);
}
module leg_prop()
{
    translate([0,0,-11.7]) import("stls/F450_leg-mine_long.stl", convexity=3);
    //LEG EXTENSION
    translate([START_X_LEG-STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
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
        guardhole();
    }
}
module guard()
{
    
    difference(){
    import("stls/Protection_hlices_v6.stl", convexity=3);
    translate([120,10,8.0])#cube([40,20,10],center=true);
    }
}
module guardhole()
{
    translate([-GUARD_LENGTH/2,GUARD_Y_POS-GUARD_HEIGHT1/2-0.1,0]) color([0,0,1])rotate([90,0,0]) hex_hole(h_trap=NUT_HEIGHT_M3+0.1,h_hole=GUARD_HEIGHT1-NUT_HEIGHT_M3+0.1,r_trap=SCREW_STANDARD_M3,rot=180);
}
module guard2()
{
    difference(){
    translate([-14,GUARD_Y_POS,0]) cube([GUARD_LENGTH,GUARD_HEIGHT1,LEG_WIDTH*2],center=true);
    guardhole();
    }
}
module main()
{
rotate([90,0,90]) leg_prop();
translate([130,0,-50]) rotate([0,0,180]) guard();
}
//guard();
//leg_prop();
import("stls/leg_combined.stl", convexity=3);
//difference()
//{
//    guard2();
//    connectors(less=0);
//}
//main();
