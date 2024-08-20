extends Enemy


@export_group("Unique Properties")
@export var _dash_speed := 300
@export var _dash_duration := 1

var _is_dashing := false


func _physics_process(delta: float) -> void:
	if not _player: return
	
	_direction = Vector2.ZERO
	_seek_target()
	
	_state_func.call()
	
	if not _is_dashing and not _direction: _decelerate()
		
	global_position += _velocity * delta

# STATE FUNCTIONS
func _attack() -> void:
	_animation_player.play("Charge")
	await _animation_player.animation_finished
	_animation_player.stop()
	_animation_player.play("RESET")
	_direction = global_position.direction_to(_nav_agent_2d.get_next_path_position())
	_velocity = _direction * _dash_speed
	
	_state_func = _dash
	
func _dash() -> void:
	if _is_dashing: return
	else:
		_is_dashing = true
		
	var tween := create_tween()
	tween.tween_property(self, "_velocity", Vector2.ZERO, _dash_duration)
	await tween.finished
	
	_animation_player.play("Idle")
	_is_dashing = false
	_state_func = _move_to_target
