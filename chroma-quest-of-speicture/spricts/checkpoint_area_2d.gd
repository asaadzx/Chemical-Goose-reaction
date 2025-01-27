extends Area2D

var Checkpoint_id = 0
var Is_Active = false
var active_sound = null


func _ready():
	pass



func _on_body_entered(_body: Node2D) -> void:
	print("save it")
	print("go to level 2")
