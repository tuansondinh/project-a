extends CharacterBody2D

@export var speed : float = 200.0
@export var Sword : PackedScene

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

@onready var sword: Area2D =  $Sword


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0:
		state_machine.face_dir = direction.x
	# Control whether to move or not to move
	if direction.x != 0 && state_machine.check_if_can_move():

		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
		
	
	#if Input.is_action_just_pressed("ui_down"):
	#	position.x = sword.position.x
	#	if is_on_floor():
	#		owner.remove_child(sword)
	#	else:
	#		position.y = sword.position.y
	#		is_hanging = true
	#		velocity.y = 0

		
	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
