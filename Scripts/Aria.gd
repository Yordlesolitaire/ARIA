extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


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

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	#gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#move
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_left")
	velocity.x = dir.x * SPEED
	$LineEdit.text = str(dir)
	move_and_slide()
