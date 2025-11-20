extends State


func enter():
	if player.Is_jumping == true:
		player.play_anim("Jump")
	elif player.Is_double_jumping == true:
		player.play_anim("Double_Jump")
