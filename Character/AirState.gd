extends CharacterState

class_name AirState

@export var ground_state : State
@export var hanging_state : State
@export var attack_state  : State
@export var jump_velocity : float = -150.0
@export var jump_animation : String = "jump_start"
@export var landing_animation : String = "jump_end"
@export var wall_jump_velocity : float = -100
@export var double_jump_animation : String = "double_jump"
@export var push_back_velocity: float = 3000
@export var Sword : PackedScene
var sword: Sword
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var no_jump: bool = false

func state_process(delta):
	character.velocity.y += gravity * delta
	if character.is_on_floor():
		next_state = ground_state
	#wall_slide(delta)
		
func state_input(event : InputEvent):
	if event.is_action_pressed(character.jump) && character.is_on_wall():
		character.velocity.y = wall_jump_velocity
		if state_machine.face_dir == 1:
			character.velocity.x = -push_back_velocity
		else:
			character.velocity.x = push_back_velocity

	if event.is_action_pressed(character.throw):
		character.handle_throw()
	if event.is_action_pressed(character.attack) && state_machine.check_if_can_attack():
		next_state = attack_state
	
		
func wall_slide(delta):
	if character.is_on_wall():
		gravity = 100
	else:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	

func on_enter(msg:= {}):
	if msg.has("do_jump"):
		print("jumping")
		character.velocity.y = jump_velocity
		playback.travel(jump_animation)
	elif msg.has("do_revive"):
		can_move = true
		
		
func on_exit():
	pass
