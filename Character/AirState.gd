extends CharacterState

class_name AirState

@export var landing_state : State
@export var hanging_state : State
@export var jump_velocity : float = -150.0
@export var jump_animation : String = "jump_start"
@export var landing_animation : String = "jump_end"
@export var double_jump_velocity : float = -100
@export var double_jump_animation : String = "double_jump"
@export var Sword : PackedScene
var sword: Sword
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

func state_process(delta):
	character.velocity.y += gravity * delta
	if(character.is_on_floor()):
		next_state = landing_state
		
func state_input(event : InputEvent):
	var muzzle: Marker2D = character.get_node("Muzzle")
	if(event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()
	if event.is_action_pressed("ui_right"):
		sword = Sword.instantiate()
		character.owner.add_child(sword)
		sword.transform = muzzle.global_transform
	if Input.is_action_just_pressed("ui_down"):
		print("bre")
	#	position.x = sword.position.x
		character.position.x = sword.position.x
		if not character.is_on_floor():
			print("brooo")
			character.position.y = sword.position.y
			print(sword.entered)
			if sword.entered:
				next_state = hanging_state
			else:
				sword.queue_free()

func on_enter(msg:= {}):
	if msg.has("do_jump"):
		character.velocity.y = jump_velocity
		playback.travel(jump_animation)
func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true
