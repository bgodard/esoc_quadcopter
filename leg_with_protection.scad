use <hex_trap.scad>
LEG_WIDTH=10.1;
STRENGHTEN_LEG_LENGTH=60;
STRENGHTEN_LEG_THICK=4;
START_X_LEG=16;
LEG_DIAMETER=18.5;
CONNECTOR_WIDTH=5;
CONNECTOR1_LENGTH=30;

CONNECTOR1_X=6;
CONNECTOR1_Y=-26.0;
CONNECTOR2_LENGTH=30;
CONNECTOR2_X=2;

CONNECTOR3_LENGTH=30;
CONNECTOR3_X=-2.8;
CONNECTOR3_Y=-52;
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
PRESSURE_PLATE_THICKNESS1=3.5;
PRESSURE_PLATE_LENGTH=(-CONNECTOR3_Y+CONNECTOR1_Y);
PRESSURE_PLATE_THICKNESS2=2;
SCALE_PROPELLER=0.9;

HOLE1_X=23;
HOLE1_Y=-47;

PROP_GUARD_X_OFFSET=-7;
PROP_GUARD_Y_OFFSET=-7.5;
module top_out_diff_corner()
{
    translate([37,-54,6])cube([12,14,35],center=true);
    translate([37,-54,6]) rotate([0,-45,0])cube([12,14,35],center=true);
}
module pressure_plate()
{
    DIFF_CUBE_X=15;
    DIFF_CUBE_Y=55;
    DIFF_CUBE_X2=12;
    DIFF_CUBE_Z=10;
    //guard3_hole();
    difference(){
        union(){
        translate([24,-28,LEG_WIDTH/2+PRESSURE_PLATE_THICKNESS2/2+0.0]) color([1,0,1]) cylinder(r=SCREW_STANDARD_M3*1.5,h=PRESSURE_PLATE_THICKNESS1+PRESSURE_PLATE_THICKNESS2-2,center=true);
        translate([HOLE1_X,HOLE1_Y,LEG_WIDTH/2+PRESSURE_PLATE_THICKNESS2/2+0.0]) color([1,0,1]) cylinder(r=SCREW_STANDARD_M3*1.5,h=PRESSURE_PLATE_THICKNESS1+PRESSURE_PLATE_THICKNESS2-2,center=true);
        }
        guard3_hole();
    }
    //#top_out_diff_corner();
    OP_SHAPE_LENGTH=30;
    OP_SHAPE_WIDTH=3.4;
    OP_SHAPE_HEIGHT=1;
    //Angled pad
    intersection(){
        translate([32.8-OP_SHAPE_WIDTH/2,-OP_SHAPE_LENGTH/2-27.3,-OP_SHAPE_HEIGHT/2+2.8])cube([OP_SHAPE_WIDTH,20,OP_SHAPE_HEIGHT]);
        translate([32.8-OP_SHAPE_WIDTH/2,-OP_SHAPE_LENGTH/2-27.3,-OP_SHAPE_HEIGHT/2+3.8]) rotate([-3,0,0])cube([OP_SHAPE_WIDTH,40,OP_SHAPE_HEIGHT]);}
    local_angle=-21;
    local_shift=-22-0.5;
    local_shift_y=2-1;
    OP_SHAPE_WIDTH2=1.9;
    intersection(){
        translate([local_shift+32.8-OP_SHAPE_WIDTH2/2,-OP_SHAPE_LENGTH/2-27.3+local_shift_y,-OP_SHAPE_HEIGHT/2+2.8]) rotate([0,0,local_angle])cube([OP_SHAPE_WIDTH2,20,OP_SHAPE_HEIGHT]);
        translate([local_shift+32.8-OP_SHAPE_WIDTH2/2,-OP_SHAPE_LENGTH/2-27.3+local_shift_y,-OP_SHAPE_HEIGHT/2+3.8]) rotate([-3,0,0])rotate([0,0,local_angle])cube([OP_SHAPE_WIDTH2,40,OP_SHAPE_HEIGHT]);}
        //translate([32.8-OP_SHAPE_WIDTH/2,-OP_SHAPE_LENGTH/2-27.3,-OP_SHAPE_HEIGHT/2+3.6]) rotate([-3,0,0])cube([OP_SHAPE_WIDTH,40,OP_SHAPE_HEIGHT]);
    difference(){
        
        union(){
            
        translate([24,CONNECTOR2_Y+2,LEG_WIDTH/2+PRESSURE_PLATE_THICKNESS1/2]) color([1,0,0])cube([50,10+PRESSURE_PLATE_LENGTH,PRESSURE_PLATE_THICKNESS1],center=true);
        translate([24,CONNECTOR2_Y+2,LEG_WIDTH/2-PRESSURE_PLATE_THICKNESS2/2]) color([1,0,0])#cube([50,10+PRESSURE_PLATE_LENGTH*0.75,PRESSURE_PLATE_THICKNESS2],center=true);
            
        }
        union()
        {
            
            top_out_diff_corner();
            leg_prop();
            guard2();
            leg_stl_only();
            translate([3,0,0])                    leg_prop_front_piece();
            
            
    translate([46-DIFF_CUBE_X/2,-30-DIFF_CUBE_Y/2,0])cube([DIFF_CUBE_X,DIFF_CUBE_Y,10]);
    translate([-10-DIFF_CUBE_X/2,-30-DIFF_CUBE_Y/2,0]) rotate([0,0,-20])cube([DIFF_CUBE_X,DIFF_CUBE_Y,10]);
            
    translate([12-DIFF_CUBE_X2/2,-30-DIFF_CUBE_Y/2,-DIFF_CUBE_Z/2]) rotate([0,0,-20])cube([DIFF_CUBE_X2-2-5,DIFF_CUBE_Y,DIFF_CUBE_Z]);
    translate([18-DIFF_CUBE_X2/2,-30-DIFF_CUBE_Y/2,-DIFF_CUBE_Z/2]) rotate([0,0,-13])cube([DIFF_CUBE_X2-5,DIFF_CUBE_Y,DIFF_CUBE_Z]);
    translate([25-DIFF_CUBE_X2/2,-30-DIFF_CUBE_Y/2,-DIFF_CUBE_Z/2]) rotate([0,0,-0])cube([DIFF_CUBE_X2,DIFF_CUBE_Y,DIFF_CUBE_Z]);        
            
            guard3_hole();
        }
    }
    
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
    difference(){
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2-29,-52+STRENGHTEN_LEG_LENGTH_EXTRA/2,0]) rotate([0,0,-21]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH_EXTRA+12,LEG_WIDTH],center=true);
    color([1,0,0])translate([START_X_LEG-STRENGHTEN_LEG_THICK/2-16,-57.5,0]) cube([8,5,LEG_WIDTH+1],center=true);}
}
module leg_inner_bottom()
{
    translate([START_X_LEG-1+LEG_DIAMETER/2-1,-20+STRENGHTEN_LEG_LENGTH/2,0]) color([0,1,0])cube([STRENGHTEN_LEG_THICK+10.5,STRENGHTEN_LEG_LENGTH-10,LEG_WIDTH],center=true);
}
module leg_prop()
{
    
