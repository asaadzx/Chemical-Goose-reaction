extends Control
@onready var panel_container: PanelContainer = $PanelContainer

func _on_button_resume_pressed() -> void:
	get_tree().paused = false
	panel_container.hide()


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scens/main menu.tscn")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		print("paused")
		panel_container.show()
	
	if Input.is_action_just_released("pause"):
		print("unpause")
		panel_container.hide()
	
