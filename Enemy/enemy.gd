extends CharacterBody2D


@export var movement_speed = 20.0
@export var hp = 10
@export var knockback_recovery = 3.5
@export var experience = 1
@export var enemy_damage = 1
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var snd_hit = $snd_hit
@onready var hitBox = $HitBox

var death_anim = preload("res://Enemy/explosion.tscn")
var exp_gem = preload("res://Objects/experience_gem.tscn")

signal remove_from_array(object)

func _ready():
	anim.play("walk")
	hitBox.damage = enemy_damage
	# Connect to the player's level-up signal
	if player:
		player.connect("level_up", Callable(self, "_on_player_level_up"))
	# Apply scaling to this enemy
	apply_scaling()

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false

func death():
	emit_signal("remove_from_array", self)
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale
	enemy_death.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()

# Function to handle player level-up
func _on_player_level_up(new_level):
	# Apply scaling to this enemy
	apply_scaling()

func apply_scaling():
	# Adjust the size and hitbox proportionally to the player's level
	var scale_factor = 1.0 + (player.experience_level - 1) * 0.2  # Adjust the multiplier as needed
	sprite.scale = Vector2(scale_factor, scale_factor)
	hitBox.scale = Vector2(scale_factor, scale_factor)
