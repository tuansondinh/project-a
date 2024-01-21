extends CharacterState
class_name HangingState

@export var air_state: CharacterState
@export var attack_state: CharacterState
@export var jump_velocity : float = -150.0
@export var jump_animation : String = "jump_start"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var sword : Sword

func state_process(delta):
	#fdgaprint(character.velocity.y)
	character.velocity.y = 0
	# no gravity
	pass
	
func state_input(event : InputEvent):
	if event.is_action_pressed(character.jump):
		jump()
	elif event.is_action_pressed(character.attack):
		next_state = attack_state
		
func jump():
	can_move = true
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)


func on_enter(msg := {}) -> void:
	print(msg)
	sword = msg.get("sword")
	playback.travel("jump_end")
	can_move = false	

func on_exit():
	sword.queue_free()
