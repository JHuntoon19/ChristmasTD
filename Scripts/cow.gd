extends PathFollow2D
var speed : float = 0.05
var health : int = 10
func _process(delta):
	progress_ratio += speed * delta
	if(health <= 0):
		queue_free()


func _on_cow_area_entered(area):
	health -= 1
	area.queue_free()
