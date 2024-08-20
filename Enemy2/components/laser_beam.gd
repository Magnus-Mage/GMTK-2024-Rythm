class_name LaserBeam
extends Area2D
signal laser_ended

@export_group("Properties")
@export var _speed := 300
@export var _fire_duration := 3 # Seconds

@export_group("Nodes")
@export var _animation_player: AnimationPlayer

var target_position: Vector2


func _ready() -> void:
	connect("body_entered", _on_body_entered)
	assert(target_position, "target_position must be set before instantiating projectile.")

	look_at(target_position)
	
	_animation_player.play("shoot")
	await _animation_player.animation_finished
	await get_tree().create_timer(_fire_duration)
	laser_ended.emit()
	queue_free()

func _on_body_entered(body: Node2D) -> void: pass
	#TODO:
	#if body is Player / or / if body body.is_in_group("Player")
	#damage Player
