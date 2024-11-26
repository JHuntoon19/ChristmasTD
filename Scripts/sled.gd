extends Sprite2D
class_name Sled
signal presentAdded()
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent().presentHolder):
		Global.presentNum +=  1
		presentAdded.emit()
