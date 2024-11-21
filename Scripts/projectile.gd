extends Area2D
var speed : int = 50
var direction : Vector2
#Every frame moves the projectile in the correct direction
func _process(delta) -> void:
	position += direction * speed * delta


func _on_area_entered(area):
	queue_free()
