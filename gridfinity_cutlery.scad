// junand 07.07.2024

// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup.html

//----------------- imports---------------------------------------------------------------

include <modules/gridfinity_constants.scad>
use <modules/gridfinity_modules.scad>
use <modules/gridfinity_cup_modules.scad>
use <modules/module_baseplate.scad>

//----------------- defs -----------------------------------------------------------------

fudge = 0.1;

baseplate_z_move = -5;
basiccup_wallthickness = 2.5;
basiccup_height = 10;

// tool drawer
nose_wdith = 25;
nose_dist = 111;

baseplate_11_5x11_3 = [
    [[0, 0], [4, 4]],
    [[4, 0], [4, 4]],
    [[8, 0], [3.5, 4]],

    [[0, 4], [4, 4]],
    [[4, 4], [4, 4]],
    [[8, 4], [3.5, 4]],

    [[0, 8], [4, 3.3]],
    [[4, 8], [4, 3.3]],
    [[8, 8], [3.5, 3.3]],
];

baseplate_18_66x11_3 = [
    [[ 0, 0], [5, 4]],
    [[ 5, 0], [5, 4]],
    [[10, 0], [5, 4]],
    [[15, 0], [3.66, 4]],

    [[ 0, 4], [5, 4]],
    [[ 5, 4], [5, 4]],
    [[10, 4], [5, 4]],
    [[15, 4], [3.66, 4]],

    [[ 0, 8], [5, 3.3]],
    [[ 5, 8], [5, 3.3]],
    [[10, 8], [5, 3.3]],
    [[15, 8], [3.66, 3.3]],
];


//----------------- main -----------------------------------------------------------------

*cutlery_drawer ();
*cutlery_basic_cup ( 2, 5.5 );
*cutlery_basic_cup ( 3, 4.5 );
*cutlery_basic_cup ( 1, 2.5 );

*halfcup ( "upper" ) cutlery_basic_cup ( 2.5, 8 );
*halfcup ( "lower" ) cutlery_basic_cup ( 2.5, 8 );

*drawer2 ();
*halfcup () cutlery_basic_cup ( 4, 9 );
*halfcup () cutlery_basic_cup ( 3, 7 );
*cutlery_basic_cup ( 2, 5 );
*halfcup ( "upper" ) cutlery_basic_cup ( 2.5, 11 );
*halfcup ( "lower" ) cutlery_basic_cup ( 2.5, 11 );
*halfcup () cutlery_basic_cup ( 2, 7 );
*cutlery_basic_cup ( 2, 6 );
*cutlery_basic_cup ( 3, 2 );

*drawer3 ();
*cutlery_basic_cup ( 2, 2 );
*cutlery_basic_cup ( 1, 2 );
*halfcup ( "upper" ) cutlery_basic_cup ( 1.5, 11 );
*halfcup ( "lower" ) cutlery_basic_cup ( 1.5, 11 );
*halfcup ( "upper" ) cutlery_basic_cup ( 2, 8 );
*cutlery_basic_cup ( 3, 6 );
*cutlery_basic_cup ( 4, 5 );

*large_drawer ();
*cutlery_baseplate ( 5, 4 );
*cutlery_baseplate ( 3.66, 4 );
*cutlery_baseplate ( 5, 3.3 );
*cutlery_baseplate ( 3.66, 3.3 );
*cutlery_basic_cup ( 3, 5 );
*cutlery_basic_cup ( 2, 3 );
*halfcup ( "upper" ) cutlery_basic_cup ( 1.5, 9 );
*halfcup ( "lower" ) cutlery_basic_cup ( 1.5, 9 );
*halfcup ( "upper" ) cutlery_basic_cup ( 2.66, 11 );
*halfcup ( "lower" ) cutlery_basic_cup ( 2.66, 11 );

