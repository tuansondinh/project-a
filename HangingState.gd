extends CharacterState


class_name HangingState

@export var air_state : State
@export var jump_velocity : float = -150.0
@export var jump_animation : String = "jump_start"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

func state_process(delta):
	character.velocity.y = 0
	# no gravity
	pass
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	can_move = true
	character.is_hanging = false
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func on_enter(_msg := {}) -> void:
	print("jo")
	playback.travel("jump_end")
	can_move = false	

func on_exit():
	pass