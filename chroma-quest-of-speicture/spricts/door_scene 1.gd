extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_body_entered(_body: Node2D) -> void:
	if _body is Player:
		call_deferred("_remove_door")

func _remove_door() -> void:
	queue_free()
	var door = load("res://scens/level 1 .tscn")
	get_tree().change_scene_to_packed(door)
