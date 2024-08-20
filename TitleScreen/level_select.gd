extends Control

const ZOOM_LIMIT = Vector2(8 , 8)
const ZOOM_SPEED = Vector2(0.08 , 0.08)

var scene_change = false
var zoom_done = false
var unlocked = 0
var zoom_position
var scene_load

@onready var cam = $Camera2D
@onready var button_lv_1 = $ButtonLv1
@onready var button_lv_2 = $ButtonLv2
@onready var sprite_2 = $ButtonLv2/Sprite2
@onready var color_rect_2 = $ButtonLv2/ColorRect2
@onready var button_lv_3 = $ButtonLv3
@onready var sprite_3 = $ButtonLv3/Sprite3
@onready var color_rect_3 = $ButtonLv3/ColorRect3

func _physics_process(delta):
	zoom_process()
	if zoom_done == true:
		play_transition()
		await get_tree().create_timer(0.5).timeout
		zoom_done = false
	unlocker()

func zoom_process():
	if cam.zoom < ZOOM_LIMIT && scene_change == true:
		cam.position = zoom_position
		cam.zoom += ZOOM_SPEED
		if cam.zoom >= ZOOM_LIMIT:
			zoom_done = true

func play_transition():
	TransitionAnim.transistion()
	await TransitionAnim.on_transition_finished

func unlocker():
	if unlocked >= 1:
		color_rect_2.visible = false
		sprite_2.visible = false
	elif unlocked >= 2:
		color_rect_3.visible = false
		sprite_3.visible = false

func _on_button_lv_1_pressed():
	scene_change = true
	zoom_position = Vector2(323 , 276)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://World2/test_level.tscn")

func _on_button_lv_2_pressed():
	scene_change = true
	zoom_position = Vector2(323 , 177)
	## scene_load = " "

func _on_button_lv_3_pressed():
	scene_change = true
	zoom_position = Vector2(322 , 78)
	## scene_load = " "