tool_drawer ();
*_baseplate ( [5, 4], "zickzack_left" );
*_baseplate ( [5, 4], "zickzack_right" );
*form_plate_top () translate ( [4.5 * gf_pitch, 0.5 * gf_pitch, 0] ) _baseplate ( [5, 4], "zickzack_left" );
*form_plate_top () translate ( [0.5 * gf_pitch, 0.5 * gf_pitch, 0] ) _baseplate ( [5, 4], "zickzack_right" );
*form_plate_bottom () translate ( [0.5, 0.5, 0] * gf_pitch ) _baseplate ( [5, 6], "zickzack_right" );
*form_plate_bottom () translate ( [4.5, 0.5, 0] * gf_pitch ) _baseplate ( [5, 6], "zickzack_left" );
*cutlery_basic_cup ( 3, 4 );
*cutlery_basic_cup ( 2, 3 );
*mirror ( [1, 0, 0] )
form_plate_bottom ( [0, 0, baseplate_z_move], 100 ) {
    translate ( [4.5/2 * gf_pitch, 4/2 * gf_pitch, 0] ) cutlery_basic_cup ( 4.5, 4 );
    dd = basiccup_wallthickness * tan ( 45/2 );
    translate ( [-1.5 * gf_pitch + nose_dist - nose_wdith/2 + 0.25, 0.25, 5] ) {
        rotate ( [0, 0, 45] ) {
            cube ( [sqrt ( 2 ) * ( 6 * gf_pitch - nose_dist -0.25 + dd ) - 0.43, basiccup_wallthickness, basiccup_height * gf_zpitch - 5] );
        }
    }
    translate ( [4.5 * gf_pitch - nose_wdith/2 - dd, 6 * gf_pitch - nose_dist, 5] ) {
        cube ( [nose_wdith/2 + dd - 0.25, basiccup_wallthickness, basiccup_height * gf_zpitch - 5] );
    }
}
*form_plate_bottom ( [0, 0, baseplate_z_move], 100 ) translate ( [1.5 * 4.5 * gf_pitch, 4/2 * gf_pitch, 0] ) cutlery_basic_cup ( 4.5, 4 );

//----------------- util -----------------------------------------------------------------

module halfcup ( part = "upper" ) {

    a = 400;

    intersection () {
        children ();
        if ( part == "upper" ) {
            translate ( [-a/2, 0, 0] ) cube ( a ) ;
        }
        else if ( part == "lower" ) {
            translate ( [-a/2, -a, 0] ) cube ( a ) ;
        }
    }

}

//----------------- drawer ---------------------------------------------------------------

module _baseplate ( plate, zickzack ) {

    difference () {
        cutlery_baseplate ( plate.x, plate.y );
        translate ( [-gf_pitch/2, -gf_pitch/2, 0] ) {
            if ( zickzack == "zickzack_left" ) {
                for ( i = [0: 2 : plate.y] ) {
                    translate ( [0, i * gf_pitch, -fudge] ) {
                        cube ( [gf_pitch, gf_pitch, gf_zpitch] );
                    }
                }
            }
            else if ( zickzack == "zickzack_right" ) {
                for ( i = [1: 2 : plate.y] ) {
                    translate ( [( plate.x - 1 ) * gf_pitch, i * gf_pitch, -fudge] ) {
                        cube ( [gf_pitch, gf_pitch, gf_zpitch] );
                    }
                }
            }
        }
    }

}

module _drawer ( cups = [], plates = [] ) {

    module place_cup ( pos = [0, 0], cup = [1, 2], orientation = "up", wallcut ) {

        function _a ( orientation ) = orientation == "up" ? 0 : ( orientation == "right" ? -90 : ( orientation == "left" ? +90 : ( orientation == "down" ? 180 : 0 ) ) );;

        module _place ( x, y, a, c, w ) {
            translate ( [x, y, 0] ) {
                rotate ( [0, 0, a] ) {
                    cutlery_basic_cup ( c.x, c.y, wallcutout_enabled = w );
                }
            }
        }

        if ( orientation == "up" || orientation == "down" ) {
            x = ( cup.x/2 + pos.x ) * gf_pitch;
            y = ( cup.y/2 + pos.y ) * gf_pitch;
            _place ( x, y, _a ( orientation ), cup, wallcut );
        }
        else if ( orientation == "right" || orientation == "left") {
            x = ( cup.y/2 + pos.x ) * gf_pitch;
            y = ( cup.x/2 + pos.y ) * gf_pitch;
            _place ( x, y, _a ( orientation ), cup, wallcut );
        }

    }

