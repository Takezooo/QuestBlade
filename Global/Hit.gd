extends Label

var travel = Vector2(0, -50)
var duration = 1
var spread = PI/2
var crit = false

func show_value(value):
	text = value
	rect_pivot_offset = rect_size / 4
	
	#Changing position/direction of travel
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	
	#Animate Position of Label
	get_node("Tween").interpolate_property(self, "rect_position", rect_position, rect_position+ movement, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	#Animate FadeOut
	get_node("Tween").interpolate_property(self, "modulate:a", 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	get_node("Tween").start()
	yield(get_node("Tween"), "tween_all_completed")
	queue_free()
