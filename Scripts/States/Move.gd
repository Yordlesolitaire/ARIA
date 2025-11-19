extends State


func update():
	if abs(player.dir.x) > 0.8:
		player.play_anim("Idle")
	else:
		player.play_anim("Walk")
