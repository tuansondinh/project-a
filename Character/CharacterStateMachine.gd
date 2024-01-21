extends Node
class_name CharacterStateMachine

## need to hold some attributes here instead of in state because of "parallel states"
var face_dir: int = 1
var has_sword: bool = true
var can_throw: bool = true
var can_attack:bool = true
@export var warp_cool_down_timer: Timer
@export var attack_cool_down_timer: Timer
@export var animation_tree : AnimationTree
@export var current_state : CharacterState
@export var character : Player
var states : Array[CharacterState]

func _ready():
	for child in get_children():
		if child is CharacterState:
			states.append(child)
			child.state_machine = self
			# Set the states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _physics_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move


func switch_states(new_state : State, msg: Dictionary = {}):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter(msg)

func _input(event : InputEvent):
	current_state.state_input(event)

func check_if_can_attack():
	return can_attack && has_sword
	
func _on_warp_cooldown_timer_timeout():
	can_throw = true 
	
func handle_throw_cool_down():
	warp_cool_down_timer.start()
	can_throw = false

func _on_attack_cooldown_timer_timeout():
	can_attack = true

func handle_attack_cool_down():
	attack_cool_down_timer.start()
	can_attack = false
	

