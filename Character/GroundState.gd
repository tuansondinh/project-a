extends CharacterState

class_name GroundState


@onready var air_state : State = get_parent().get_node("Air")
@onready var hanging_state : State = get_parent().get_node("Hanging")
@onready var attack_state: State = get_parent().get_node("Attack")
@export var Sword : PackedScene
var sword: Area2D

func state_process(delta):
	
	if (character.is_hanging):
		next_state = hanging_state
	if(!character.is_on_floor()):
		next_state = air_state



func state_input(event : InputEvent):
	var muzzle: Marker2D = character.get_node("Muzzle")
	if event.is_action_pressed("jump"):
		state_machine.switch_states(air_state, {do_jump = true})
	if event.is_action_pressed("ui_left"):
		next_state = attack_state
	if event.is_action_pressed("ui_right"):
		sword = Sword.instantiate()
		character.owner.add_child(sword)
		sword.transform = muzzle.global_transform
	if Input.is_action_just_pressed("ui_down"):
	#	position.x = sword.position.x
		character.position.x = sword.position.x
		if not character.is_on_floor:
			character.position.y = sword.position.y
			next_state = hanging_state
		else:
			sword.queue_free()

		
	
