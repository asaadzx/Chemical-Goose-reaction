extends Control
@onready var panel_container: PanelContainer = $PanelContainer


func resume():
	get_tree().paused = false
	panel_container.hide()

func pause():
	get_tree().paused = true
	panel_container.show()


func test_pause():
	
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
		print("pause")
	
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
		print("resume")


func _on_button_resume_pressed() -> void:
	pass # Replace with function body.


func _on_button_main_menu_pressed() -> void:
	pass # Replace with function body.


func _on_check_button_pressed() -> void:
	pass # Replace with function body.

func _process(delta):
	test_pause()
