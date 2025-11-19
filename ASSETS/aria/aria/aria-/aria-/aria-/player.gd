extends CharacterBody2D
var gravité_force = 400
const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const JUMPFORCE = -500
var can_doublejump = true
var can_double_jump_wall = true
var can_dash = true
const DASH_VELOCITY = 1000
var dash_direction = 0
var VELOCITE = velocity.y
var rs_look = Vector2(0,0)
var deadzone = 0.3
var mode = 0
const wait_time = 5000000
var état = 0
func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)
func timeout_function():
	pass


	
			
			
func _physics_process(delta):
	var direction = Input.get_axis("Gauche", "droite")
	var droite = Input.is_action_pressed("droite")
	var gauche = Input.is_action_pressed("Gauche")

	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			print("mélé",mode)
			mode = 1
		elif mode == 1:
			print("distance", mode)
			mode = 0
			
	
	if droite:
		$AnimatedSprite2D.flip_h = false
	if gauche:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()
	if not is_on_floor():
		velocity += get_gravity() * delta
		if droite:
			velocity.x = (direction * SPEED)/3
			$AnimatedSprite2D.flip_h = false
		elif gauche:
			velocity.x = (direction * SPEED)/3
			$AnimatedSprite2D.flip_h = true
			
	if is_on_floor():
		if droite:
			velocity.x = (direction * SPEED)/3
			$AnimatedSprite2D.flip_h = false
			if état == 0:
				$AnimatedSprite2D.play("marche")
		elif gauche:
			velocity.x = (direction * SPEED)/3
			$AnimatedSprite2D.flip_h = true
			if état == 0:
				$AnimatedSprite2D.play("marche")
		else:
			$AnimatedSprite2D.play("idle")
			velocity.x = 0
			
		can_double_jump_wall = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#viser
	if Input.is_action_pressed("viser_bouclier"):
		if mode == 1:
			if direction:
				$AnimatedSprite2D.play("idle")
				velocity.x = 0
		if mode == 0:
			if direction:
				$AnimatedSprite2D.play("idle")
				velocity.x = 0
	else:
		rotation_degrees = 0
	var direction_Y = Input.get_axis("haut", "bas")
	#saut
	if Input.is_action_just_pressed("saut"):
		if is_on_floor():
			$AnimatedSprite2D.play("saut_static")
			velocity.y = JUMPFORCE
			can_doublejump = true
			print(can_doublejump)
			can_dash=true
		if not is_on_floor() and not is_on_wall() and can_doublejump==true:
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("double_saut_static")
			velocity.y = JUMPFORCE
			can_doublejump = false
			print(can_doublejump)
			can_dash=true
#tout ce qui se raporte au mur
	if is_on_wall():
		#print("mur")
			if Input.is_action_pressed("escalade"):
				$AnimatedSprite2D.play("idle")
				velocity = get_gravity() * delta * 0
				if Input.is_action_pressed("haut"):
					if direction_Y:
						velocity.y = direction_Y * SPEED/3
					else:
						velocity.y = move_toward(velocity.y, 0, SPEED/5)
				if Input.is_action_pressed("bas"):
					if direction_Y:
						velocity.y = direction_Y * SPEED/3
					else:
							velocity.y = move_toward(velocity.y, 0, SPEED/5)
				if Input.is_action_pressed("Gauche") or Input.is_action_pressed("droite"):
					if direction:
						velocity.x = direction * SPEED
					else:
						velocity.x = move_toward(velocity.x, 0, SPEED)
			if Input.is_action_just_pressed("saut") and can_double_jump_wall==true:
				$AnimatedSprite2D.play("double_saut_static")
				velocity += get_gravity() * delta
				position.x += 1 
				velocity.y = JUMPFORCE
				can_double_jump_wall = false
				if is_on_floor():
					can_double_jump_wall=true
	if Input.is_action_just_pressed("dash") and can_dash == true:
		état = 1
		$dash.play()
		if direction:
			$AnimatedSprite2D.play("dash")
			velocity.x *= 100
			can_dash = false
			await get_tree().create_timer(0.5).timeout
			état = 0
			
		else:
			$AnimatedSprite2D.play("dash")
			velocity.x *= 100
			can_dash = false
			await get_tree().create_timer(0.5).timeout
			état = 0
		can_dash = true