    module place_baseplate ( pos = [0, 0], plate = [4, 4], zickzack = "none" ) {

        x = ( 0.5 + pos.x ) * gf_pitch;
        y = ( 0.5 + pos.y ) * gf_pitch;

        translate ( [x, y, baseplate_z_move] ) {
            _baseplate ( plate, zickzack );
        }

    }

    for ( c = cups ) {
            place_cup ( c [0], c [1], c [2], c [3] !=  undef ? c [3] : true );
    }

    for ( p = plates ) {
        place_baseplate ( p [0], p [1], p [2] );
    }

}

module cutlery_drawer () {

    cups = [
        [[0.0, 0], [1.5, 5], "up"],
        [[1.5, 0], [1.5, 5], "down"],
        [[3.0, 0], [1.5, 5], "up"],
        [[4.5, 0], [1.5, 6], "down"],
        [[6.0, 0], [1.5, 6], "up"],
        [[7.5, 0], [1.5, 6], "down"],
        [[9.0, 0], [2.5, 8], "up"],

        [[0.0, 5], [1.5, 4], "up"],
        [[1.5, 5], [1.5, 4], "down"],
        [[3.0, 5], [1.5, 4], "up"],

        [[0.0, 9.0], [2, 6], "right"],
        [[6.0, 9.0], [2, 5.5], "right"],
        [[4.5, 6.0], [3, 4.5], "left"],
        [[9.0, 8.0], [1, 2.5], "right"],
    ];

    _drawer ( cups, baseplate_11_5x11_3 );

}

module drawer2 () {

cup_4x9 = [4, 9];

    cups = [
        [[0, 0], [4, 9], "up"],         // green
        [[4, 0], [3, 7], "up"],         // blue
        [[7, 0], [2, 5], "up"],         // yellow
        [[9, 0], [2.5, 11], "up"],      // green
        [[0, 9], [2, 7], "right"],      // red
        [[7, 5], [2, 6], "up"],         // yellow
        [[4, 7], [3, 2], "up"],         // orange
    ];

    _drawer ( cups, baseplate_11_5x11_3 );

}

module drawer3 () {

cup_4x9 = [4, 9];

    cups = [
        [[0, 0], [2, 6], "up"],         // ...
        [[2, 0], [2, 6], "up"],         // ...
        [[4, 0], [2, 7], "up"],         // ...
        [[6, 0], [2, 8], "up"],         // ...
        [[8, 0], [2, 8], "up"],         // ...
        [[10, 0], [1.5, 11.3], "up"],   // ...
        [[4, 8], [3.3, 6], "left"],     // ...
        [[0, 6], [4, 5.3], "up"],       // ...
        [[4, 7], [1, 2], "right"],         // ...
    ];

    _drawer ( cups, baseplate_11_5x11_3 );

}

module large_drawer () {

cup_4x9 = [4, 9];

    cups = [
        [[0, 0],    [3, 5],     "right"],   // blue
        [[5, 0],    [2, 3],     "up"],      // green
        [[7, 0],    [1.5, 9],   "right"],   // orange
        [[7, 1.5],  [1.5, 9],   "right"],   // orange
        [[6, 3],    [2.5, 8],   "up"],      // red
        [[8.5, 3],  [2.5, 8],   "down"],    // red
        [[11, 3],   [2.5, 8],   "up"],      // red
        [[13.5, 3], [2.5, 8],   "down"],    // red
        [[16, 0],   [2.66, 11], "up"],      // yellow
    ];

    _drawer ( cups, baseplate_18_66x11_3 );

}

module rotate_at ( pos, a ) {

    translate ( +pos ) {
        rotate ( [0, 0, a] ) {
            translate ( -pos ) {
                children ();
            }
        }
    }

}

module form_plate_top ( pos = [0, 0, 0], z_dim = gf_zpitch ) {

