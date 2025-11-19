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
var pos_bouclier = 80
var can_shield=true
var last_dir = 0
var tir = preload("res://projectile.tscn")
func shoot_laser():
	var l = tir.instantiate()
	l.global_position = $muzzle.global_position
	l.rotation = rotation
func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)
func timeout_function():
	pass
func _physics_process(delta):
	var direction = Input.get_axis("Gauche", "droite")
	var droite = Input.is_action_pressed("droite")
	var gauche = Input.is_action_pressed("Gauche")
	var haut = Input.is_action_pressed("haut")
	var bas = Input.is_action_pressed("bas")
	$bouclier.position.x = 100000
	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			mode = 1
			print("mélé",mode)
		elif mode == 1:
			mode = 0
			print("distance", mode)
	$AnimatedSprite2D/lanterne.play("idle")
	if droite and not Input.is_action_pressed("viser_bouclier"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D/lanterne.position.x = -16
		last_dir = 1
	if gauche and not Input.is_action_pressed("viser_bouclier"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D/lanterne.position.x = 16
		last_dir = 0
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
			velocity.x = (direction * SPEED)/2
			$AnimatedSprite2D.flip_h = false
			if état == 0:
				$AnimatedSprite2D.play("marche")
		elif gauche:
			velocity.x = (direction * SPEED)/2
			$AnimatedSprite2D.flip_h = true
			if état == 0:
				$AnimatedSprite2D.play("marche")
		else:
			$AnimatedSprite2D.play("idle")
			velocity.x = 0
		can_double_jump_wall = true
	# Get the input direction and handle the movement/deceleration.
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	if Input.is_action_pressed("viser_bouclier") and mode==1:
		$AnimatedSprite2D/lanterne.play("bouclier")
		if droite:
			$bouclier.position.x = 80
			$bouclier.position.y = 0
			$bouclier.rotation_degrees = 180
			last_dir = 1
		if gauche:
			$bouclier.position.x = -80
			$bouclier.position.y = 0
			$bouclier.rotation_degrees = 0
			last_dir = 0
		if haut:
			$bouclier.position.x = 0
			$bouclier.position.y = -120
			$bouclier.rotation_degrees = 90
		if bas:
			$bouclier.position.x = 0
			$bouclier.position.y = 120
			$bouclier.rotation_degrees = -90
		if haut and droite:
			$bouclier.position.x = 80
			$bouclier.position.y = -120
			$bouclier.rotation_degrees = 130
			last_dir = 1
		if bas and droite:
			$bouclier.position.x = 80
			$bouclier.position.y = 120
			$bouclier.rotation_degrees = -130
			last_dir = 1
		if bas and gauche:
			$bouclier.position.x = -80
			$bouclier.position.y = 120
			$bouclier.rotation_degrees = -45
			last_dir = 0
		if haut and gauche:
			$bouclier.position.x = -80
			$bouclier.position.y = -120
			$bouclier.rotation_degrees = 45
			last_dir = 0
		else:
			if direction == 0 and not Input.is_action_pressed("haut") and not Input.is_action_pressed("bas"):
				if last_dir == 1:
					$bouclier.position.x = 80
					$bouclier.position.y = 0
					$bouclier.rotation_degrees = 180
				if last_dir == 0:
					$bouclier.position.x = -80
					$bouclier.position.y = 0
					$bouclier.rotation_degrees = 0
	if Input.is_action_pressed("viser_bouclier") and mode==0 and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if droite and is_on_floor():
			velocity.x = 0
			$AnimatedSprite2D.flip_h = false
		elif gauche and is_on_floor():
			velocity.x = 0
			$AnimatedSprite2D.flip_h = true
		if $crossair.position.x > $AnimatedSprite2D.position.x:
			$AnimatedSprite2D.flip_h = false
		elif $crossair.position.x < $AnimatedSprite2D.position.x:
			$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("viser_bouclier") and mode==0 and not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if droite and is_on_floor():
			velocity.x = 0
			$AnimatedSprite2D.flip_h = false
		elif gauche and is_on_floor():
			velocity.x = 0
			$AnimatedSprite2D.flip_h = true
	if not Input.is_action_pressed("viser_bouclier"):
		$crossair.position.x = position.x
		$crossair.position.y = position.y - 80
	var direction_Y = Input.get_axis("haut", "bas")
	#saut
	if Input.is_action_just_pressed("saut") and not (Input.is_action_pressed("viser_bouclier")and mode == 0):
		if is_on_floor():
			$AnimatedSprite2D.play("saut_static")
			velocity.y = JUMPFORCE
			can_doublejump = true
			can_dash=true
		if not is_on_floor() and not is_on_wall() and can_doublejump==true:
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("double_saut_static")
			velocity.y = JUMPFORCE
			can_doublejump = false
			can_dash=true
#tout ce qui se raporte au mur
	if is_on_wall():
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
			$bouclier.position.x += 500
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
