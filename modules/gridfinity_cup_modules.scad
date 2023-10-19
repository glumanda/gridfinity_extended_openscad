include <gridfinity_modules.scad>
include <modules_item_holder.scad>

default_num_x=2;
default_num_y=1;
default_num_z=3;

// X dimension subdivisions
default_chambers = 1;
// Include overhang for labeling
default_withLabel = "disabled"; //[disabled: no label, left: left aligned label, right: right aligned label, center: center aligned label, leftchamber: left aligned chamber label, rightchamber: right aligned chamber label, centerchamber: center aligned chamber label]
// Width of the label in number of units, or zero for full width
default_labelWidth = 0; // 0.01
// Include larger corner fillet
default_fingerslide = "none"; //[none, rounded, champhered]
// radius of the corner fillet
default_fingerslide_radius = 8;
// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
default_magnet_diameter = 6.5;  // .1
// (Zack's design uses depth of 6)
default_screw_depth = 6;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
default_floor_thickness = 1.2;
// Thickness of outer walls (Zack's design is 0.95 mm)
default_wall_thickness = 0.95;
default_cavity_floor_radius = -1;
// Use rectangular inset for better bridging/printability
default_hole_overhang_remedy = false;
// Save material with thinner floor (only if no magnets, screws, or finger-slide used)
default_efficient_floor = false;
// Half-pitch base pads for offset stacking
default_half_pitch = false;
// Might want to remove inner lip of cup
default_lip_style = "normal"; //[normal, reduced, none]
// Limit attachments (magnets and scres) to box corners for faster printing.
default_box_corner_attachments_only = false;
// Removes the base grid from inside the shape
default_flat_base = false;
default_tapered_corner = "none"; //[none, rounded, champhered]
default_tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
default_tapered_setback = -1;//gridfinity_corner_radius/2;
default_wallcutout_enabled=false;
// wall to enable on, front, back, left, right.
default_wallcutout_walls=[1,0,0,0]; 
//default will be binwidth/2
default_wallcutout_width=0;
default_wallcutout_angle=70;
//default will be binHeight
default_wallcutout_height=0;
default_wallcutout_corner_radius=5;
default_wallpattern_enabled=true; 
default_wallpattern_hexgrid = false;
default_wallpattern_fill = "none"; //["none", "space", "crop"]
default_wallpattern_walls=[1,0,0,0]; 
default_wallpattern_hole_sides = 4;
default_wallpattern_hole_size = 5; //0.1
default_wallpattern_hole_spacing = 2; //0.1
 
basic_cup(
  num_x=default_num_x,
  num_y=default_num_y,
  num_z=default_num_z,
  chambers=default_chambers,
  withLabel=default_withLabel,
  labelWidth=default_labelWidth,
  magnet_diameter=default_magnet_diameter,
  screw_depth=default_screw_depth,
  floor_thickness=default_floor_thickness,
  cavity_floor_radius=default_cavity_floor_radius,
  wall_thickness=default_wall_thickness,
  hole_overhang_remedy=default_hole_overhang_remedy,
  efficient_floor=default_efficient_floor,
  half_pitch=default_half_pitch,
  lip_style=default_lip_style,
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base=default_flat_base,
  tapered_corner=default_tapered_corner,
  tapered_corner_size=default_tapered_corner_size,
  tapered_setback=default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  help = false
);

// calculate the position of separators from the size
function calcualteSeparators(num_separators, num_x) = num_separators < 1 
      ? [] 
      : [ for (i=[1:num_separators]) i*(num_x/(num_separators+1))];
        
// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
module basic_cup(
  num_x,
  num_y,
  num_z,
  chambers=default_chambers,
  withLabel=default_withLabel,
  labelWidth=default_labelWidth,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  magnet_diameter=default_magnet_diameter,
  screw_depth=default_screw_depth,
  floor_thickness=default_floor_thickness,
  cavity_floor_radius=default_cavity_floor_radius,
  wall_thickness=default_wall_thickness,
  hole_overhang_remedy=default_hole_overhang_remedy,
  efficient_floor=default_efficient_floor,
  half_pitch=default_half_pitch,
  lip_style=default_lip_style,
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base = default_flat_base,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  help) {
    
  irregular_cup(
    num_x = num_x,
    num_y = num_y,
    num_z = num_z,
    withLabel=withLabel,
    labelWidth=labelWidth,
    fingerslide=fingerslide,
    fingerslide_radius=fingerslide_radius,
    magnet_diameter=magnet_diameter,
    screw_depth=screw_depth,
    floor_thickness=floor_thickness,
    cavity_floor_radius=cavity_floor_radius,
    wall_thickness=wall_thickness,
    hole_overhang_remedy=hole_overhang_remedy,
    efficient_floor=efficient_floor,
    half_pitch=half_pitch,
    separator_positions=calcualteSeparators(chambers-1, num_x),
    lip_style=lip_style, 
    box_corner_attachments_only=default_box_corner_attachments_only,
    flat_base=flat_base,
    tapered_corner=tapered_corner,
    tapered_corner_size=tapered_corner_size,
    tapered_setback=tapered_setback,
    wallpattern_enabled=wallpattern_enabled,
    wallpattern_hexgrid=wallpattern_hexgrid,
    wallpattern_fill=wallpattern_fill,
    wallpattern_walls=wallpattern_walls, 
    wallpattern_hole_sides=wallpattern_hole_sides,
    wallpattern_hole_size=wallpattern_hole_size,
    wallpattern_hole_spacing=wallpattern_hole_spacing,
    wallcutout_enabled=wallcutout_enabled,
    wallcutout_walls=wallcutout_walls,
    wallcutout_width=wallcutout_width,
    wallcutout_angle=wallcutout_angle,
    wallcutout_height=wallcutout_height,
    wallcutout_corner_radius=wallcutout_corner_radius,
    help = help);
}

function LookupKnownShapes(name="round") = 
  name == "square" ? 4 :
  name == "hex" ? 6 : 64;
  
