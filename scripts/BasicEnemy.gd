extends KinematicBody2D

var is_moving_left = true

var gravity = 10
var velocity = Vector2.ZERO
onready var raycast = $RayCast2D
onready var anim_player= $AnimationPlayer
onready var Attack = $AttackDetector
var speed = 100

#func _process(_delta):
#	move_character()
#	detect_turn_around()
func move_character():
	if is_moving_left:
		velocity.x = -speed
	else: velocity.x = speed 
	velocity .y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
func hit():
	Attack.monitoring = true
func end_of_hit():
	Attack.monitoring = false
func _on_PlayerDetector_body_entered(body):
	anim_player.play("Swing")
	
func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()


	
	


