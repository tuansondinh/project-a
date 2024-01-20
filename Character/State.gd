extends Node

class_name State

var playback : AnimationNodeStateMachinePlayback
var next_state : State

func state_process(delta) -> void:
	pass

func state_input(event : InputEvent) -> void:
	pass

func on_enter(_msg := {}) -> void:
	pass

func on_exit() ->void:
	pass
	
