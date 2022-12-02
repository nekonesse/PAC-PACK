/// player_die()
room_restart();
global.lifes -= 1;
obj_pacman.sprite_index = global.spr_player
obj_pacman.state = "dead"
