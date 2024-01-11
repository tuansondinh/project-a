extends CharacterState

class_name GroundState


@onready var air_state : State = get_parent().get_node("Air")
@onready var hanging_state : State = get_parent().get_node("Hanging")
@onready var attack_state: State = get_parent().get_node("Attack")
@export var SwordScene : PackedScene
var overlapping_bodies: Array
var sword: Sword

func state_process(delta):
	if sword != null:
		#print(sword.get_overlapping_bodies())
		pass
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	var muzzle: Marker2D = character.get_node("Muzzle")
	var level = character.owner
	var char_col_shape: CollisionShape2D = character.get_node("CollisionShape2D")
	var char_height = char_col_shape.shape.height

	if event.is_action_pressed("jump"):
		state_machine.switch_states(air_state, {do_jump = true})
	if event.is_action_pressed("ui_left"):
		next_state = attack_state
	if event.is_action_pressed("ui_right"):
		sword = SwordScene.instantiate()
		character.owner.add_child(sword)
		sword.transform = muzzle.global_transform
		sword.face_dir = state_machine.face_dir
		print(state_machine.face_dir)
	sword = level.get_node("Sword")
	if Input.is_action_just_pressed("ui_down"):
		character.position.x = sword.position.x
		if sword.position.y < char_height:
			character.position.y = sword.position.y
			next_state = state_machine.switch_states(hanging_state, {"sword": sword})
		else:
			sword.queue_free()
			


		
	