    difference () {
        children ();
        translate ( [pos.x * gf_pitch, pos.y * gf_pitch, pos.z] ) {
            rotate_at ( [0, 0, 0], 45 ) {
                cube ( [9 * gf_pitch, 4 * gf_pitch, z_dim] );
            }
            rotate_at ( [( pos.x + 9 ) * gf_pitch, 0, 0], -45 ) {
                cube ( [9 * gf_pitch, 4 * gf_pitch, z_dim] );
            }
        }
    }

}

module form_plate_bottom ( pos = [0, 0, 0], z_dim = gf_zpitch ) {

    plate_dim = [9, 6];

    difference () {
        children ();
        translate ( [plate_dim.x/2 * gf_pitch, 0, pos.z] ) {
            translate ( [-nose_wdith/2, -nose_dist, 0] ) cube ( [nose_wdith, plate_dim.y * gf_pitch, z_dim] );
            for ( d = [+1, -1] ) {
                x = -d * ( plate_dim.x * gf_pitch + nose_wdith )/2;
                y = -nose_dist;
                translate ( [x, y, 0] )
                    rotate_at ( [d * plate_dim.x * gf_pitch /2, plate_dim.y * gf_pitch, 0], d * 45 )
                        translate ( [-plate_dim.x * gf_pitch /2, 0, 0] )
                            cube ( [plate_dim.x * gf_pitch, plate_dim.y * gf_pitch, z_dim] );
            }
        }
    }

}

module tool_drawer () {

    cups = [
        [[0,0], [4.5, 4], "up"],
        [[4.5,0], [4.5, 4], "down"],
        [[0,4], [3, 4], "up"],
        [[3,4], [2, 3], "right"],
        [[3,6], [2, 3], "right"],
        [[6,4], [3, 4], "up"],
        [[0,8], [3, 4], "up"],
        [[3,8], [2, 3], "right"],
        [[3,10], [2, 3], "right"],
        [[6,8], [3, 4], "up"],
    ];

    plates = [
        [[0, 0], [5, 6], "zickzack_right"],
        [[4, 0], [5, 6], "zickzack_left"],
        [[0, 6], [5, 4], "zickzack_right"],
        [[4, 6], [5, 4], "zickzack_left"],
        [[0, 10], [5, 4], "zickzack_right"],
        [[4, 10], [5, 4], "zickzack_left"],
        [[0, 14], [5, 4], "zickzack_right"],
        [[4, 14], [5, 4], "zickzack_left"],
    ];

    form_plate_bottom ( [0, 0, baseplate_z_move], 100 ) form_plate_top ( [0, 14, baseplate_z_move] ) _drawer ( cups, plates );

}

//----------------- basic cup ------------------------------------------------------------

module cutlery_basic_cup ( cup_width = 1, cup_depth = 3, cup_height = basiccup_height, wall_thickness = basiccup_wallthickness, lip_style = "none", label_style = "disabled", wallcutout_enabled = true ) {

    /*<!!start gridfinity_basic_cup!!>*/
    /* [General Cup] */
    // X dimension. grid units (multiples of 42mm) or mm.
    width = [cup_width, 0]; //0.5
    // Y dimension. grid units (multiples of 42mm) or mm.
    depth = [cup_depth, 0]; //0.5
    // Z dimension excluding. grid units (multiples of 7mm) or mm.
    height = [cup_height, 0]; //0.1
    // Fill in solid block (overrides all following options)
    filled_in = false;
    // Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
    //wall_thickness = 0;  // .01
    // Remove some or all of lip
    //lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
    position = "center"; //[default",center,zero]
    //under size the bin top by this amount to allow for better stacking
    zClearance = 0; // 0.1

