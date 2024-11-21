extends Area2D
var attack : bool = false
var
func _process(delta):
	if(attack):
		

func _on_range_area_entered(area):
	attack = true
	

func _on_range_area_exited(area):
	attack = false
