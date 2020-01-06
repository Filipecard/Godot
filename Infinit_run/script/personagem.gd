extends KinematicBody2D

var JUMP_HEIGHT = -400
var motion = Vector2()
const UP = Vector2(0,-1)
var GRAVITY = 20


func _physics_process(delta):
	
	motion.y += GRAVITY
	 
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		
	motion = move_and_slide(motion,UP)
	