    /* [Subdivisions] */
    chamber_wall_thickness = 1.2;
    // X dimension subdivisions
    vertical_chambers = 1;
    vertical_separator_bend_position = 0;
    vertical_separator_bend_angle = 0;
    vertical_separator_bend_separation = 0;
    vertical_separator_cut_depth=0;
    horizontal_chambers = 1;
    horizontal_separator_bend_position = 0;
    horizontal_separator_bend_angle = 0;
    horizontal_separator_bend_separation = 0;
    horizontal_separator_cut_depth=0;
    // Enable irregular subdivisions
    vertical_irregular_subdivisions = false;
    // Separator positions are defined in terms of grid units from the left end
    vertical_separator_config = "10.5|21|42|50|60";
    // Enable irregular subdivisions
    horizontal_irregular_subdivisions = false;
    // Separator positions are defined in terms of grid units from the left end
    horizontal_separator_config = "10.5|21|42|50|60";

    /* [Base] */
    // (Zack's design uses magnet diameter of 6.5)
    magnet_diameter = 0;  // .1
    //create relief for manget removal
    magent_easy_release = true;
    // (Zack's design uses depth of 6)
    screw_depth = 0;
    center_magnet_diameter =0;
    center_magnet_thickness = 0;
    // Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
    hole_overhang_remedy = 2;
    //Only add attachments (magnets and screw) to box corners (prints faster).
    box_corner_attachments_only = true;
    // Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
    floor_thickness = 0.7;
    cavity_floor_radius = -1;// .1
    // Efficient floor option saves material and time, but the internal floor is not flat
    efficient_floor = "off";//[off,on,rounded,smooth]
    // Enable to subdivide bottom pads to allow half-cell offsets
    half_pitch = false;
    // Removes the internal grid from base the shape
    flat_base = false;
    // Remove floor to create a veritcal spacer
    spacer = false;

    /* [Label] */
    //label_style = "normal"; //[disabled: no label, normal:normal, click]
    // Include overhang for labeling (and specify left/right/center justification)
    label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
    // Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
    label_size = [0,14,0,0.6]; // 0.01
    // Creates space so the attached label wont interferr with stacking
    label_relief = 0; // 0.1

    /* [Sliding Lid] */
    sliding_lid_enabled = false;
    // 0 = wall thickness *2
    sliding_lid_thickness = 0; //0.1
    // 0 = wall_thickness/2
    sliding_min_wallThickness = 0;//0.1
    // 0 = default_sliding_lid_thickness/2
    sliding_min_support = 0;//0.1
    sliding_clearance = 0.1;//0.1

    /* [Finger Slide] */
    // Include larger corner fillet
    fingerslide = "none"; //[none, rounded, chamfered]
    // Radius of the corner fillet
    fingerslide_radius = 8;

    /* [Tapered Corner] */
    tapered_corner = "none"; //[none, rounded, chamfered]
    tapered_corner_size = 10;
    // Set back of the tapered corner, default is the gridfinity corner radius
    tapered_setback = -1;//gridfinity_corner_radius/2;

    /* [Wall Pattern] */
    // Grid wall patter
    wallpattern_enabled=false;
    // Style of the pattern
    wallpattern_style = "grid"; //[grid, hexgrid, voronoi,voronoigrid,voronoihexgrid]
    // Spacing between pattern
    wallpattern_hole_spacing = 2; //0.1
    // wall to enable on, front, back, left, right.
    wallpattern_walls=[1,1,1,1];
    // Add the pattern to the dividers
    wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
    //Number of sides of the hole op
    wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
    //Size of the hole
    wallpattern_hole_size = 5; //0.1
    // pattern fill mode
    wallpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
    wallpattern_voronoi_noise = 0.75;
    wallpattern_voronoi_radius = 0.5;

    /* [Wall Cutout] */
    //wallcutout_enabled=false;
    // wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
    //wallcutout_walls=[1,0,0,0];  //0.1
    wallcutout_walls_pos = depth [0]/2;
    wallcutout_walls=[0,0,wallcutout_walls_pos,wallcutout_walls_pos];  //0.1
    //default will be binwidth/2
    //wallcutout_width=0;
    wallcutout_width=depth [0]/4 * gf_pitch;
    wallcutout_angle=70;
    //default will be binHeight
    //wallcutout_height=0;
    wallcutout_height=height [0]/2 * gf_zpitch;
    wallcutout_corner_radius=5;

