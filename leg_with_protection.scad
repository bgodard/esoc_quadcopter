module leg_prop()
{
    import("stls/F450_leg-mine_long.stl", convexity=3);
}
module guard()
{
    
    difference(){
    import("stls/Protection_hlices_v6.stl", convexity=3);
    translate([120,10,8.0])#cube([40,20,10],center=true);
    }
}
module main()
{
rotate([90,0,90]) leg_prop();
translate([130,0,-50]) rotate([0,0,180]) guard();
}
//guard();
//leg_prop();

main();
