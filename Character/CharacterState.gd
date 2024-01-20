extends State

class_name CharacterState

@export var character: Player
@export var can_move: bool = true
@export var can_attack: bool = true
var state_machine: CharacterStateMachine

@export var muzzle: Marker2D

func state_process(delta) -> void:
	pass

func state_input(event : InputEvent) -> void:
	pass

func on_enter(_msg := {}) -> void:
	pass

func on_exit() ->void:
	pass
