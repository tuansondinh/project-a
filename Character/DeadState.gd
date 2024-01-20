extends CharacterState 

class_name DeadState

var sword_anim_player: AnimationPlayer

func state_process(delta):
	pass


func on_enter(_msg := {}) -> void:
	can_move = false
	can_attack = false
	can_throw = false
	character.set_collision_layer_value(1, false)
	character.set_collision_layer_value(32, true)
	character.set_collision_mask_value(1, false)
	# need following, otherwise falls through floor
	character.set_collision_mask_value(2, true)
	character.visible = false
	# player dead anim
