/// player_die(player)
player=argument0

room_restart();
global.lifes -= 1;
player.sprite_index = global.spr_player
player.state = "dead"
