extends CharacterBody2D
class_name Aria

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var states:Dictionary = {}
var current_state:State
const features = {
  "courses": true,
  "saut_mario_appui_court": false,
  "saut_mario_appui_long": false,
  "bullet_time": false,
  "camera_haut_bas": false,
  "dash": false,
  "glissade_se_baisser": false,
  "grimper_rebord": false,
  "saut_rebord_vertical": false,
  "saut_rebord_horizontal": false,
  "viser": false,
  "tirer": false,
  "paravoile": false
}
var dir
var can_jump = true
var can_double_jump = true
var Is_jumping = false
var Is_double_jumping = false


func _ready() -> void:
	for state in $States.get_children():
		if state is State:
			states[state.name] = state
	print(states)
	change_state("Idle")
	
func change_state(name:String):
	current_state = states[name]
	current_state.player = self
	current_state.enter()

func play_anim(anim:String):
	$Sprite.play(anim)

func vector():
	var X = Input.get_axis("ui_left","ui_right")
	var Y = Input.get_axis("ui_up","ui_down")
	return Vector2(X,Y)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		Is_jumping = false
		Is_double_jumping = false
		can_jump = true
		can_double_jump = true
	if current_state:
		current_state.update()
		$LineEdit3.text = current_state.name
	dir = vector()
	$LineEdit2.text = str(dir)
	$LineEdit4.text = str([Is_double_jumping,Is_jumping])
	
	#gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	#move
	bullet_time()
	move()
	jump()
	move_and_slide()

func bullet_time():
	match Input.is_action_pressed("Viser"):
		true:
			match is_on_floor():
				false:
					Engine.time_scale = 0.1
		false:
			Engine.time_scale = 1
		

func move():
	velocity.x = dir.x * SPEED
	if velocity.x:
		if velocity.x > 0:
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.flip_h = true
		if is_on_floor():
			change_state("Move")
	else:
		if is_on_floor():
			change_state("Idle")

func jump():
	if Input.is_action_just_pressed("SAUT"):
		match is_on_floor():
			true:
				match can_jump:
					true:
						velocity.y = JUMP_VELOCITY 
						Is_jumping = true
						Is_double_jumping = false
						can_jump = false
						change_state("Jump")
			false:
				match can_double_jump:
					true:
						velocity.y = JUMP_VELOCITY
						Is_double_jumping = true
						Is_jumping = false
						can_double_jump = false
						change_state("Jump")
