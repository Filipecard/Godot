extends Button

func _pressed():
	var node = get_node("../volume_slider")
	if(name == 'min'):
		node.set_value(node.get_value() - node.step)
	else:
		node.set_value(node.get_value() + node.step)
		
	var dbValue = node.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(get_node("../").name),dbValue)
	get_node("../AudioStreamPlayer2D").play()