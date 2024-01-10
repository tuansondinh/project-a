extends State

class_name WeaponState

@export var weapon: Area2D
@export var can_move: bool = true

func state_process(delta) -> void:
	pass

func state_input(event : InputEvent) -> void:
	pass

func on_enter(_msg := {}) -> void:
	pass

func on_exit() ->void:
	pass
