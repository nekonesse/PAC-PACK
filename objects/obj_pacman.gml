#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//please dont mess with this its for the collision box
boxx1 = 10
boxy1 = 10
boxx2 = 21
boxy2 = 21
//jumping stuff
zspeed = 0;
jumpspeed = -8;
grav = 0.4;
z = 0;
zfloor = 0;
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

tile_width = 32;
tile_height = 32;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if state == "normal"
{
jump = keyboard_check_pressed(vk_space)

pm_speed = pm_defaultsp;
clamp(timer1, 0, timer1def)
clamp(z,0,9999)
clamp(zspeed,0,9999)

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

if pm_speed != 0
{
anim_speed = pm_speed * 8
}
else
{
anim_speed = 1
}

move_wrap(true,true,16)

depth = -y;

//jumping
if (jump && zspeed == 0)
{
    zspeed = jumpspeed;
}

if (z != zfloor)
{
zspeed += grav
}

if (z + zspeed > zfloor)
{
zspeed = 0;
z = zfloor
}

z += zspeed;

ins = collision_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2, obj_powerdot, false, false);
if ins != noone && z > -4
{
    global.points += 50
    global.lifepoints += 50
    //vvvvvv remove these comments if you want the power pellets to spawn a score under it after its eaten vvvvv
    /*insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 50
        }
    }*/
    obj_globalmanager.timerscared = 600
    global.scared = true
    with(ins)
    {
        instance_destroy()
    }
exit
}

 insp = collision_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2, obj_dot, false, false);
if insp != noone && z > -4
{
    //vvvvvv remove these comments if you want the pellets to spawn a score under it after its eaten vvvvv
    /*insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 10
        }
    }*/
    global.points += 10
    global.lifepoints += 10
    with(insp)
    {
    instance_destroy()
    }
exit
}


/* insfruit = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_fruit, false, false);
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

/*
 ins2 = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_dashpanel, false, false);
if ins2 != noone && z = 0
{
pm_defaultsp = 4
timer1 = timer1def
}

// colisions
 col_ghost = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_ghost, false, false);
if col_ghost != noone && z > -16
{
if col_ghost.state == states.scared
{
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(col_ghost)
{
state = states.eaten
}
}
else if col_ghost.state == states.normal && !immune
{
player_die();
exit;
}
}

/*
 inspinky = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_pinky, false, false);
if inspinky != noone && z > -16
{
if inspinky.state == pinkystates.scared
{
(snd_ghosteat,101,false)
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(inspinky)
{
state = pinkystates.eaten
}
}
else if inspinky.state == pinkystates.normal && !immune
{
player_die();
exit;
}
}

 insclyde = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_clyde, false, false);
if insclyde != noone && z > -16
if insclyde.state == clydestates.scared
{
(snd_ghosteat,101,false)
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(insclyde)
{
state = clydestates.eaten
}
}
else if insclyde.state == clydestates.normal && !immune
{
player_die();
exit;
}

 insinky = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_inky, false, false);
if insinky != noone && z > -16
if insinky.state == inkystates.scared
{
(snd_ghosteat,101,false)
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(insinky)
{
state = inkystates.eaten
}
}
else if insinky.state == inkystates.normal && !immune
{
player_die();
exit;
}

 inssue = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_sue, false, false);
if inssue != noone && z > -16
if inssue.state == suestates.scared
{
(snd_ghosteat,101,false)
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(inssue)
{
state = suestates.eaten
}
}
else if inssue.state == suestates.normal && !immune
{
player_die();
exit;
}

 insfunky = collision_rectangle(x-boxx1,y-boxy1,x+boxx2,y+boxy2, obj_funky, false, false);
if insfunky != noone && z > insfunky.z-16
if insfunky.state == funkystates.scared
{
(snd_ghosteat,101,false)
global.points += 200
global.lifepoints += 200
 insscore = instance_create(x,y,obj_scoreindicator)
    if insscore != noone
    {
        with(insscore)
        {
            drawscore = 200
        }
    }
with(insfunky)
{
state = funkystates.eaten
}
}
else if insfunky.state == funkystates.normal && !immune
{
player_die();
exit;
}
*/
// keyboard checks
if keyboard_check(vk_left) == true
{
if place_meeting(x-4,y, obj_wall) == false
{
direction = 180;
y_frame = 1
}
}

if keyboard_check(vk_right) == true
{
if place_meeting(x+4,y, obj_wall) == false
{
direction = 0;
y_frame = 0
}
}

if keyboard_check(vk_up) == true
{
if place_meeting(x,y-4, obj_wall) == false
{
direction = 90;
y_frame = 2
}
}

if keyboard_check(vk_down) == true
{
if place_meeting(x,y+4, obj_wall) == false
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_part(global.spr_player,0,floor(x_frame)*tile_width,y_frame*tile_height,tile_width,tile_height,x-16,y-16)

//ANIMATE SHEET
x_frame += anim_speed/room_speed;
if(x_frame >= anim_length) x_frame = initialx_frame;

//draw_rectangle(x+boxx1,y+boxy1,x+boxx2,y+boxy2,true)
