extends Enemy

@export_group("Scenes")
@export var _laser_beam_scene: PackedScene

@export_group("Unique Properties")
@export var _cooldown_time := 5 # Seconds
@export var _max_close_range := 200

var _is_rested := true
var _is_attacking := false


# STATE FUNCTIONS
func _attack() -> void:
	if not _is_rested or _is_attacking: return
	else:
		_is_rested = false
		_is_attacking = true
	
	_animation_player.play("Charge")
	await _animation_player.animation_finished
	_animation_player.stop()
	_animation_player.play("Idle")
	
	var laser_beam: LaserBeam = _laser_beam_scene.instantiate()
	laser_beam.global_position = global_position
	laser_beam.target_position = _nav_agent_2d.target_position
	get_parent().add_child(laser_beam)
	await laser_beam.laser_ended
	
	_is_attacking = false
	
	get_tree().create_timer(_cooldown_time).timeout.connect(func rest_complete(): _is_rested = true)
	
	if _nav_agent_2d.distance_to_target() > _range:
		_state_func = _move_to_target
	elif _nav_agent_2d.distance_to_target() < _max_close_range:
		_state_func = _move_away
		
func _move_away() -> void:
	_direction = -global_position.direction_to(_nav_agent_2d.get_next_path_position())
	_velocity = _direction * _speed
	
	if _nav_agent_2d.distance_to_target() > _range:
		_state_func = _move_to_target
	
