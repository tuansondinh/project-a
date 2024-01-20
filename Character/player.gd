extends CharacterBody2D

class_name Player
@export var player_number: int
@export var move_right: String
@export var move_left: String
@export var move_up: String
@export var move_down: String
@export var jump: String
@export var attack: String
@export var throw: String
@export var speed : float = 200.0
@export var hanging_state: HangingState
@export var dead_state: DeadState
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@export var SwordScene : PackedScene
@export var char_col_shape: CollisionShape2D
@export var air_state: AirState
@onready var sword: Sword

signal died

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var test: bool = true

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	direction = Input.get_vector(move_left, move_right, move_up, move_down)

	if direction.x != 0:
		state_machine.face_dir = round(direction.x)
	# Control whether to move or not to move
	if direction.x != 0 and (not is_on_wall() or not Input.is_action_just_pressed(jump)) and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
		
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func handle_throw():
	if state_machine.has_sword:
			if state_machine.current_state.can_throw:
				throw_sword()
				state_machine.handle_throw_cool_down()
	else:
		warp()
	
func throw_sword():
	state_machine.has_sword = false
	sword = SwordScene.instantiate()
	owner.add_child(sword)
	sword.transform = $Muzzle.global_transform
	sword.face_dir = state_machine.face_dir
	sword.player = self

func warp():
	var char_col_shape: CollisionShape2D = $CollisionShape2D
	var char_height = char_col_shape.shape.height
	state_machine.has_sword = true
	sword = owner.get_node("Sword")
	position.x = sword.position.x
	if sword.position.y < char_height:
		position.y = sword.position.y
		if sword.entered:
			state_machine.switch_states(hanging_state, {"sword": sword})
		else:
			sword.queue_free()
	else:
		sword.queue_free()

func die():
	state_machine.switch_states(dead_state, {})
	emit_signal("died", self)
	
func revive(): 
	await get_tree().create_timer(1).timeout
	state_machine.switch_states(air_state, {"do_revive": true})
	set_collision_layer_value(1, true)
	set_collision_layer_value(32, false)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, false)
	visible = true
	teleport_random_location()

func teleport_random_location():
	# Define the space in which you want to teleport the object
	var min_x = -50  # Adjust these values based on your requirements
	var max_x = 50
	var min_y = -100
	var max_y = 50  # Adjust these values based on your requirements

	var rng = RandomNumberGenerator.new()
	var new_x = rng.randf_range(min_x, max_x)
	# Generate random coordinates within the defined space
	var new_y = rng.randf_range(min_y, max_y)
	position = Vector2(new_x, new_y)
