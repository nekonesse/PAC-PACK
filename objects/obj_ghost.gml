#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ghost specific start
//blinky
if sprite_index = spr_blinkyghost
{
    ghost = 0
    drawing_sprite = global.spr_blinky
}
// pinky
if sprite_index = spr_empty
{
    // main
    ghost = 1
    // sprites
}
// clyde
if sprite_index = spr_empty
{
    // main
    ghost = 2
    // sprites
}
// inky
if sprite_index = spr_inkyghost
{
    // main
    ghost = 3
    drawing_sprite = global.spr_inky
}
// sue
if sprite_index = spr_empty
{
    // main
    ghost = 4
    // specific variable
    corner = 1;
}
// funky
if sprite_index = spr_empty
{
    // main
    ghost = 5
    // jumping variables
    /*zspeed = 0;
    jumpspeed = -8;
    grav = 0.6;
    z = 0;
    zfloor = 0;*/
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawner spawning
spawn = 0;
with(instance_create(x,y,obj_ghostspawn))
{
    other.spawn = id;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// default variables for all ghosts
targetx = 0;
targety = 0;
z = 0;
immune = false;
image_speed = 1;
ghost_speed = 2;
direction = 180;

state = "normal"
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Values
x_frame = 0
y_frame = 20;

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
/// ghost specific step event
if instance_exists(instance_nearest(x,y,obj_pacman))
{
// blinky
if ghost = 0
{
    targetx = instance_nearest(x,y,obj_pacman).x;
    targety = instance_nearest(x,y,obj_pacman).y;
}

//pinky
if ghost = 1
{
    xdirs[0] = +48;
    xdirs[1] = 0//-48;
    xdirs[2] = -48;
    xdirs[3] = 0;
    ydirs[0] = 0;
    ydirs[1] = -48;
    ydirs[2] = 0;
    ydirs[3] = +48;

    targetx = instance_nearest(x,y,obj_pacman).x + xdirs[instance_nearest(x,y,obj_pacman).direction/90];
    targety = instance_nearest(x,y,obj_pacman).y + ydirs[instance_nearest(x,y,obj_pacman).direction/90];
}
// clyde
if ghost = 2
{
    targetx = instance_nearest(x,y,obj_pacman).x;
    targety = instance_nearest(x,y,obj_pacman).y;

    if point_distance(x,y, instance_nearest(x,y,obj_pacman).x,instance_nearest(x,y,obj_pacman).y) > 96
    {
    targetx = 0;
    targety = room_height;
    }
}
// inky
if ghost = 3
{
    xdirs[0] = -24;
    xdirs[1] = +24;
    xdirs[2] = +24;
    xdirs[3] = 0;
    ydirs[0] = 0;
    ydirs[1] = +24;
    ydirs[2] = 0;
    ydirs[3] = -24;

    targetx = instance_nearest(x,y,obj_pacman).x + xdirs[instance_nearest(x,y,obj_pacman).direction/90];
    targety = instance_nearest(x,y,obj_pacman).y + ydirs[instance_nearest(x,y,obj_pacman).direction/90];
}
// sue
if ghost = 4
{
    if corner = 0
    {
        targetx = 0;
        targety = 0;
        if(point_distance(x,y,targetx,targety) < 96)
        {
            corner += 1;
        }
    }
    else if corner = 1
    {
        targetx = room_width;
        targety = 0;
        if(point_distance(x,y,targetx,targety) < 96)
        {
            corner += 1;
        }
    }
    else if corner = 2
    {
        targetx = room_width;
        targety = room_height;
        if(point_distance(x,y,targetx,targety) < 96)
        {
            corner += 1;
        }
    }
    else if corner = 3
    {
        targetx = 0;
        targety = room_height;
        if(point_distance(x,y,targetx,targety) < 96)
        {
            corner = 0;
        }
    }
}
// funky
if ghost = 5
{
    jump = keyboard_check_pressed(vk_space)

    if (jump && zspeed == 0)
    {
        zspeed = jumpspeed;
    }

    if (z != zfloor)
    {
        zspeed += grav;
    }

    if (z + zspeed > zfloor)
    {
        zspeed = 0;
        z = zfloor
    }

    z += zspeed;

    targetx = instance_nearest(x,y,obj_pacman).x;
    targety = instance_nearest(x,y,obj_pacman).y;
}
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// All ghost state normal
if instance_exists(obj_pacman)
{

if obj_globalmanager.timerscared > 595
{
immune = false
}

if state == "normal"
{
if global.scared = true && immune = false
{
state = "scared";
direction *= -1;
exit;
}

ghost_speed = 2;
new_direction = -1;
distance_to_pacman = 99999;

move_wrap(true,true,8)

depth = -y;

//UP
if direction != 270
{
    if place_meeting(x,y-ghost_speed, obj_wall) == false
    {
        dist = point_distance(x,y-ghost_speed, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction = 90;
            distance_to_pacman = dist;
        }
    }
}

//LEFT
if direction != 0
{
    if place_meeting(x-ghost_speed,y, obj_wall) == false
    {
         dist = point_distance(x-ghost_speed,y, targetx, targety);
        if dist < distance_to_pacman
        {
            new_direction = 180;
            distance_to_pacman = dist;
        }
    }
}

//RIGHT
if direction != 180
{
    if place_meeting(x+ghost_speed,y, obj_wall) == false
    {
        dist = point_distance(x+ghost_speed,y, targetx, targety);
        if dist < distance_to_pacman
        {
            initialx_frame = 0;
            new_direction = 0;
            distance_to_pacman = dist;
        }
    }
}

//DOWN
if direction != 90
{
    if place_meeting(x,y+ghost_speed, obj_wall) == false
    {
        dist = point_distance(x,y+ghost_speed, targetx, targety);
        if dist < distance_to_pacman
        {
            initialx_frame = 12;
            new_direction = 270;
            distance_to_pacman = dist;
        }
    }
}

switch direction
{
case 0: y_frame = 20 break;
case 90: y_frame = 22 break;
case 180: y_frame = 21 break;
case 270: y_frame = 23 break;
}

if new_direction != -1
{
direction = new_direction
}

move_contact_solid(direction,ghost_speed)
}
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// all ghost scared and dead step event
if instance_exists(obj_pacman)
{
    if state == "scared"
    {
    randomize();
    ghost_speed = 1;
    new_direction = -1;
    distance_to_pacman = 9999999;

    if global.scared == false
    {
    state = "normal"
    }

    move_wrap(true,true,8)

    depth = -y;
    // new scared code
    right = -1;
    left = -1;
    top = -1;
    down = -1;
    if(!place_meeting(x+ghost_speed,y,obj_wall) && direction != 180)
    right = 0;
    if(!place_meeting(x-ghost_speed,y,obj_wall) && direction != 0)
    left = 180;
    if(!place_meeting(x,y+ghost_speed,obj_wall) && direction != 90)
    down = 270;
    if(!place_meeting(x,y-ghost_speed,obj_wall) && direction != 270)
    top = 90;

    new_direction = choose(right,left,top,down)

    // old scared code
    /*var dx = choose(24,80,72,204,152,208,144);
    var dy = choose(274,160,104,40,80,272,216);

    if point_distance(x,y, obj_pacman.x,obj_pacman.y) < 64
    {
    dx = choose(24,80,72,204,152,208,144);
    dy = choose(274,160,104,40,80,272,216);
    }

    //UP
    if direction != 270
    {
        if place_meeting(x,y-2, obj_wall) == false
        {
            var dist = point_distance(x,y-8, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 90;
                distance_to_pacman = dist;
                sprite_index = spr_scaredghostup
            }
        }
    }

    //LEFT
    if direction != 0
    {
        if place_meeting(x-2,y, obj_wall) == false
        {
            var dist = point_distance(x-8,y, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 180;
                distance_to_pacman = dist;
                sprite_index = spr_scaredghostleft
            }
        }
    }

    //RIGHT
    if direction != 180
    {
        if place_meeting(x+2,y, obj_wall) == false
        {
            var dist = point_distance(x+8,y, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 0;
                distance_to_pacman = dist;
                sprite_index = spr_scaredghostright
            }
        }
    }

    //DOWN
    if direction != 90
    {
        if place_meeting(x,y+2, obj_wall) == false
        {
            var dist = point_distance(x,y+8, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 270;
                distance_to_pacman = dist;
                sprite_index = spr_scaredghostdown
            }
        }
    }*/

    if new_direction != -1
    {
        direction = new_direction
        if direction = top
        sprite_index = spr_scaredghostup;
        if direction = down
        sprite_index = spr_scaredghostdown;
        if direction = right
        sprite_index = spr_scaredghostright;
        if direction = left
        sprite_index = spr_scaredghostleft;
    }

    move_contact_solid(direction,ghost_speed)


    // state eaten
    }
    else if state == "eaten"
    {

    new_direction = -1;
    distance_to_pacman = 9999999;

    move_wrap(true,true,8)

    depth = -y;

    dx = spawn.x;
    dy = spawn.y;

    if instance_position(x,y,obj_ghostspawn)
    {
    immune = true
    state = "normal"
    }

    //UP
    if direction != 270
    {
        if place_meeting(x,y-ghost_speed, obj_wall) == false
        {
        dist = point_distance(x,y-ghost_speed, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 90;
                distance_to_pacman = dist;
                sprite_index = spr_ghosteatenup
            }
        }
    }

    //LEFT
    if direction != 0
    {
        if place_meeting(x-ghost_speed,y, obj_wall) == false
        {
            dist = point_distance(x-ghost_speed,y, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 180;
                distance_to_pacman = dist;
                sprite_index = spr_ghosteatenleft
            }
        }
    }

    //RIGHT
    if direction != 180
    {
        if place_meeting(x+ghost_speed,y, obj_wall) == false
        {
            dist = point_distance(x+ghost_speed,y, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 0;
                distance_to_pacman = dist;
                sprite_index = spr_ghosteatenright
            }
        }
    }

    //DOWN
    if direction != 90
    {
        if place_meeting(x,y+ghost_speed, obj_wall) == false
        {
            dist = point_distance(x,y+ghost_speed, dx, dy);
            if dist < distance_to_pacman
            {
                new_direction = 270;
                distance_to_pacman = dist;
                sprite_index = spr_ghosteatendown
            }
        }
    }

    if new_direction != -1
    {
    direction = new_direction
    }

    move_contact_solid(direction,ghost_speed)
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Draw Sprite
draw_sprite_part(drawing_sprite,0,floor(x_frame)*tile_width,y_frame*tile_height,tile_width,tile_height,x,y)

//ANIMATE SHEET
x_frame += anim_speed/room_speed;
if(x_frame >= anim_length) x_frame = 0;
