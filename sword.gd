extends Area2D
class_name Sword

@export var speed = 750
@onready var collision_shape: CollisionPolygon2D = $CollisionPolygon2D
@onready var sprite: Sprite2D = $Sprite2D

# player which owns the sword
var player: Player
# is sword collided in wall
var entered: bool = false
# is being set from outsite
var face_dir: int
	

func _physics_process(delta):
	if not entered:
		if face_dir == 1:
			position += transform.x * speed * delta
		elif face_dir == -1:
			sprite.flip_h = true
			position -= transform.x * speed * delta
	
func _on_body_entered(body):
	print("sword.gd, body:", body)
	## collision with Map
	if body is TileMap: 
		entered = true
	## player pick up sword
	elif body is Player and entered:
		## TODO need to check that it's the right player
		if not body.state_machine.current_state is HangingState:
			body.state_machine.has_sword = true
			queue_free()
	elif body is Player and !entered and (body as Player).player_number != player.player_number:
		body.queue_free()
