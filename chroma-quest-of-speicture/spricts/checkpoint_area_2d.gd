extends Area2D

var Checkpoint_id = 0
var Is_Active = false
var active_sound = null


func _ready():
	add_to_group("checkpoint")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
