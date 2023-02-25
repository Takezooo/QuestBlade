extends KinematicBody2D

const acc = 25
const friction = 80
const walk_speed = 70
const run_speed = 120

var motion = Vector2()
var max_speed = walk_speed
var is_running = null

onready var sword: Node2D = get_node("Sword")
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer" )
func _physics_process(delta):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	var input = Vector2()
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if Input.is_action_pressed("run"):
		is_running = true
	if Input.is_action_just_released("run"):
		is_running = false
	
	if input != Vector2.ZERO:

		if is_running == true:
			$AnimationTree.get("parameters/playback").travel("Run")
			show_Sprite("Walk")
			$AnimationTree.set("parameters/Run/blend_position", input)
			$AnimationTree.set("parameters/Idle/blend_position", input)
		else:
			$AnimationTree.get("parameters/playback").travel("Walk")
			show_Sprite("Walk")
			$AnimationTree.set("parameters/Walk/blend_position", input)
			$AnimationTree.set("parameters/Idle/blend_position", input)
			
		if is_running == true:
			max_speed = run_speed
		else:
			max_speed = walk_speed
			
		motion += input * acc * delta
		motion = motion.clamped(max_speed * delta)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		show_Sprite("Idle")
		motion = motion.move_toward(Vector2.ZERO, friction * delta)
	move_and_collide(motion)
	
	sword.rotation = mouse_direction.angle()
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")

func show_Sprite(sprite_name):
	get_node("Idle").hide()
	get_node("Walk").hide()
	
	match sprite_name:
		"Idle":
			get_node("Idle").show()	
		"Walk":
			get_node("Walk").show()
