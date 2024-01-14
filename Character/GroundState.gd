extends CharacterState

class_name GroundState

@export var jump: String
@export var air_state : State
@export var hanging_state: State 
@export var attack_state: State 
@export var SwordScene : PackedScene
var overlapping_bodies: Array
var sword: Sword

func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state

func state_input(event : InputEvent):
	if event.is_action_pressed(character.jump):
		state_machine.switch_states(air_state, {do_jump = true})
	if event.is_action_pressed(character.attack) && state_machine.has_sword:
		next_state = attack_state
	if event.is_action_pressed(character.throw):
		if state_machine.has_sword:
			print("throw")
			character.throw_sword()
		else:
			print("warp")
			character.warp()
	
