extends CanvasLayer

var current_health

func _ready():
	get_node("Hp").max_value = Game.Player_MAX_HP
	get_node("Hp").value = Game.Player_HP
	
func _physics_process(delta):
	if current_health != Game.Player_HP:
		get_node("Hp/Tween").interpolate_property(get_node("Hp"), "value", current_health, Game.Player_HP, 0.5)
		get_node("Hp/Tween").start()
	current_health = Game.Player_HP
	get_node("Hp").value = Game.Player_HP