// separator positions are defined in units from the left side
module irregular_cup(
  num_x,
  num_y,
  num_z,
  withLabel=default_withLabel,
  labelWidth=default_labelWidth,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  magnet_diameter=default_magnet_diameter,
  screw_depth=default_screw_depth,
  floor_thickness=default_floor_thickness,
  cavity_floor_radius=default_cavity_floor_radius,
  wall_thickness=default_wall_thickness,
  hole_overhang_remedy=default_hole_overhang_remedy,
  efficient_floor=default_efficient_floor,
  half_pitch=default_half_pitch,
  separator_positions=[],
  lip_style=default_lip_style, 
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base=default_flat_base,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  help) {

  difference() {
    grid_block(
      num_x, num_y, num_z, 
      magnet_diameter, 
      screw_depth, 
      hole_overhang_remedy=hole_overhang_remedy, 
      half_pitch=half_pitch,
      box_corner_attachments_only=box_corner_attachments_only, 
      flat_base=flat_base);
    
      partitioned_cavity(
        num_x, num_y, num_z, 
        withLabel=withLabel,
        labelWidth=labelWidth, 
        fingerslide=fingerslide, 
        fingerslide_radius=fingerslide_radius, 
        magnet_diameter=magnet_diameter, 
        screw_depth=screw_depth, 
        floor_thickness=floor_thickness, 
        wall_thickness=wall_thickness,
        efficient_floor=efficient_floor, 
        separator_positions=separator_positions, 
        lip_style=lip_style, 
        flat_base=flat_base,
        cavity_floor_radius=cavity_floor_radius);
    
    color(color_wallcutout)
      union(){
        fh = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
        cfr = calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness);

        if(tapered_corner == "rounded" || tapered_corner == "champhered"){
          tapered_corner_size  = tapered_corner_size == 0 ? gridfinity_zpitch*num_z/2 : tapered_corner_size;
          tapered_setback = tapered_setback < 0 ? gridfinity_corner_radius/2 : tapered_setback;
          translate([
            -gridfinity_pitch/2,
            -gridfinity_pitch/2+tapered_setback+gridfinity_clearance,
            gridfinity_zpitch*num_z+gridfinity_lip_height-gridfinity_clearance])
          rotate([270,0,0])
          union(){
            if(tapered_corner == "rounded"){
              roundedCorner(
                radius = tapered_corner_size, 
                length=(num_x+1)*gridfinity_pitch, 
                height = tapered_corner_size);
            }
            else if(tapered_corner == "champhered"){
              champheredCorner(
                champherLength = tapered_corner_size, 
                length=(num_x+1)*gridfinity_pitch, 
                height = tapered_corner_size);
            }
          }
        }
        
        if(wallcutout_enabled){
          z = gridfinity_zpitch * num_z + gridfinity_lip_height - gridfinity_clearance;
          wallcutout_thickness = wall_thickness*2+max(wall_thickness*2,cfr);//wall_thickness*2 should be lip thickness
         
          wcheight = wallcutout_height < 0 
              ? z - fh 
              : wallcutout_height == 0 ? z - fh -cfr
              : wallcutout_height;
          //z = gridfinity_zpitch*num_z+gridfinity_lip_height-gridfinity_clearance;
          front = [
            [(num_x-1)*gridfinity_pitch/2, -gridfinity_pitch/2+wallcutout_thickness/2, z],
            num_x*gridfinity_pitch/3,
            [0,0,0]];
          back = [
            [(num_x-1)*gridfinity_pitch/2, (num_y-0.5)*gridfinity_pitch-wallcutout_thickness/2, z],
            num_x*gridfinity_pitch/3,
            [0,0,0]];
          left = [[-gridfinity_pitch/2+wallcutout_thickness/2, (num_y-1)*gridfinity_pitch/2, z],
            num_y*gridfinity_pitch/3,
            [0,0,90]];
          right = [
            [(num_x-0.5)*gridfinity_pitch-wallcutout_thickness/2, (num_y-1)*gridfinity_pitch/2, z],
            num_y*gridfinity_pitch/3,
            [0,0,90]];
          
          locations = [front, back, left, right];
          for(i = [0:1:len(locations)-1])
          {
            if(wallcutout_walls[i] > 0)
            {
             translate(locations[i][0])
              rotate(locations[i][2])
              WallCutout(
                lowerWidth=wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, locations[i][1]) : wallcutout_width,
                wallAngle=wallcutout_angle,
                //height=wallcutout_height <= 0 ? (num_z)*gridfinity_zpitch : wallcutout_height,
                height=wcheight,
                thickness=wallcutout_thickness,
                cornerRadius=wallcutout_corner_radius);
            }
          }
        }
        
        if(wallpattern_enabled){
          wallpattern_thickness = wall_thickness*2;
          border = gridfinity_zpitch * (0.1);
          heightz = gridfinity_zpitch * (num_z-1.2)-border*2 - floor_thickness - cfr + (
            lip_style == "reduced" ? 2.5 :
            lip_style == "none" ? 5 : 0);
          //z=floor_thickness+(gridfinity_zpitch+0.5)+heightz/2;
          z=fh+heightz/2+border+cfr;
          
          front = [
            //width,height
            [num_x*gridfinity_pitch-gridfinity_corner_radius*2-wallpattern_thickness,heightz],
            //Position
            [(num_x-1)*gridfinity_pitch/2, -gridfinity_pitch/2+wallpattern_thickness, z],
            //rotation
            [90,90,0]];
          back = [
            [num_x*gridfinity_pitch-gridfinity_corner_radius*2-wallpattern_thickness,heightz - (withLabel != "disabled" ? 10 : 0)],
            //[(num_x-1)*gridfinity_pitch/2, (num_y-0.5)*gridfinity_pitch, (gridfinity_zpitch+0.5)+(heightz - (withLabel != "disabled" ? 10 : 0))/2],
            [(num_x-1)*gridfinity_pitch/2, (num_y-0.5)*gridfinity_pitch, z - (withLabel != "disabled" ? 10 : 0)/2],
            [90,90,0]];
          left = [
            [num_y*gridfinity_pitch-gridfinity_corner_radius*2-wallpattern_thickness,heightz],
            [-gridfinity_pitch/2, (num_y-1)*gridfinity_pitch/2, z],
            [90,90,90]];
          right = [
            [num_y*gridfinity_pitch-gridfinity_corner_radius*2-wallpattern_thickness,heightz],
            [(num_x-0.5)*gridfinity_pitch-wallpattern_thickness, (num_y-1)*gridfinity_pitch/2, z],
            [90,90,90]];
          
          locations = [front, back, left, right];
          for(i = [0:1:len(locations)-1])
          {
            if(wallpattern_walls[i] > 0)
            {
              translate(locations[i][1])
              rotate(locations[i][2])
              render(){
              GridItemHolder(
                canvisSize = [locations[i][0][1],locations[i][0][0]], //Swap x and y and rotate so hex is easier to print
                hexGrid = wallpattern_hexgrid,
                customShape = false,
                circleFn = wallpattern_hole_sides,
                holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                holeHeight = wallpattern_thickness,
                center=true,
                fill=wallpattern_fill, //"none", "space", "crop"
                help=help);
                }
            }
          }
      }
    }
  }
  
  HelpTxt("irregular_cup",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"withLabel",withLabel
    ,"labelWidth",labelWidth
    ,"fingerslide",fingerslide
    ,"fingerslide_radius",fingerslide_radius
    ,"magnet_diameter",magnet_diameter
    ,"screw_depth",screw_depth
    ,"floor_thickness",floor_thickness
    ,"cavity_floor_radius",cavity_floor_radius
    ,"wall_thickness",wall_thickness
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"efficient_floor",efficient_floor
    ,"half_pitch",half_pitch
    ,"separator_positions",separator_positions
    ,"lip_style",lip_style
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_enabled",wallpattern_enabled
    ,"wallpattern_hexgrid",wallpattern_hexgrid
    ,"wallpattern_walls",wallpattern_walls
    ,"wallpattern_hole_sides",wallpattern_hole_sides
    ,"wallpattern_hole_size",wallpattern_hole_size
    ,"wallpattern_hole_spacing",wallpattern_hole_spacing
    ,"wallcutout_enabled",wallcutout_enabled
    ,"wallpattern_fill",wallpattern_fill
    ,"wallcutout_walls",wallcutout_walls
    ,"wallcutout_width",wallcutout_width
    ,"wallcutout_angle",wallcutout_angle
    ,"wallcutout_height",wallcutout_height
    ,"wallcutout_corner_radius",wallcutout_corner_radius]
    ,help);  
}

