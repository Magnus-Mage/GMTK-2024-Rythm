extends Control


func _on_start_button_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://TitleScreen/level_select.tscn")

func _on_how_to_button_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://TitleScreen/how_to.tscn")
