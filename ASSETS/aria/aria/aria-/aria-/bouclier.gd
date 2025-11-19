extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0
var direction = Input.get_axis("Gauche", "droite")
var droite = Input.is_action_pressed("droite")
var gauche = Input.is_action_pressed("Gauche")
var état = 0
var can_dash = true
