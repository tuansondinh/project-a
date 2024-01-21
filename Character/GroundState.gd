extends CharacterState

class_name GroundState

@export var jump: String
@export var air_state : CharacterState
@export var hanging_state: CharacterState 
@export var attack_state: CharacterState 
@export var SwordScene : PackedScene
var overlapping_bodies: Array
var sword: Sword

func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state

func state_input(event : InputEvent):
	if event.is_action_pressed(character.jump):
		state_machine.switch_states(air_state, {do_jump = true})
	if event.is_action_pressed(character.attack) && state_machine.check_if_can_attack():
		state_machine.handle_attack_cool_down()
		next_state = attack_state
	if event.is_action_pressed(character.throw):
		character.handle_throw()
		
func on_enter(msg:= {}):
	playback.travel("Move")
	
