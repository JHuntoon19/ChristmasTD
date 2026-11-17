extends Node2D


func _process(delta: float) -> void:
	#Points the arrow at the mouse
	look_at(get_global_mouse_position())