    guard3();
    leg_stl_only();
    //LEG EXTENSION
    translate([START_X_LEG-STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2,-16+STRENGHTEN_LEG_LENGTH/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH,LEG_WIDTH],center=true);
    
    difference(){
    translate([START_X_LEG+LEG_DIAMETER+STRENGHTEN_LEG_THICK/2,-55+STRENGHTEN_LEG_LENGTH_EXTRA/2,0]) cube([STRENGHTEN_LEG_THICK,STRENGHTEN_LEG_LENGTH_EXTRA+0,LEG_WIDTH],center=true);
        top_out_diff_corner();
    }
    //leg_inner_bottom();
    difference(){
        leg_prop_front_piece();
        union(){
            //translate([0,-51.3,0])#cube([10,10,11],center=true);
            
            leg_inner_bottom();
            }
        }
        
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
        guard2_cutout();    
        }
    }
    //guardhole();
    //connectors(less=0);
    
}
module sub_guard()
{
    difference(){
    
    translate([12,0,-PROP_GUARD_Y_OFFSET])scale([SCALE_PROPELLER,SCALE_PROPELLER,1]) import("stls/Protection_hlices_v6.stl", convexity=3);
    translate([120,10,8.0-PROP_GUARD_Y_OFFSET])cube([400,400,10],center=true);
    }
}
module sub_guard_slice()
{

    intersection(){
    sub_guard();
    translate([120,10,0.1+SLICE_HEIGHT/2-PROP_GUARD_Y_OFFSET]) cube([400,400,SLICE_HEIGHT],center=true);}
   
    
}
module guard()
{
    sub_guard();

    translate([0,0,-SLICE_HEIGHT]) sub_guard_slice();

}
module guardhole()
{
    translate([-GUARD_LENGTH/2+9,GUARD_Y_POS-GUARD_HEIGHT1/2-8-0.1,0]) color([0,0,1])rotate([90,0,0]) hex_hole(h_trap=NUT_HEIGHT_M3+0.1,h_hole=GUARD_HEIGHT1-NUT_HEIGHT_M3+1.1,r_trap=SCREW_STANDARD_M3,rot=180);
}
module guard2_cutout()
{
    translate([9-GUARD_LENGTH,-5+GUARD_Y_POS+GUARD_HEIGHT1/2,0]) rotate([0,0,70]) cube([GUARD_LENGTH*1.23,GUARD_HEIGHT1,GUARD_WIDTH*3],center=true);
    translate([9-GUARD_LENGTH-14,-8+GUARD_Y_POS+GUARD_HEIGHT1/2,0]) rotate([0,0,90]) cube([GUARD_LENGTH*1.23,GUARD_HEIGHT1,GUARD_WIDTH*3],center=true);
}
module guard2_shape_out()
{
    translate([18,-30,0]) rotate([0,0,-20]) cube([16,90,90],center=true);
}
module guard2_round_interface(){
    translate([-10-GUARD_LENGTH/2,GUARD_Y_POS-GUARD_HEIGHT1/2+SLICE_HEIGHT+PROP_GUARD_Y_OFFSET,0]) rotate([90,0,0])cylinder(h=SLICE_HEIGHT*2,r=8.5,center=true);
}
module guard2()
{
    
