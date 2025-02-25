extends Button



func _on_pressed() -> void:
	get_tree().change_scene("res://scens/periodic_table.tscn")
	print("periodic table clicked")

func Periodic_table() -> void:
	get_tree().change_scene_to_file("res://cracters/periodic_table.tscn")
	print("periodic table clicked")



func _on_area_2d_body_entered(_body: Node2D) -> void:
	if _body is Player:
		call_deferred("Periodic_table")
		print("periodic table clicked")