module partitioned_cavity(num_x, num_y, num_z, withLabel=default_withLabel, 
    labelWidth=default_labelWidth, fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, separator_positions=[], lip_style=default_lip_style, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius) {
    
// height of partition between cells
  // cavity with removed segments so that we leave dividing walls behind
  gp = gridfinity_pitch;
  outer_wall_th = 1.8;  // cavity is this far away from the 42mm 'ideal' block
  inner_wall_th =1.2;
    
  bar_d = 1.2;
  zpoint = gridfinity_zpitch*num_z;
  
  yz = [[ (num_y-0.5)*gridfinity_pitch-14, zpoint-bar_d/2 ],
    [ (num_y-0.5)*gridfinity_pitch, zpoint-bar_d/2 ],
    [ (num_y-0.5)*gridfinity_pitch, zpoint-bar_d/2-10.18 ]
  ];
  
  cavity_xsize = gp*num_x-2*outer_wall_th;

  difference() {
    color(color_cupcavity)
    render()
    basic_cavity(num_x, num_y, num_z, fingerslide=fingerslide, fingerslide_radius=fingerslide_radius, magnet_diameter=magnet_diameter,
    screw_depth=screw_depth, floor_thickness=floor_thickness, wall_thickness=wall_thickness,
    efficient_floor=efficient_floor, lip_style=lip_style, flat_base=flat_base, cavity_floor_radius=cavity_floor_radius);
    
    color(color_divider)
    if (len(separator_positions) > 0) {
      for (i=[0:len(separator_positions)-1]) {
        translate([gp*(-0.5+separator_positions[i])-inner_wall_th/2, -gp/2, fudgeFactor]) cube([inner_wall_th, gp*num_y, gridfinity_zpitch*(num_z+1)]);
      }
    }
    
    // this is the label
    if (withLabel != "disabled") {
      // calcualte list of chambers. 
      color(color_label){
        chamberWidths = len(separator_positions) < 1 || 
        labelWidth == 0 ||
        withLabel == "left" ||
        withLabel == "center" ||
        withLabel == "right" ?
        [ num_x ] // single chamber equal to the bin length
        : [ for (i=[0:len(separator_positions)]) (i==len(separator_positions) ? num_x : separator_positions[i]) - (i==0 ? 0 : separator_positions[i-1]) ];
        
      for (i=[0:len(chamberWidths)-1]) {
        chamberStart = i == 0 ? 0 : separator_positions[i-1];
        chamberWidth = chamberWidths[i];
        label_num_x = (labelWidth == 0 || labelWidth > chamberWidth) ? chamberWidth : labelWidth;
        label_pos_x = (withLabel == "center" || withLabel == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                        : (withLabel == "right" || withLabel == "rightchamber" )? chamberWidth - label_num_x 
                        : 0 ;

        hull() for (i=[0,1, 2])
        translate([(-gridfinity_pitch/2) + ((chamberStart + label_pos_x) * gridfinity_pitch), yz[i][0], yz[i][1]])
        rotate([0, 90, 0])
        union(){
            tz(abs(label_num_x)*gridfinity_pitch)
            sphere(d=bar_d, $fn=24);
            sphere(d=bar_d, $fn=24);
        }}
      }
    }
  }
}
const_base_part_ht = 5;  
const_magnet_height = 2.4;

function calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
) cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;
  
 function calculateFloorHeight(magnet_diameter,screw_depth, floor_thickness) = let (
    mag_ht = magnet_diameter > 0 ? const_magnet_height: 0)
    max(mag_ht, screw_depth, const_base_part_ht) + floor_thickness;

