extends Node2D
class_name ChristamsResource
@export var value : int

func _ready() -> void:
	print("placed")

#Santa collects this resource
func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.resources += value
	queue_free()
