extends RigidBody2D
const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const JUMPFORCE = -500
var can_doublejump = true
func _physics_process(delta):
	# Add the gravity.
	velocity += get_gravity() * delta

func _process(delta):
	look_at(get_global_mouse_position())
