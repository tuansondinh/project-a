extends StateMachine

class_name CharacterStateMachine

## not sure if these extra attributes should be here or in player.gd
@export var face_dir: int = 1
@export var has_sword: bool = true
@export var is_dead: bool = false

func _ready():
	for child in get_children():
		if(child is CharacterState):
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
