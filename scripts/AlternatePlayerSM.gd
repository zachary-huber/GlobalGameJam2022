extends "res://scripts/StateMachine.gd"

var active = false

func _ready():
	add_state("idle")
	add_state("move")
	add_state("jump")
	add_state("inactive")
	call_deferred("set_state", states.inactive)
	parent._pauseAndHide()
func _input(event):
	if [states.idle, states.move].has(state):
		if event.is_action_pressed("ui_up") && parent.is_on_floor():
			parent.velocity.y = parent.jump_speed
			
	if event.is_action_pressed("ui_accept"):
		if active == true:
			parent._pauseAndHide()
		else:
			parent.cam.make_current()
			parent._resume()
		active = !active
		
func _state_logic(delta):
	if state != states.inactive:
		parent._handle_move_input()
		parent._apply_gravity(delta)
		parent._apply_movement()
	else:
		return
func _get_transition(delta):
	match state:
		states.idle:
			if active != false:
				if !parent.is_on_floor():
						if parent.velocity.y < 0 or parent.velocity.y > 0:
							return states.jump
				elif parent.velocity.x != 0:
					return states.move
			return states.inactive
		states.move:
			if active != false:
				if !parent.is_on_floor():
						if parent.velocity.y < 0 or parent.velocity.y > 0:
							return states.jump
				elif parent.velocity.x == 0:
					return states.idle
			return states.inactive
		states.jump:
			if active != false:
				if parent.is_on_floor():
					return states.idle
			return states.inactive
		states.inactive:
			if active == true:
				return states.idle
	return null

func _enter_state(new_state, old_state):
	#print(new_state)
	match new_state:
		states.idle:
			parent.anim_player.play("idle")
		states.move:
			parent.anim_player.play("move")
		states.jump:
			parent.anim_player.play("jump")
		states.inactive:
			pass
	
func _exit_state(old_state, new_state):
	pass

