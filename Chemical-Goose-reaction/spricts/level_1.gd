extends Button



func _on_pressed() -> void:
	print("level1 pressed")
	get_tree().change_scene_to_file("res://scens/level 1 .tscn")
