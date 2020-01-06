extends KinematicBody2D

var MAX_SPEED = 200
const ACELERACAO = 50
var JUMP_HEIGHT = -400
var motion = Vector2()
const UP = Vector2(0,-1)
var GRAVITY = 20


func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("direita"):
			motion.x = min(motion.x + ACELERACAO , MAX_SPEED)
	elif Input.is_action_pressed("esquerda"):
			motion.x = max(motion.x - ACELERACAO , -MAX_SPEED)
	
	if motion.x > 0:
		motion.x -= 4
	if motion.x < 0:
		motion.x += 4
	 
	if is_on_floor():
		if Input.is_action_just_pressed("cima"):
			motion.y = JUMP_HEIGHT
		
	motion = move_and_slide(motion,UP)
	