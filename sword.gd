extends Area2D
class_name Sword

@export var speed = 750
@onready var state_machine : WeaponStateMachine = $WeaponStateMachine
var entered = false

func _physics_process(delta):
	if not entered:
		position += transform.x * speed * delta
	

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

