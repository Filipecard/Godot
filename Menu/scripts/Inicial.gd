extends Node

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")


func _on_Exit_pressed():
	get_tree().quit()
