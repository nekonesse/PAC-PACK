#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Values

anim_speed = 6;
anim_length = 8;

initialx_frame = 0; //use this one instead of x_frame to set the X position of the sprite
x_frame = initialx_frame;
y_frame = 0;
y_frameoffset = 0;
final_y_frame = y_frame + y_frameoffset;

tile_width = 32;
tile_height = 32;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//ANIMATE SHEET
draw_sprite_part(global.spr_mazeobject,0,floor(x_frame)*tile_width,final_y_frame*tile_height,tile_width,tile_height,x-16,y-16)

x_frame += anim_speed/room_speed;
if(x_frame >= anim_length) x_frame = initialx_frame;
