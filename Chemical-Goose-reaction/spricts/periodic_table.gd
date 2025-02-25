extends Sprite2D

@onready var camera_2d: Camera2D = $Camera2D

var original_zoom = Vector2(1, 1) # The original camera zoom (default).
var zoom_scale = Vector2(0.5, 0.5) # The zoom scale (smaller values zoom in).
var is_zoomed = false # Flag to check if zoomed.
var zoom_duration = 0.3 # Duration of the animation.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Exit_wiki"):
		get_tree().change_scene_to_file("res://scens/level 1 .tscn")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		_on_zoom_event(event)

func _on_zoom_event(_event: InputEventMouseButton):
	if is_zoomed:
		# Reset to original zoom, camera position, and sprite position.
		camera_2d.zoom = original_zoom
		camera_2d.position = Vector2(0, 0)
		position = Vector2(0, 0)
		is_zoomed = false
	else:
		# Get the mouse position in the viewport's global space.
		var _mouse_position = get_global_mouse_position()
		
		# Calculate the offset needed to zoom in on the mouse position.
		var zoom_factor = zoom_scale - original_zoom
		var offset = (_mouse_position - camera_2d.position) * zoom_factor
		
		# Apply zoom and adjust camera and sprite positions.
		camera_2d.zoom = zoom_scale
		camera_2d.position -= offset
		position -= offset
		is_zoomed = true
		
		# Debugging output.
		#print("Mouse Position (Global): ", mouse_position)
		#print("Offset: ", offset)
		#print("New Camera Position: ", camera_2d.position)
		#print("New Sprite Position: ", position)
