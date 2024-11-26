extends Area2D
#Keeps is so that only the area that touches it first will have the present added
var touched : bool = false
#When it touches another area it checks that it is not already holding a present
func _on_area_entered(area: Area2D) -> void:
	if(area.get_parent().presentHolder == false and touched == false):
		touched = true
		#Adds the present to be the last child on the area's paren
		area.get_parent().presentHolder = true
		var present = preload("res://End/present_i.tscn").instantiate()
		#Deletes itself after it is added
		area.get_parent().call_deferred("add_child", present)
		queue_free()