module basic_cavity(num_x, num_y, num_z, fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, 
    lip_style=default_lip_style, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius) {
  eps = 0.1;
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  cavity_floor_radius = calcualteCavityFloorRadius(cavity_floor_radius,wall_thickness);
  q2 = 0.1;
  inner_lip_ht = 1.2;
  part_ht = 5;  // height of partition between cells
  // the Z height of the bottom of the inside edge of the standard lip
  zpoint = max(part_ht+floor_thickness, gridfinity_zpitch*num_z-inner_lip_ht);
  facets = 13;
  mag_ht = magnet_diameter > 0 ? 2.4: 0;
  m3_ht = screw_depth;
  efloor = efficient_floor && magnet_diameter == 0 && screw_depth == 0 && !fingerslide;
  seventeen = gridfinity_pitch/2-4;
  
  floorht = max(mag_ht, m3_ht, part_ht) + floor_thickness;
  
  // replace "normal" with "reduced" if z-height is less than 1.8
  lip_style2 = (num_z < 1.8 && lip_style == "normal") ? "reduced" : lip_style;
  // replace "reduced" with "none" if z-height is less than 1.1
  lip_style3 = (num_z < 1.2 && lip_style2 == "reduced") ? "none" : lip_style2;
  
  difference() {
    union() {
      // cut out inside edge of standard lip
      hull() cornercopy(seventeen, num_x, num_y) {
        tz(zpoint-eps) cylinder(d=2.3, h=inner_lip_ht+2*eps, $fn=24); // lip
      }
      
      hull() cornercopy(seventeen, num_x, num_y) {
        // create bevels below the lip
        if (lip_style3 == "reduced") {
          tz(zpoint+1.8) cylinder(d=3.7, h=0.1, $fn=32); // transition from lip (where top of lip would be) ...
          // radius increases by (2.3+2*q-3.7)/2 = q-1.4/2 = q-0.7
          tz(zpoint-(q-0.7)+1.9-q2) cylinder(d=2.3+2*q, h=q2, $fn=32);   // ... to top of thin wall ...
        }
        else if (lip_style3 == "none") {
          tz(zpoint) cylinder(d=2.3+2*q, h=6, $fn=32);   // remove entire lip
        }
        else {  // normal
          tz(zpoint-0.1) cylinder(d=2.3, h=0.1, $fn=24);       // transition from lip ...
          tz(zpoint-q-q2) cylinder(d=2.3+2*q, h=q2, $fn=32);   // ... to top of thin wall ...
        }
        // create rounded bottom of bowl (8.5 is high enough to not expose gaps)
        //tz(2.3/2+q+floorht) sphere(d=2.3+2*q, $fn=32);       // .. to bottom of thin wall and floor
        tz(floorht)
          roundedCylinder(h=max(fudgeFactor,cavity_floor_radius*2),r=(2.3+2*q)/2,roundedr1=cavity_floor_radius,roundedr2=0, $fn=32)
        
        tz(2.3/2+q+floorht) mirror([0, 0, 1]) cylinder(d1=2.3+2*q, d2=0, h=1.15+q, $fn=32);
      }
    }
    
    // cut away from the negative to leave behind wall to make it easier to remove piece
    pivot_z = 13.6-0.45+floorht-5+seventeen-17;
    pivot_y = -10;
    
    // rounded inside bottom
    if(fingerslide != "none"){
      translate([0, (
            lip_style3 == "reduced" ? -0.7 
            : (lip_style3=="none" ? seventeen+1.15-gridfinity_pitch/2+0.25+wall_thickness
            : 0
            ) ), 0])
        translate([-(gridfinity_pitch/2),-seventeen-1.15, floorht])
          union(){
            if(fingerslide == "rounded"){
              roundedCorner(
                radius = fingerslide_radius, 
                length=gridfinity_pitch*(num_x), 
                height = gridfinity_zpitch*num_z);
            }
            else if(fingerslide == "champhered"){
              champheredCorner(
                champherLength = fingerslide_radius, 
                length=gridfinity_pitch*(num_x),
                height = gridfinity_zpitch*num_z);
        }
      }
    }
  }
  
  // cut away side lips if num_x is less than 1
  if (num_x < 1) {
    hull() for (x=[-gridfinity_pitch/2+1.5+0.25+wall_thickness, -gridfinity_pitch/2+num_x*gridfinity_pitch-1.5-0.25-wall_thickness])
    for (y=[-10, (num_y-0.5)*gridfinity_pitch-seventeen])
    translate([x, y, (floorht+7*num_z)/2])
    cylinder(d=3, h=7*num_z, $fn=24);
  }
  
  if (efloor) {
    if (num_x < 1) {
      gridcopy(1, num_y) {
        tz(floor_thickness) intersection() {
          hull() cornercopy(seventeen-0.5) cylinder(r=1, h=5, $fn=32);
          translate([gridfinity_pitch*(-1+num_x), 0, 0]) hull() cornercopy(seventeen-0.5) cylinder(r=1, h=5, $fn=32);
        }
      
        // tapered top portion
        intersection() {
          hull() {
            tz(3) cornercopy(seventeen-0.5) cylinder(r=1, h=1, $fn=32);
            tz(5) cornercopy(seventeen+2.5-1.15-q) cylinder(r=1.15+q, h=4, $fn=32);
          }
          translate([gridfinity_pitch*(-1+num_x), 0, 0]) hull() {
            tz(3) cornercopy(seventeen-0.5) cylinder(r=1, h=1, $fn=32);
            tz(5) cornercopy(seventeen+2.5-1.15-q) cylinder(r=1.15+q, h=4, $fn=32);
          }
        }
      }
    } else {
      _gridx = flat_base ? 1 : num_x;
      _gridCornerx = flat_base ? num_x : 1;
      _gridy = flat_base ? 1 : num_y;
      _gridCornery = flat_base ? num_y : 1;
      
      // establishes floor
      gridcopy(_gridx, _gridy) hull() tz(floor_thickness) gridcopycorners(_gridCornerx, _gridCornery, seventeen-0.5, flat_base) cylinder(r=1, h=5, $fn=32);
   
      // tapered top portion
      gridcopy(_gridx, _gridy) hull() {
        tz(3) gridcopycorners(_gridCornerx, _gridCornery, seventeen-0.5, flat_base) cylinder(r=1, h=1, $fn=32);
        tz(5-(+2.5-1.15-q)) gridcopycorners(_gridCornerx, _gridCornery, seventeen, flat_base) cylinder(r=1.15+q, h=4, $fn=32);
      }
    }
  }
}

module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  echo(h=h,r=r,roundedr=roundedr,roundedr1,roundedr2)
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1);
      else
        cylinder(r=r,h=h-roundedr2);
        
      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2]) 
          roundedDisk(r,roundedr2);
      else
        translate([0,0,roundedr1]) 
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}

module roundedDisk(r,roundedr){
  translate([0,0,roundedr]) 
  rotate_extrude() 
  translate([r-roundedr,0,0])
  difference(){
    circle(roundedr);
    translate([-roundedr*2,-roundedr,0])
    square(roundedr*2);
  }
}

module tz(z) {
  translate([0, 0, z]) children();
}