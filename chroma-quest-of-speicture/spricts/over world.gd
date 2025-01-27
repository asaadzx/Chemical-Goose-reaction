extends Area2D

var main_crecter: CharacterBody2D
var checkpoint: Area2D
 
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	pass

func _on_body_entered(_body: Node2D) -> void:
	if _body is Player:
		print("u killed")
