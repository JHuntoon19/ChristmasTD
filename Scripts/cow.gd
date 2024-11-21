extends PathFollow2D
var speed : float = 0.05
var health : int = 10
signal dead(enemy : PathFollow2D)
func _process(delta):
	progress_ratio += speed * delta
	if(health <= 0):
		dead.emit(self)


func _on_cow_area_entered(area):
	health -= 1
