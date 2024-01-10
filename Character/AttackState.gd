extends State

class_name AttackState


@export var jump_velocity : float = -150.0
@export var air_state : State
@export var hanging_state : State
@onready var ground_state: State = get_parent().get_node("Ground")
@export var jump_animation : String = "jump_start"
@export var Sword : PackedScene
@onready var sword : Area2D = Sword.instantiate()
@onready var sword_anim_player: AnimationPlayer = sword.get_node("AnimationPlayer")
func state_process(delta):
	pass


func on_enter(_msg := {}) -> void:

	owner.add_child(sword)

	sword_anim_player.play("swing")
	next_state = ground_state
