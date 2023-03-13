extends CanvasLayer

func _ready():
	get_node("Hp").max_value = Game.Player_MAX_HP
	get_node("Hp").value = Game.Player_HP
	
func _physics_process(delta):
	get_node("Hp").value = Game.Player_HP
