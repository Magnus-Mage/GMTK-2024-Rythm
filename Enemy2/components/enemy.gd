class_name Enemy
extends Area2D
signal death
'''
Set Target
	Set exported "target" below via Editor or setting the variable before adding as child.

How to damage:
	Enemy is an Area2D node, define _on_body_entered() below to check if the body entered is of class
	Player and call the Player's function damage(), or if its a Hazard and call the damage() func below.

Disable enemy by:
	Setting "target" variable to null.
'''

@export_category("External")
@export var target: Node2D

@export_group("Properties")
@export var _health := 100
@export var _speed := 100
@export var _range: float = 250

@export_group("Nodes")
@export var _nav_agent_2d: NavigationAgent2D
@export var _animation_player: AnimationPlayer

const DECELERATION := 0.2

var _direction: Vector2
var _velocity := Vector2.ZERO
var _state_func: Callable # Called in _physics_process


func _ready() -> void:
	connect("body_entered", _on_body_entered)
	_state_func = _move_to_target

func _physics_process(delta: float) -> void:
	if not target: return
	
	_direction = Vector2.ZERO
	_seek_target()
	
	_state_func.call()
	
	if not _direction: _decelerate()
		
	global_position += _velocity * delta

func damage(amount: int) -> void:
	_health -= amount
	
	if _health <= 0:
		# TODO: Animation death etc.
		death.emit()
		queue_free()

func _seek_target() -> void:
	await get_tree().physics_frame
	_nav_agent_2d.target_position = target.global_position

func _decelerate() -> void:
	_velocity = _velocity.slerp(Vector2.ZERO, DECELERATION)

# STATE FUNCTIONS
# Override to give unique abilities
func _move_to_target() -> void:
	if not target: return
	
	if _nav_agent_2d.distance_to_target() > _range:
		_direction = global_position.direction_to(_nav_agent_2d.get_next_path_position())
		_velocity = _direction * _speed
	else:
		_state_func = _attack

func _attack() -> void:
	
	# Perform Attack
	
	if _nav_agent_2d.distance_to_target() > _range:
		_state_func = _move_to_target

# SIGNAL HANDLERS
func _on_body_entered(body: Node2D) -> void: pass
	#TODO:
	# if body is Player / or / if body body.is_in_group("Player")
	# Player.damage()
	# if body is PlayerProjectile / or / if body body.is_in_group("PlayerProjectile")
	# 
