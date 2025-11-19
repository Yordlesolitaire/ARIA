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
	$LineEdit.text = str(can_jump)
	move_and_slide()



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
	velocity.x = dir.x * SPEED
	if dir.x and is_on_floor():
		change_state("Move")
	else:
		if is_on_floor():
			change_state("Idle")

	if Input.is_action_just_pressed("ui_accept") and can_jump == true and is_on_floor():
		pass
		
	
	if is_on_floor() and can_jump == false:
		await get_tree().create_timer(0.2).timeout
		can_jump = true
	if is_on_floor() and can_double_jump == false:
		await get_tree().create_timer(0.2).timeout
		can_double_jump = true
