extends KinematicBody2D

var speed = 80
var see_player = false
var direction = Vector2()

func _physics_process(delta):
	if see_player == true:
		var player = get_node("../Player")
		direction = (player.position - position).normalized()

		$AnimationTree.get("parameters/playback").travel("WALK")
		$AnimationTree.set("parameters/IDLE/blend_position", direction)
		$AnimationTree.set("parameters/WALK/blend_position", direction)
		
		move_and_slide(speed*direction)
		
	else: 
		$AnimationTree.get("parameters/playback").travel("IDLE")

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		see_player = true


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		see_player = false
