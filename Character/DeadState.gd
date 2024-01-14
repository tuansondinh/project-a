extends CharacterState

class_name DeadState

var sword_anim_player: AnimationPlayer
func state_process(delta):
	pass


func on_enter(_msg := {}) -> void:
	can_move = false
	# player dead anim
