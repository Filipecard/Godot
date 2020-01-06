extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
var GRAVITY = 20
var JUMP_HEIGHT = -600
const ACELERACAO = 50
var MAX_SPEED = 200
const MAX_SUBIDA = 400
const MAX_DESCIDA = 200
const FIREBALL = preload("res://Scenes/fire_ball.tscn")
var nadar = false
var contador = 0
var morto = false

func _physics_process(delta):
	if morto == false:
		if nadar == true:
			$Sprite.play("nadando")
			JUMP_HEIGHT = -500
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
		else:
			JUMP_HEIGHT - 600
		
		motion.y += GRAVITY
		var friction = false
		
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACELERACAO , MAX_SPEED)
			$Sprite.flip_h = false
			if motion.y == 0 and nadar != true :
				MAX_SPEED= 230
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_v")
					motion.x = 0.1
				else:
					$Sprite.play("voando")
			elif nadar == true:
				MAX_SPEED = 230
				$Sprite.play("nadando")
			else:
				MAX_SPEED = 200
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_a")
					motion.x = 0.1
				else:
					$Sprite.play("andando")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
				
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACELERACAO , -MAX_SPEED)
			$Sprite.flip_h = true
			if motion.y == 0 and nadar != true:
				MAX_SPEED = 230
				if Input.is_action_pressed("fly")and nadar != true:
					$Sprite.play("atirando_v")
					motion.x = 0.1
				else:
					$Sprite.play("voando")
			elif nadar == true:
				MAX_SPEED = 230
				$Sprite.play("nadando")
			else:
				MAX_SPEED = 200
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_a")
					motion.x = 0.1
				else:
					$Sprite.play("andando")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
				
		else:
			if motion.y == 0 and nadar != true:
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_v")
					motion.x = 0.1
				else:
					motion.x = 0.1
					$Sprite.play("voando")
			else:
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_a")
					motion.x = 0.1
				elif nadar == true:
					$Sprite.play("nadando_idle")
					motion.x = 0.1
				else:
					$Sprite.play("parado")
				if motion.y == 0 and Input.is_action_just_pressed("ui_up"):
					$Sprite.play("voando")
					motion.x = 0.1
			
			friction = true 		
			
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x , 0, 0.2)
			if Input.is_action_pressed("fly") and nadar != true:
				$Sprite.play("atirando_a")
				motion.x = 0.1
		else:
			if motion.y < 0 and nadar != true:
				if Input.is_action_just_pressed("ui_up"):
					motion.y = 0
					GRAVITY = 0
				if Input.is_action_pressed("fly") and nadar != true:
					$Sprite.play("atirando_a")
					motion.x = 0.1
				else:
					$Sprite.play("pulando")
					
			elif motion.y > 0 and nadar != true:
				if Input.is_action_just_pressed("ui_up"):
					motion.y = 0
					GRAVITY = 0
				if Input.is_action_just_pressed("fly") and nadar != true:
					$Sprite.play("atirando_a")
					motion.x = 0.1
				else:
					$Sprite.play("caindo")
			else:
				if Input.is_action_just_pressed("ui_down"):
					$Sprite.play("caindo2")
					motion.y += GRAVITY 
					GRAVITY = 20
				if Input.is_action_just_pressed("fly") and nadar != true:
					$Sprite.play("atirando_v")
	
		
		if Input.is_action_just_pressed("fly") and nadar != true and contador < 1:
			contador += 1
			$Sprite.play("atirando_a")
			motion.x = 0.1
			var fireball = FIREBALL.instance()
			
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_drection(1)
			else:
				fireball.set_fireball_drection(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
			if contador == 1:
				$tempo_fogo.start()
	elif morto == true:
		motion = Vector2(0,0)
		if nadar == true:
			$Sprite.play("morrendo_a")
		else:
			$Sprite.play("morrendo")
		
		
	motion = move_and_slide(motion,UP)

func _on_agua2_body_entered(body):
	if body.get_name() == "jogador":
		nadar = true


func _on_agua2_body_exited(body):
	if body.get_name() == "jogador":
		nadar = false
	JUMP_HEIGHT = - 600

func _on_tempo_fogo_timeout():
	contador = 0


func _on_colisao_body_entered(body):
	if body.get_name() == "esqueleto":
		morto = true
		$tempo_morto.start()
	if body.get_name() == "spike":
		morto = true
		$tempo_morto.start()

func _on_morto_timeout():
	morto = false
	position.x = -262
	position.y = 126

	
