extends Control

func _on_back_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://TitleScreen/menu2.tscn")
