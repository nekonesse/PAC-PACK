#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*font1big_string = " ABCDEFGHIJKLMNOPQRSTUVWXYZ!'?-:/0123456789."
font1small_string = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!?-./"
font2big_string = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!'?-:/."
font3small_string = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!;?=:&',.()*+-/@|#_%up"
font4small_string = " 0123456789x"
global.font1big = font_add_sprite_ext(spr_font1big, font1big_string, false, 2)
global.font2big = font_add_sprite_ext(spr_font2big, font2big_string, false, 2)
global.font1small = font_add_sprite_ext(spr_font1small, font1small_string, false, 2)
global.font3small = font_add_sprite_ext(spr_font3small, font3small_string, false, 2)
global.font4small = font_add_sprite_ext(spr_font4small, font4small_string, false, 1)*/

global.points = 0
global.lifepoints = 0
global.lifes = 3;


global.scared = false

timerscared = 300

global.spr_player=sprite_add(working_directory+"\assets\pacman.png",0,0,0,0,0)
global.spr_maze=sprite_add(working_directory+"\assets\maze.png",0,0,0,0,0)
global.spr_bg=background_add(working_directory+"\assets\background.png",0,0)
global.spr_bg=background_add(working_directory+"\assets\background.png",0,0)
global.spr_blinky=sprite_add(working_directory+"\assets\blinky.png",0,0,0,0,0)
global.spr_inky=sprite_add(working_directory+"\assets\inky.png",0,0,0,0,0)
global.spr_pinky=sprite_add(working_directory+"\assets\pinky.png",0,0,0,0,0)

/*global.snd_dashpanel = sound_add_included("dashpanel.wav",0,1)
global.snd_fruiteaten = sound_add_included("fruiteaten.wav",0,1)
global.snd_ambientscared = sound_add_included("ambientscared.wav",0,1)
global.snd_ambienteaten = sound_add_included("ambienteaten.wav",0,1)
global.snd_ghosteat = sound_add_included("ghosteat.wav",0,1)
global.snd_ghostrespawn = sound_add_included("ghostrespawn.wav",0,1)
global.snd_lifegained = sound_add_included("lifegained.wav",0,1)
global.snd_death = sound_add_included("death.wav",0,1)
global.snd_powerdot = sound_add_included("powerdot.wav",0,1)
global.snd_scaredstart = sound_add_included("scaredstart.wav",0,1)
global.snd_wakka = sound_add_included("wakka.wav",0,1)


//background_index[0] = global.spr_bg
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Animation Values

anim_length = 1;
anim_speed = 1;

x_frame = 0;
y_frame = 0;

tile_width = 1;
tile_height = 1;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center)
//draw_set_font(global.font3small)
draw_set_color(c_yellow)
draw_text(80,0,"1up")
draw_set_color(c_white)
draw_text(80,16,global.points)

/*switch global.lifes
{
case 1: draw_sprite(spr_lives,0,0,display_get_gui_height()-32) break;
case 2: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,4,32,display_get_gui_height()-32) break;
case 3: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,3,32,display_get_gui_height()-32) break;
case 4: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,4,64,display_get_gui_height()-32) break;
case 5: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,3,64,display_get_gui_height()-32) break;
case 6: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,2,64,display_get_gui_height()-32) draw_sprite(spr_lives,4,96,display_get_gui_height()-32) break;
case 7: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,2,64,display_get_gui_height()-32) draw_sprite(spr_lives,3,96,display_get_gui_height()-32) break;
case 8: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,2,64,display_get_gui_height()-32) draw_sprite(spr_lives,2,96,display_get_gui_height()-32) draw_sprite(spr_lives,4,128,display_get_gui_height()-32) break;
case 9: draw_sprite(spr_lives,1,0,display_get_gui_height()-32) draw_sprite(spr_lives,2,32,display_get_gui_height()-32) draw_sprite(spr_lives,2,64,display_get_gui_height()-32) draw_sprite(spr_lives,2,96,display_get_gui_height()-32) draw_sprite(spr_lives,3,128,display_get_gui_height()-32) break;
}
