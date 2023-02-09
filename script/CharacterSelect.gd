extends Node2D

func _process(delta):
	
	var gender = ButtonGroup.new()
	$Boy_CheckBox.set_button_group(gender)
	$Girl_CheckBox.set_button_group(gender)
	
	if Game.Gender == 0:
		match Game.PlayerSelected:
			0:
				get_node("PlayerSelect").play("Boy0")
			1:
				get_node("PlayerSelect").play("Boy1")
			2:
				get_node("PlayerSelect").play("Boy2")
			3:
				get_node("PlayerSelect").play("Boy3")
	else:
		match Game.PlayerSelected:
			0:
				get_node("PlayerSelect").play("Girl0")
			1:
				get_node("PlayerSelect").play("Girl1")
			2:
				get_node("PlayerSelect").play("Girl2")
			3:
				get_node("PlayerSelect").play("Girl3")
	
func _on_Left_Btn_pressed():
	if Game.PlayerSelected > 0:
		Game.PlayerSelected -= 1
	else:
		Game.PlayerSelected = 0

func _on_Right_Btn_pressed():
	if Game.PlayerSelected < 4:
		Game.PlayerSelected += 1
	else:
		Game.PlayerSelected = 3

func _on_Boy_CheckBox_toggled(button_pressed):
	if Game.Gender > 0:
		Game.Gender -= 1
		Game.PlayerSelected = 0
			
func _on_Girl_CheckBox_toggled(button_pressed):
	if Game.Gender < 1:
		Game.Gender += 1
		Game.PlayerSelected = 0

func _on_Select_Btn_pressed():
	get_tree().change_scene("res://scene/World.tscn")
	Game.FirstLaunch = true
	Utils.save_game()
