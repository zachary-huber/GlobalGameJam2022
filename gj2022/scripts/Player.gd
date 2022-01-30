extends KinematicBody2D
export (float, 0 , 1.0) var friction = 0.1
export (float, 0 , 1.0) var acceleration = 0.25
export (int) var speed = 1200
export (int) var jump_speed = -500
export (int) var gravity = 1200

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	elif Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0 :
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, acceleration)
		
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
