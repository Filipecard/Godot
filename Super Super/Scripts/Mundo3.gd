extends Node

var cont = 0
var contador = 0
var contador2 = 0
func _ready():
	get_node("jogador/ParallaxBackground2/ponto0").show()
	get_node("jogador/ParallaxBackground2/ponto1").hide()
	get_node("jogador/ParallaxBackground2/ponto2").hide()
	get_node("jogador/ParallaxBackground2/Label2").hide()
		

func _on_flamula1_body_entered(body):
	if body.get_name() == "jogador": 
		print("entrou")
		contador += 1
		if contador == 1:
			cont += 1
	if cont == 1:
		get_node("jogador/ParallaxBackground2/ponto0").hide()
		get_node("jogador/ParallaxBackground2/ponto1").show()
		get_node("jogador/ParallaxBackground2/ponto2").hide()
	elif cont == 2:
		get_node("jogador/ParallaxBackground2/ponto0").hide()
		get_node("jogador/ParallaxBackground2/ponto1").hide()
		get_node("jogador/ParallaxBackground2/ponto2").show()
		get_node("jogador/ParallaxBackground2/Label2").show()
		get_tree().change_scene("res://Scenes/Mundo.tscn")
	

func _on_flamula2_body_entered(body):
	if body.get_name() == "jogador": 
		contador2 += 1
		if contador2 == 1:
			cont += 1
	if cont == 1:
		get_node("jogador/ParallaxBackground2/ponto0").hide()
		get_node("jogador/ParallaxBackground2/ponto1").show()
		get_node("jogador/ParallaxBackground2/ponto2").hide()
	elif cont == 2:
		get_node("jogador/ParallaxBackground2/ponto0").hide()
		get_node("jogador/ParallaxBackground2/ponto1").hide()
		get_node("jogador/ParallaxBackground2/ponto2").show()
		get_node("jogador/ParallaxBackground2/Label2").show()
		get_tree().change_scene("res://Scenes/Mundo.tscn")