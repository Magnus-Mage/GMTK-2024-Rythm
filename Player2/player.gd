class_name Player
extends CharacterBody2D


@export var _projectile_scene: PackedScene

const SPEED = 300.0
const DECELERATION = 0.2

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.lerp(Vector2.ZERO, DECELERATION)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("click"):
		var direction = global_position.direction_to(get_global_mouse_position())
		var projectile: PlayerProjectile = _projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.direction = direction
		get_parent().add_child(projectile)
		
