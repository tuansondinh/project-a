extends Node

class_name WeaponStateMachine

@export var weapon: Area2D
@export var animation_tree : AnimationTree
@export var current_state : State


var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			child.state_machine = self
			# Set the states up with what they need to function
#			child.weapon = weapon
			#child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")


