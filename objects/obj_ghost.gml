#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Draw Sprite
draw_sprite_part(drawing_sprite,0,floor(x_frame)*tile_width,final_y_frame*tile_height,tile_width,tile_height,round(x)-16,round(y)-16)

//ANIMATE SHEET
x_frame += anim_speed/room_speed;
if(x_frame >= anim_length) x_frame = 0;

//debug stuff
if global.debug {
if !(state == "scared") draw_line(x,y,targetx,targety)
draw_text(x,y,immune)

draw_text(x,y-16,direction)
}
