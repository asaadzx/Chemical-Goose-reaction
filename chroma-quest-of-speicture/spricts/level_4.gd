extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("level 4 pressd")


func _on_level_3_pressed() -> void:
	print("level 3 pressd")


func _on_level_2_pressed() -> void:
	print("level 2 pressd")


func _on_level_1_pressed() -> void:
	print("level 1 pressd")
