extends Node

var timer = 0
var t1 = 0.0
var t2 = 0.0
var morto_t1
var morto_t2
var start = false
var opcao

var player_um
var player_dois


func _physics_process(delta):
	timer = $time/timer
	if Input.is_action_just_pressed("ui_select"):
		get_tree().change_scene("res://scenes/game.tscn")
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		$start.hide()
		$time/timer.start()
		$start/timer_start.start()
		start = true
		
	if Input.is_action_just_pressed("ui_up") and start: 
		t2 = timer.wait_time - timer.time_left - 2
		player_dois = 4
	if Input.is_action_just_pressed("ui_down") and start: 
		t2 = timer.wait_time - timer.time_left - 2
		player_dois = 1
	if Input.is_action_just_pressed("ui_left") and start: 
		t2 = timer.wait_time - timer.time_left - 2
		player_dois = 2
	if Input.is_action_just_pressed("ui_right") and start: 
		t2 = timer.wait_time - timer.time_left - 2
		player_dois = 3
		
	if Input.is_action_just_pressed("cima") and start:
		t1 = timer.wait_time - timer.time_left - 2
		player_um = 4
	if Input.is_action_just_pressed("baixo") and start:
		t1 = timer.wait_time - timer.time_left - 2
		player_um = 1
	if Input.is_action_just_pressed("esquerda") and start:
		t1 = timer.wait_time - timer.time_left - 2
		player_um = 2
	if Input.is_action_just_pressed("direita") and start:
		t1 = timer.wait_time - timer.time_left - 2
		player_um = 3
	
	if t1 != 0 and t2 != 0:
		get_tree().paused = true
		start = false
		$time/timer.stop()
		$players/t1.text = str("%6f"%t1)
		$players/t2.text = str("%6f"%t2)
		is_dead(t1,t2,player_dois,player_um,opcao)


func is_dead(t1,t2,p2,p1,op):
	if t1 < t2 and p1 == op:
		morto_t1 = false
		morto_t2 = true
		condition(morto_t1,morto_t2)

	elif t2 < t1 and p2 == op:
		morto_t1 = true
		morto_t2 = false
		condition(morto_t1,morto_t2)

	elif t2 == t1 or (p1 != op and p2 != op):
		morto_t1 = true
		morto_t2 = true
		condition(morto_t1,morto_t2)

	elif t1 > t2 and p2 != op:
		morto_t1 = false
		morto_t2 = true
		condition(morto_t1,morto_t2)
	
	elif t2 > t1 and p1 != op:
		morto_t1 = true
		morto_t2 = false
		condition(morto_t1,morto_t2)

func show_option():
	randomize()
	return randi()%3+1

func _on_timer_start_timeout():
	opcao = show_option()
	if opcao == 1:
		$options/down.show()
	elif opcao == 2:
		$options/left.show()
	elif opcao == 3:
		$options/right.show()
	elif opcao == 4:
		$options/up.show()
		
func condition(m1,m2):
	if m1 == false and m2 == true:
		$players/winlose1.text = "win"
		$players/winlose2.text = "lose"
		$players/player2.modulate = "ff0000"
	if m1 == true and m2 == false:
		$players/winlose2.text = "win"
		$players/winlose1.text = "lose"
		$players/player1.modulate = "ff0000"
	if m1 == true and m2 == true:
		$players/player1.modulate = "ff0000"
		$players/player2.modulate = "ff0000"