extends Area2D
var mode = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hide()
	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			print("mélé",mode)
			mode = 1
		elif mode == 1:
			print("distance", mode)
			mode = 0
	if Input.is_action_pressed("viser_bouclier") and mode==0:
		show()
		position = get_global_mouse_position()
		
