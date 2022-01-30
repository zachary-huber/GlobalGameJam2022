extends "res://scripts/StateMachine.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_state("move")
	add_state("Swing")
	call_deferred("set_state", states.move)
func _state_logic(delta):
	if state == states.move:
		parent.move_character()
		parent.detect_turn_around()
	else:
		return
	

func _get_transition(delta):
	match state:
		states.move:
			if parent.anim_player.current_animation == "Swing":
				return states.Swing
		states.Swing:
			if !parent.anim_player.is_playing():
				return states.move
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.move:
			parent.anim_player.play("move")
		states.Swing:
			parent.anim_player.play("Swing")
	
func _exit_state(old_state, new_state):
	pass
