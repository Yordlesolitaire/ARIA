extends CollisionShape2D
var mode = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = 0
	position.y = 0
	hide()
	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			print("mélé",mode)
			mode = 1
		elif mode == 1:
			print("distance", mode)
			mode = 0
	if Input.is_action_pressed("viser_bouclier") and mode==1:
		show()
		position = get_tree().get_root().find_node("player")
