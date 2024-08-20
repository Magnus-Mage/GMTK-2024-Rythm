class_name PlayerProjectile
extends Area2D
'''
This is just an example that calls an Enemy's damage()
'''


const LIFESPAN := 6 # Seconds

@export var _damage := 20
@export var _speed := 300

var direction: Vector2


func _ready() -> void:
	connect("area_entered", _on_area_entered)
	assert(direction, "Direction must be set before instantiating projectile.")
	
	get_tree().create_timer(LIFESPAN).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	global_position += direction * _speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		var enemy: Enemy = area
		enemy.damage(_damage)
		queue_free()
