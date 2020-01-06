extends KinematicBody2D

const GRAVITY = 10
var SPEED = 100
const MOV = Vector2(0,-1)

var cont = 0
var vel = Vector2()
var dir = 1

var is_dead = false

func dead():
	is_dead = true
	vel = Vector2(0,0)
	$shape.disabled = true
	cont = 0

func _physics_process(delta):
	if cont == 0:
		SPEED = 0
		$animesqueleto.play("morrendo")
		$shape.disabled = true
	elif cont == 1:
		SPEED = 0
		$animesqueleto.play("nascendo")
		$shape.disabled = false
	elif cont == 2:
		$shape.disabled = false
		SPEED = 100
		$animesqueleto.play("andando")
		vel.x = SPEED * dir
		if dir == 1:
			$animesqueleto.flip_h = true
		else:
			$animesqueleto.flip_h = false
			
	vel = move_and_slide(vel,MOV)
	
	if is_on_wall():
		dir = dir * -1

func _on_radar_body_entered(body):
	if body.get_name() == "jogador" and cont != 2:
		cont = 1
		get_node("Timer").start()

func _on_Timer_timeout():
	cont = 2
	
