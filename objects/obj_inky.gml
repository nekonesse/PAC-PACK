#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
targetx = 0;
targety = 0;
z = 0;
immune = false;
image_speed = 1;
ghost_speed = 2;
direction = 180;
spawn = instance_create(x,y,obj_ghostspawn)

//change how fast the flashing is when about to turn back to normal
flash_time = 120;
interval = 24;

state = "normal"

drawing_sprite = global.spr_inky
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Values
x_frame = 0
y_frame = 20;
y_frameoffset = 0;
final_y_frame = y_frame + y_frameoffset;

anim_speed = 12;
anim_length = 4;

tile_width = 32;
tile_height = 32;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
final_y_frame = y_frame + y_frameoffset;

if !instance_exists(obj_pacman) exit;

if obj_pacman.state == "spawn" exit;

move_wrap(true,true,8)

depth = -y;

switch state
{
    case "normal":
    {
        flash_time = 120;
        y_frameoffset = 0;
        ghost_speed = 2;
        new_direction = -1;
        distance_to_pacman = 99999;

        xdirs[0] = +48;
        xdirs[1] = 0//-48;
        xdirs[2] = -48;
        xdirs[3] = 0;
        ydirs[0] = 0;
        ydirs[1] = -48;
        ydirs[2] = 0;
        ydirs[3] = +48;

        if instance_exists(obj_blinky)
        {
        targetx = 2 * obj_pacman.x - obj_blinky.x;
        targety = 2 * obj_pacman.y - obj_blinky.y;
        }
        else
        {
        targetx = instance_nearest(x,y,obj_pacman).x + xdirs[instance_nearest(x,y,obj_pacman).direction/90];
        targety = instance_nearest(x,y,obj_pacman).y + ydirs[instance_nearest(x,y,obj_pacman).direction/90];
        }

        if global.behavior == "scatter"
        {
        targetx = room_width;
        targety = room_height;
        }

        if (global.scared) && !(immune)
        {
            state = "scared";
        }

        break;
    }
    case "scared":
    {
        ghost_speed = 1;
        distance_to_pacman = 9999999;

        if global.scared == false
        {
            state = "normal"
        }

        if obj_globalmanager.timerscared < 120
        {
            flash_time -= 1
        }

        // new scared code
        listinky = ds_list_create()

        if(!place_meeting(x+ghost_speed,y,obj_wall) && direction != 180)
        {
            ds_list_add(listinky,0)
        }
        if(!place_meeting(x-ghost_speed,y,obj_wall) && direction != 0)
        {
            ds_list_add(listinky,180)
        }
        if(!place_meeting(x,y+ghost_speed,obj_wall) && direction != 90)
        {
            ds_list_add(listinky,270)
        }
        if(!place_meeting(x,y-ghost_speed,obj_wall) && direction != 270)
        {
            ds_list_add(listinky,90)
        }

        ds_list_shuffle(listinky)

        new_direction = ds_list_find_value(listinky, 0);

        if new_direction != -1
        direction = new_direction

        switch direction
        {
        case 0: y_frame = 12 break; //Right
        case 90: y_frame = 14 break; //Up
        case 180: y_frame = 13 break;//Left
        case 270: y_frame = 15 break; //Down
        }

        ds_list_clear(listinky);
        ds_list_destroy(listinky);

        if (flash_time mod interval) <= interval/2
        y_frameoffset = 0
        else
        y_frameoffset = 4

        break;
    }
    case "eaten":
    {
        ghost_speed = 4;
        new_direction = -1;
        distance_to_pacman = 9999999;
        y_frameoffset = 0;

        targetx = spawn.x;
        targety = spawn.y;

        if round(x) == targetx && round(y) == targety
        {
            immune = true
            state = "normal"
        }

        break;
    }
}



if state != "scared"
{

//UP
if direction != 270
{
    if !place_meeting(x,y-ghost_speed, obj_wall)
    {
        dist = point_distance(x,y-ghost_speed, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction=90;
            distance_to_pacman=dist;
        }
    }
}

//LEFT
if direction != 0
{
    if !place_meeting(x-ghost_speed,y, obj_wall)
    {
         dist = point_distance(x-ghost_speed,y, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction=180;
            distance_to_pacman=dist;
        }
    }
}

//RIGHT
if direction != 180
{
    if !place_meeting(x+ghost_speed,y, obj_wall)
    {
        dist = point_distance(x+ghost_speed,y, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction=0;
            distance_to_pacman=dist;
        }
    }
}

//DOWN
if direction != 90
{
    if !place_meeting(x,y+ghost_speed, obj_wall)
    {
        dist = point_distance(x,y+ghost_speed, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction=270;
            distance_to_pacman=dist;
        }
    }
}
}

switch state
{
case "normal":
    {
        if new_direction != -1
        direction = new_direction


        switch direction
        {
        case 0: y_frame = 20 break;
        case 90: y_frame = 22 break;
        case 180: y_frame = 21 break;
        case 270: y_frame = 23 break;
        }

        break;
    }
case "eaten":
    {
        if new_direction != -1
        direction = new_direction
        y_frameoffset = 0;

            switch direction
            {
            case 0: y_frame = 24 break; //Right
            case 90: y_frame = 26 break; //Up
            case 180: y_frame = 25 break;//Left
            case 270: y_frame = 27 break; //Down
            }
    break;
    }
}

if place_meeting(x,y,obj_tunnel) && state != "eaten"
{
ghost_speed=1
}

move_contact_solid(direction,ghost_speed)

x=round(x)
y=round(y)
