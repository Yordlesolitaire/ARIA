extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var states = {}
var current_state:State = null
var dir
var can_jump = true
var can_double_jump = true
func _ready() -> void:
	for i in $States.get_children():
		if i is State:
			states[i.name] = i
	print(states)
	change_state("Idle")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	current_state.update()
	$LineEdit2.text = current_state.name
	dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	simple_move()
	update_sprites()
	simple_cam()
	$LineEdit.text ="Can jump : " + str(can_jump)
	$LineEdit3.text = "Can double jump : " + str(can_double_jump)
	$LineEdit4.text = "vel x : " + str(dir.x)
	move_and_slide()
func simple_cam():
	if abs(dir.y) >= 0.9 and abs(dir.x) < 0.3:
		$Camera2D.position_smoothing_enabled = true
		$Camera2D.position.y = 50 * dir.y / abs(dir.y)
	else:
		$Camera2D.position.y = 0
	#print($Camera2D.position)

func change_state(name:String):
	if states[name]:
		if current_state:
			current_state.exit()
		current_state = states[name]
		current_state.player = self
		current_state.enter()
func play_anim(name:String):
	$Sprite.play(name)
func update_sprites():
	if dir.x > 0:
		$Sprite.flip_h = false
	elif dir.x < 0:
		$Sprite.flip_h = true

func simple_move():
	if abs(dir.x) < 0.3:
		dir.x = 0
	velocity.x = dir.x * SPEED
	if dir.x and is_on_floor():
		change_state("Move")
	else:
		if is_on_floor():
			change_state("Idle")

	if Input.is_action_just_pressed("ui_accept") or Input.is_joy_button_pressed(0,JOY_BUTTON_A):

		if can_jump == true and is_on_floor():
			velocity.y = JUMP_VELOCITY
			change_state("Jump")
			print("jump")
			await get_tree().create_timer(0.2).timeout
			can_jump = false
		elif can_double_jump == true and not is_on_floor():
			velocity.y = JUMP_VELOCITY
			
			print("double jump")
			change_state("Jump")
			can_double_jump = false
	if is_on_floor() and can_jump == false:
		await get_tree().create_timer(0.2).timeout
		can_jump = true
	if is_on_floor() and can_double_jump == false:
		await get_tree().create_timer(0.2).timeout
		can_double_jump = true
