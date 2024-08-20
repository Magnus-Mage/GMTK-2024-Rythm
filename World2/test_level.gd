extends Node2D

func _physics_process(delta):	
	if Input.is_action_pressed("esc"):
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
