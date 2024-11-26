extends StaticBody2D
#Shield is not a base tower because it has no need to track enemies and attack
#How many hits the shield can take
var health : int = 10
func _process(delta: float) -> void:
	#Once shield is out of health it deletes itself
	if(health <= 0):
		queue_free()
#When it is hit it decreases it's health
func _on_detect_area_entered(area: Area2D) -> void:
	health -= 1
