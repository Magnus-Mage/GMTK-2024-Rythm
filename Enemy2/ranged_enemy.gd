extends Enemy

@export_group("Scenes")
@export var _projectile_scene: PackedScene

@export_group("Unique Properties")
@export var _rest_per_shot := 2 # Seconds
@export var _max_close_range := 200

var _is_attacking := false


# STATE FUNCTIONS
func _attack() -> void:
	if _is_attacking: return
	else: _is_attacking = true
	
	_animation_player.play("Charge")
	await _animation_player.animation_finished
	_animation_player.stop()
	_animation_player.play("Idle")
	_direction = global_position.direction_to(_nav_agent_2d.target_position)
	
	
	var projectile: Projectile = _projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.direction = _direction
	get_parent().add_child(projectile)
	
	await get_tree().create_timer(_rest_per_shot).timeout
	_is_attacking = false
	
	if _nav_agent_2d.distance_to_target() > _range:
		_state_func = _move_to_target
	elif _nav_agent_2d.distance_to_target() < _max_close_range:
		_state_func = _move_away
		
func _move_away() -> void:
	_direction = -global_position.direction_to(_nav_agent_2d.get_next_path_position())
	_velocity = _direction * _speed
	
	if _nav_agent_2d.distance_to_target() > _range:
		_state_func = _move_to_target
	
