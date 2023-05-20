#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Collision box size
boxx = 4
boxy = 4
//timer stuff i dont remember you can just look in the code
timer1def = 120
timer1 = timer1def
timer1bool = false
timerwait = 60;
timerrespawn = 60;
respawnstate = true;
deadaf = false;
//player default speed
pm_defaultsp = 2;
//player current speed
pm_speed = pm_defaultsp;
//bugfixing
immune = false;

offx=4
offy=0

state = "spawn"
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Values

anim_speed = 12;
anim_length = 4;

initialx_frame = 0; //use this one instead of x_frame to set the X position of the sprite
x_frame = initialx_frame;
y_frame = 0;
y_frameoffset = 0;
final_y_frame = y_frame + y_frameoffset;

tile_width = 32;
tile_height = 32;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Main Controller

if keyboard_check_pressed(ord("G")) god=!god

if state == "normal"
{
final_y_frame = y_frame + y_frameoffset;

jump = keyboard_check_pressed(vk_space);

pm_speed = pm_defaultsp;
clamp(timer1, 0, timer1def)

timerwait = 60;
timerrespawn = 60;
respawnstate = false;
deadaf = false;

timer1 -= 1;

if timer1 = 0
{
pm_speed = pm_defaultsp
timer1 = timer1def
}

move_wrap(true,true,16)

depth = -y;

ins = collision_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2, obj_powerdot, false, false);
if ins != noone
{
    global.points += 50
    global.lifepoints += 50
    obj_globalmanager.timerscared = 600
    global.scared = true
    if instance_exists(obj_ghost) with(obj_ghost){
    if state == "normal"
    immune=0
    flash_time=120
    y_frameoffset=0
    direction+=180
    }
    //vvvvvv Hi There! Remove these comments if you want the power pellets to spawn a score under it after its eaten vvvvv
    /*insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 50
        }
    }*/
    with(ins)
    {
        instance_destroy()
    }
exit
}

 insp = collision_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2, obj_dot, false, false);
if insp != noone
{
    with(insp)
    {
        instance_destroy()
    }

    if obj_globalmanager.scoretext = true
    {
        insscore = instance_create(x,y,obj_scoreindicator)
        if insscore != noone
        {
            with(insscore)
            {
                drawscore = 10
            }
        }
    }


    global.points += 10
    global.lifepoints += 10
exit
}


insfruit = collision_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2, obj_fruit, false, false);
if insfruit != noone && z > -4 && insfruit.sprite_index != spr_empty
{
     insscore = instance_create(obj_fruit.x,obj_fruit.y,obj_scoreindicator)
    global.points += global.fruitscore
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = global.fruitscore
        }
    }
    global.lifepoints += global.fruitscore
    with(insfruit)
    {
    instance_destroy()
    }
exit
}

switch direction
{
case 0: {offx=4 offy=0 break;}
case 90: {offx=0 offy=-4 break;}
case 180: {offx=-4 offy=0 break;}
case 270: {offx=0 offy=4 break;}
}

col_ghost = instance_position(x+offx,y+offy,obj_ghost)
if col_ghost != noone
{
    if col_ghost.state == "scared"
    {
        global.points += 200
        global.lifepoints += 200
        //insscore = instance_create(x,y,obj_scoreindicator)
        /*if insscore != noone
        {
        with(insscore)
        {
        drawscore = 200
        }
        }*/
        col_ghost.state = "eaten"
        exit;
    }
    else if col_ghost.state == "normal"
    {
        if !(god) player_die(id);
    }
}

/*
 ins2 = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_dashpanel, false, false);
if ins2 != noone
{
pm_defaultsp = 4
timer1 = timer1def
}*/

// keyboard checks
if keyboard_check(vk_left)
{
    if !place_meeting(x-4,y, obj_wall) && !place_meeting(x-4,y, obj_ghostwall)
    {
        direction = 180;
        y_frame = 1
    }
}

if keyboard_check(vk_right)
{
    if !place_meeting(x+4,y, obj_wall) && !place_meeting(x+4,y, obj_ghostwall)
    {
        direction = 0;
        y_frame = 0
    }
}

if keyboard_check(vk_up)
{
    if !place_meeting(x,y-4, obj_wall) && !place_meeting(x,y-4, obj_ghostwall)
    {
        direction = 90;
        y_frame = 2
    }
}

if keyboard_check(vk_down)
{
    if !place_meeting(x,y+4, obj_wall) && !place_meeting(x,y+4, obj_ghostwall)
    {
        direction = 270;
        y_frame = 3
    }
}

move_contact_solid(direction,pm_speed)

}
else if state == "dead"
{
image_speed = 0.1

if round(image_index) > 5 && sprite_index == global.spr_player
{
    deadaf = true;
    sprite_index = spr_empty
}

if deadaf == true
{
    image_speed = 0;
    timerwait -= 1

    if timerwait < 1
    {
        respawnstate = true;
        player_respawn();

        if respawnstate == true
        {
            timerrespawn -= 1

            if timerrespawn < 1
            {
                state = "normal"
            }
        }
    }
}
}
else if state == "spawn"
{
    image_speed = 0;
    timerrespawn -= 1

    if timerrespawn < 1
    {
        obj_globalmanager.alarm[0] = 1200/2
        state = "normal"
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// bugfixing buttons
if keyboard_check_pressed(ord('Z'))
{
    global.scared = true;
}
if keyboard_check_pressed(ord('X'))
{
    if immune
    {
        immune = false;
    }
    else
    {
        immune = true;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Stop

if state == "normal"
{

    if pm_speed != 0
    {
        if x == xprevious && y == yprevious
        anim_speed = 0
        else
        anim_speed = pm_speed * 8

    }
    else if pm_speed == 0
    {
        anim_speed = 0
    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//ANIMATE SHEET
draw_sprite_part(global.spr_player,0,floor(x_frame)*tile_width,final_y_frame*tile_height,tile_width,tile_height,round(x)-16,round(y)-16)

x_frame += anim_speed/room_speed;
if(x_frame >= anim_length) x_frame = initialx_frame;

if global.debug {
draw_set_color(c_ltgray)
draw_rectangle(x+offx,y+offy,(x+offx)+1,(y+offy)+1,false)
draw_text(x,y+8,instance_number(obj_dot))
draw_text(x,y-8,global.behavior)
draw_set_color(c_white)
}