    difference(){
        union(){
    translate([10-GUARD_LENGTH/2,GUARD_Y_POS-GUARD_HEIGHT1/2+SLICE_HEIGHT+PROP_GUARD_Y_OFFSET,0]) cube([GUARD_LENGTH-20,SLICE_HEIGHT*2,GUARD_WIDTH*2],center=true);
    guard2_round_interface();
    translate([12-GUARD_LENGTH/2,GUARD_Y_POS+PROP_GUARD_Y_OFFSET,0]) cube([GUARD_LENGTH,GUARD_HEIGHT1,GUARD_WIDTH],center=true);
        }
    union(){
        propeller_cut_operating_shape();
        guardhole();
        connectors(less=0);
        leg_prop_front_piece();
        translate([0,0,10])  leg_stl_only();
         leg_stl_only();
        translate([0,0,-10])  leg_stl_only();
        difference(){
        guard2_cutout();
        guard2_round_interface();
        }
        guard2_shape_out();
        }
    }
    //color([1,0,0])#guard2_shape_out();
    //guard2_cutout();
    //guardhole();
}
module guard3_hole()
{
    local_length=PRESSURE_PLATE_THICKNESS1+LEG_WIDTH;
    translate([24,-28,-local_length/2-0.1+1]) rotate([180,0,0]) color([1,1,1]) hex_hole(h_trap=NUT_HEIGHT_M3+0.1,h_hole=local_length-NUT_HEIGHT_M3+1.1,r_trap=SCREW_STANDARD_M3,rot=180);
    translate([HOLE1_X,HOLE1_Y,-local_length/2-0.1+1]) rotate([180,0,0]) color([1,1,1]) hex_hole(h_trap=NUT_HEIGHT_M3+0.1,h_hole=local_length-NUT_HEIGHT_M3+1.1,r_trap=SCREW_STANDARD_M3,rot=180);
}
module guard3()
{
    
    difference(){
        union(){
            translate([24,-28,NUT_HEIGHT_M3-LEG_WIDTH/2+0.0]) color([1,0,0]) cube([SCREW_STANDARD_M3*2+2.5,SCREW_STANDARD_M3*2+1.5,NUT_HEIGHT_M3*2],center=true);
            translate([HOLE1_X,HOLE1_Y,NUT_HEIGHT_M3-LEG_WIDTH/2+0.0]) color([1,0,0]) rotate([0,0,2])cube([SCREW_STANDARD_M3*2+3.5,SCREW_STANDARD_M3*2+1.5,NUT_HEIGHT_M3*2],center=true);
        }
    guard3_hole();
    }
    
}
module propeller_cut_operating_shape()
{
    local_width=LEG_WIDTH+9;
    for (i=[-1,1])
    {
    translate([-CONNECTOR1_LENGTH/2+3.6,-SLICE_HEIGHT-48.4,i*(local_width+15)/2]) cube([30,SLICE_HEIGHT*2+0.2,local_width],center=true);
    }
}
module propeller_thin_struts()
{
    local_width=5.5;
    for (i=[-1,1])
    {
    translate([-CONNECTOR1_LENGTH/2+1.3,-SLICE_HEIGHT-48.4,i*(local_width+17)/2]) rotate([0,61*i,0])cube([40,SLICE_HEIGHT*2+0.2,local_width],center=true);
    }
}
module propeller_guard()
{
    intersection(){
    propeller_thin_struts();
    propeller_cut_operating_shape();
    }
    difference(){
        translate([0,-43.5,-118.5]) rotate([0,-90,90]) guard();
        union(){
        connectors(less=0);
        propeller_cut_operating_shape();
        }
    }
    guard2();
    //connectors(less=0);
}

module main()
{

mirror([0,0,1]) leg_prop();    
propeller_guard();
mirror([0,0,1]) pressure_plate();

//guard3_hole();
}




//main();

//temporary artifacts
//leg_prop();//the output of this command should be reloaded in the meshmixer and used to regenerate "leg_combined.stl" 


//final artifacts
//rotate([0,180,0]) mirror([0,0,1]) import("stls/leg_combined.stl", convexity=3);
//propeller_guard();
//rotate([90,0,0]) propeller_guard();
//pressure_plate();
mirror([0,0,1]) pressure_plate();

//guard2();


//TEMPORARY
/*
difference()
    {
        connectors(less=CONNECTOR_LESS);
        guardhole();
    }
*/
/*
    intersection()
{
    leg_prop();
    translate([0,-35,0])#cube([60,60,60],center=true);
}
*/
//translate([0,20,GUARD_HEIGHT1+LEG_WIDTH]) rotate([90,0,0]) guard2();
//translate([0,-57,0])cube([5,5,5],center=true);