extends Area2D
var mode = 0
var rs_look = Vector2(0,0)
var deadzone = 0.3
var direction = Vector2()
var screen_size = get_viewport_rect().size
# Called when the node enters the scene tree for the first time.



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hide()
	if Input.is_action_just_pressed("mode"):
		if mode == 0:
			mode = 1
		elif mode == 1:
			mode = 0
	if Input.is_action_pressed("viser_bouclier") and mode==0 and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		show()
		position = get_global_mouse_position()
	if Input.is_action_pressed("viser_bouclier") and mode==0 and not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		show()
		if Input.is_action_pressed("aim_up"):
			position.y -= 5
		if Input.is_action_pressed("aim_down"):
			position.y += 5
		if Input.is_action_pressed("aim_right"):
			position.x += 5
		if Input.is_action_pressed("aim_left"):
			position.x -= 5
		if Input.is_action_pressed("aim_up") and Input.is_action_pressed("aim_right") :
			position.y -= 1
			position.x += 1
		if Input.is_action_pressed("aim_down") and Input.is_action_pressed("aim_right") :
			position.y += 1
			position.x += 1
		if Input.is_action_pressed("aim_down") and Input.is_action_pressed("aim_left") :
			position.y += 1
			position.x -= 1
		if Input.is_action_pressed("aim_up") and Input.is_action_pressed("aim_left") :
			position.y -= 1
			position.x -= 1
		
