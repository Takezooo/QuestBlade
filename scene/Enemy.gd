extends KinematicBody2D

var speed = 80
var see_player = false
var direction = Vector2()
var health = 10
var damage = 3
var knockback_dir = Vector2.ZERO
var knockback = Vector2.ZERO

func _ready():
	get_node("Hp").max_value = health
	get_node("Hp").value = health
	
func _physics_process(delta):
	get_node("Hp").value = health
	if health <=0 :
		queue_free()
	if see_player == true:
		var player = get_node("../Player")
		direction = (player.position - position).normalized()

		$AnimationTree.get("parameters/playback").travel("WALK")
		$AnimationTree.set("parameters/IDLE/blend_position", direction)
		$AnimationTree.set("parameters/WALK/blend_position", direction)
		
		move_and_slide(speed*direction)
		
	else: 
		$AnimationTree.get("parameters/playback").travel("IDLE")
	knockback_dir = direction
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)
	
func _on_detection_area_body_entered(body):
	if body.name == "Player":
		see_player = true

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		see_player = false
