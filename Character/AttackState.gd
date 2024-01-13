extends CharacterState

class_name AttackState


@export var jump_velocity : float = -150.0
@export var air_state : State
@export var hanging_state : State
@onready var ground_state: State = get_parent().get_node("Ground")
@export var jump_animation : String = "jump_start"
@export var Sword : PackedScene
@export var sword : Sword
var sword_anim_player: AnimationPlayer
func state_process(delta):
	pass


func on_enter(_msg := {}) -> void:
	var node: Node2D = Node2D.new()
	sword = Sword.instantiate()
	node.add_child(sword)

	character.add_child(node)
	sword_anim_player = sword.get_node("AnimationPlayer")
	if state_machine.face_dir == -1:
		#character.scale.x = -1
		node.scale.x = -1

	sword_anim_player.play("swing")
	await sword_anim_player.animation_finished
	sword.queue_free()
	if !character.is_on_floor() :
		next_state = air_state
	else:
		next_state  = ground_state

	#next_state = ground_state
