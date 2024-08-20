class_name Projectile
extends Area2D


const LIFESPAN := 6 # Seconds

@export var _speed := 300

var direction: Vector2


func _ready() -> void:
	connect("body_entered", _on_body_entered)
	assert(direction, "Direction must be set before instantiating projectile.")
	
	get_tree().create_timer(LIFESPAN).timeout.connect(queue_free)
	
func _physics_process(delta: float) -> void:
	global_position += direction * _speed * delta

func _on_body_entered(body: Node2D) -> void: pass
	#TODO:
	#if body is Player / or / if body body.is_in_group("Player")
	#damage Player
