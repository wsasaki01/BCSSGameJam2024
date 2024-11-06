class_name InputComponent
extends Node

var input_horizontal: float = 0.0

func _process(_delta: float) -> void:
	input_horizontal = Input.get_axis("left", "right")
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump")
