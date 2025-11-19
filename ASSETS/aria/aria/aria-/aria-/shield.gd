extends CharacterBody2D
var direction = Input.get_axis("Gauche", "droite")
var droite = Input.is_action_pressed("droite")
var gauche = Input.is_action_pressed("Gauche")

const SPEED = 500
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		pass
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if droite:
		$AnimatedSprite2D/bouclier.velocity.x = $player.velocity.x
	elif gauche:
		$AnimatedSprite2D/bouclier.velocity.x = $player.velocity.x

	move_and_slide()
