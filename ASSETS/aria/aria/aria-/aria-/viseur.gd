extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Input.is_action_pressed("viser"):
		show()
		position = get_global_mouse_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
