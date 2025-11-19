extends Area2D
var mode = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#mode 1 = "mélé" 2 = "distance"
	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			mode = 1
			print("mélé",mode)
		elif mode == 1:
			mode = 0
			print("distance", mode)
	hide()
	if Input.is_action_pressed(("viser")) and mode == 1:
		show()
		position = get_global_mouse_position()
