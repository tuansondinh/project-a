extends Area2D
class_name Sword

@export var speed = 750
@onready var collision_shape: CollisionPolygon2D = $CollisionPolygon2D
var entered = false
var face_dir: int

func _physics_process(delta):
	#print(face_dir)
	if not entered:
		if face_dir == 1:
			position += transform.x * speed * delta
		elif face_dir == -1:
			position -= transform.x * speed * delta
	

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
	print(body)


func _on_area_entered(area):
	print(area)
	pass # Replace with function body.


func _on_body_entered(body):
	print(body)
	if body is TileMap: 
		entered = true