    /* [Extendable] */
    extention_x_enabled = false;
    extention_y_enabled = false;
    extention_tabs_enabled = true;

    /* [debug] */
    //Slice along the x axis
    cutx = 0; //0.1
    //Slice along the y axis
    cuty = 0; //0.1
    // enable loging of help messages during render.
    enable_help = false;

    /* [Hidden] */
    module end_of_customizer_opts() {}
    /*<!!end gridfinity_basic_cup!!>*/

    gridfinity_cup(

        width=width, depth=depth, height=height,
        position=position,
        filled_in=filled_in,
        label_style=label_style,
        label_position=label_position,
        label_size=label_size,
        label_relief=label_relief,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        magnet_diameter=magnet_diameter,
        magent_easy_release=magent_easy_release,
        screw_depth=screw_depth,
        center_magnet_diameter=center_magnet_diameter,
        center_magnet_thickness=center_magnet_thickness,
        floor_thickness=floor_thickness,
        cavity_floor_radius=cavity_floor_radius,
        wall_thickness=wall_thickness,
        hole_overhang_remedy=hole_overhang_remedy,
        efficient_floor=efficient_floor,
        chamber_wall_thickness=chamber_wall_thickness,
        vertical_chambers = vertical_chambers,
        vertical_separator_bend_position=vertical_separator_bend_position,
        vertical_separator_bend_angle=vertical_separator_bend_angle,
        vertical_separator_bend_separation=vertical_separator_bend_separation,
        vertical_separator_cut_depth=vertical_separator_cut_depth,
        vertical_irregular_subdivisions=vertical_irregular_subdivisions,
        vertical_separator_config=vertical_separator_config,
        horizontal_chambers=horizontal_chambers,
        horizontal_separator_bend_position=horizontal_separator_bend_position,
        horizontal_separator_bend_angle=horizontal_separator_bend_angle,
        horizontal_separator_bend_separation=horizontal_separator_bend_separation,
        horizontal_separator_cut_depth=horizontal_separator_cut_depth,
        horizontal_irregular_subdivisions=horizontal_irregular_subdivisions,
        horizontal_separator_config=horizontal_separator_config,
        half_pitch=half_pitch,
        lip_style=lip_style,
        zClearance=zClearance,
        box_corner_attachments_only=box_corner_attachments_only,
        flat_base = flat_base,
        spacer=spacer,
        tapered_corner=tapered_corner,
        tapered_corner_size = tapered_corner_size,
        tapered_setback = tapered_setback,
        wallpattern_enabled=wallpattern_enabled,
        wallpattern_style=wallpattern_style,
        wallpattern_walls=wallpattern_walls,
        wallpattern_dividers_enabled=wallpattern_dividers_enabled,
        wallpattern_hole_sides=wallpattern_hole_sides,
        wallpattern_hole_size=wallpattern_hole_size,
        wallpattern_hole_spacing=wallpattern_hole_spacing,
        wallpattern_fill=wallpattern_fill,
        wallpattern_voronoi_noise=wallpattern_voronoi_noise,
        wallpattern_voronoi_radius = wallpattern_voronoi_radius,
        wallcutout_enabled=wallcutout_enabled,
        wallcutout_walls=wallcutout_walls,
        wallcutout_width=wallcutout_width,
        wallcutout_angle=wallcutout_angle,
        wallcutout_height=wallcutout_height,
        wallcutout_corner_radius=wallcutout_corner_radius,
        extention_enabled=[extention_x_enabled,extention_y_enabled],
        extention_tabs_enabled = extention_tabs_enabled,
        sliding_lid_enabled = sliding_lid_enabled,
        sliding_lid_thickness = sliding_lid_thickness,
        sliding_min_wall_thickness = sliding_min_wallThickness,
        sliding_min_support = sliding_min_support,
        sliding_clearance = sliding_clearance,
        cutx=cutx,
        cuty=cuty,
        help = enable_help

    );

}

//----------------- baseplate ------------------------------------------------------------

module cutlery_baseplate ( plate_width = 4, plate_depth = 4, plate_oversize_method = "crop" ) {

