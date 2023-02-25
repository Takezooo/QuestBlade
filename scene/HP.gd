extends Label


func _process(delta):
	self.text = str(Game.Player_HP) + "/" + str(Game.Player_MAX_HP)
