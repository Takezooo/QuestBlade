extends Node2D

func _ready():
	if Door.mainToCave:
		var door_node = find_node(Door.mainToCave)
		if door_node:
			$MainYSort/Player.position.x = 288
			$MainYSort/Player.position.y = 203
			
			
