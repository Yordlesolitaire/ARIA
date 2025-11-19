extends State


func enter():
	match player.can_jump:
		true:
			player.play_anim("Jump")
		false:
			player.play_anim("Double_Jump")
