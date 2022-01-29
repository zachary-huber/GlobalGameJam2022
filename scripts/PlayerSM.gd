extends "res://scripts/StateMachine.gd"
func _ready():
	add_state("idle")
	add_state("move")
	add_state("jump")
	call_deferred("set_state", states.idle)

func _input(event):
	if [states.idle, states.move].has(state):
		if event.is_action_pressed("ui_up") && parent._check_is_grounded():
			parent.velocity.y = parent.jump_speed

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()
func _get_transition(delta):
	match state:
		states.idle:
			if !parent._check_is_grounded():
					if parent.velocity.y < 0 or parent.velocity.y > 0:
						return states.jump
			elif parent.velocity.x != 0:
				return states.move
		states.move:
			if !parent._check_is_grounded():
					if parent.velocity.y < 0 or parent.velocity.y > 0:
						return states.jump
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent._check_is_grounded():
				return states.idle
	return null

func _enter_state(new_state, old_state):
	print(new_state)
	match new_state:
		states.idle:
			parent.anim_player.play("idle")
		states.move:
			parent.anim_player.play("move")
		states.jump:
			parent.anim_player.play("jump")
	
func _exit_state(old_state, new_state):
	pass