    /* [Size] */
    // X dimension. grid units (multiples of 42mm) or mm.
    //width = [2, 0]; //0.1
    width = [plate_width, 0]; //0.1
    // Y dimension. grid units (multiples of 42mm) or mm.
    //depth = [1, 0]; //0.1
    depth = [plate_depth, 0]; //0.1
    //oversize_method = "fill"; //[crop, fill]
    oversize_method = plate_oversize_method; //[crop, fill]
    //Enable custom grid, you will configure this in the (Lid not supported)
    Custom_Grid_Enabled = false;

    /* [Plate] */
    // Plate Style
    Plate_Style = "base"; //[base:Base plate, lid:Lid that is also a gridfinity base]
    Base_Plate_Options = "default";//[default:Default, magnet:Efficient magnet base, weighted:Weighted base, woodscrew:Woodscrew, cnc:CNC or Laser cut, cncmagnet:CNC cut with Magnets]
    Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

    Lid_Include_Magnets = true;
    // Base height, when the bin on top will sit, in GF units
    Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
    // Thickness of the efficient floor
    Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

    /* [Base Plate Clips - POC dont use yet]*/
    //This feature is not yet finalised, or working properly.
    Butterfly_Clip_Enabled = false;
    Butterfly_Clip_Size = [6,6,1.5];
    Butterfly_Clip_Radius = 0.1;
    Butterfly_Clip_Tollerance = 0.1;
    Butterfly_Clip_Only = false;

    //This feature is not yet finalised, or working properly.
    Filament_Clip_Enabled = false;
    Filament_Clip_Diameter = 2;
    Filament_Clip_Length = 8;


    //Custom gid sizes
    //I am not sure it this is really usefull, but its possible, so here we are.
    //0:off the cell is off
    //1:on the cell is on and all corners are rounded
    //2-16, are bitwise values used to calculate what corners should be rounded, you need to subtract 2 from the value for the bitwise logic (so it does not clash with 0 and 1).
    xpos1 = [3,4,0,0,3,4,0];
    xpos2 = [2,2,0,0,2,2,0];
    xpos3 = [2,2,0,0,2,2,0];
    xpos4 = [2,2,2,2,2,2,0];
    xpos5 = [6,2,2,2,2,10,0];
    xpos6 = [0,0,0,0,0,0,0];
    xpos7 = [0,0,0,0,0,0,0];

    /* [debug] */
    //Slice along the x axis
    cutx = 0; //0.1
    //Slice along the y axis
    cuty = 0; //0.1
    // enable loging of help messages during render.
    help = false;

    /* [Hidden] */
    module end_of_customizer_opts () {}

    num_x = calcDimentionWidth ( width );
    num_y = calcDimentionWidth ( depth );

    if ( Butterfly_Clip_Only ) {
        ButterFly (
            size=[
            Butterfly_Clip_Size.x+Butterfly_Clip_Tollerance,
            Butterfly_Clip_Size.y+Butterfly_Clip_Tollerance,
            Butterfly_Clip_Size.z],
            r=Butterfly_Clip_Radius
        );
    }
    else {
        gridfinity_baseplate (
            num_x = num_x,
            num_y = num_y,
            oversizeMethod=oversize_method,
            plateStyle = Plate_Style,
            plateOptions = Base_Plate_Options,
            lidOptions = Lid_Options,
            customGridEnabled = Custom_Grid_Enabled,
            gridPossitions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
            butterflyClipEnabled  = Butterfly_Clip_Enabled,
            butterflyClipSize = Butterfly_Clip_Size,
            butterflyClipRadius = Butterfly_Clip_Radius,
            filamentClipEnabled=Filament_Clip_Enabled,
            filamentClipDiameter=Filament_Clip_Diameter,
            filamentClipLength=Filament_Clip_Length,
            lidIncludeMagnets = Lid_Include_Magnets,
            lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
            lidEfficientBaseHeight = Lid_Efficient_Base_Height,
            cutx = cutx,
            cuty = cuty,
            help = help
        );
    }

}
//----------------------------------------------------------------------------------------
