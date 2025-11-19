extends AnimatedSprite2D

var droite = Input.is_action_pressed("droite")
var gauche = Input.is_action_pressed("Gauche")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if droite:
		position.x = -16
		position.y = -10
	if gauche:
		position.x = 16
		position.y = -10
