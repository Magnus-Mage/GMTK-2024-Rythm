extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://TitleScreen/level_select.tscn")

func _on_how_to_pressed():
	get_tree().change_scene_to_file("res://TitleScreen/how_to.tscn")
