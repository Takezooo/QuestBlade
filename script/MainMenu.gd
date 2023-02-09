extends Node2D

func _ready():
	Utils.load_game()

func _on_Play_Btn_pressed():
	if Game.FirstLaunch == false:
		get_tree().change_scene("res://scene/CharacterSelect.tscn")
	else: 
		get_tree().change_scene("res://scene/World.tscn")
