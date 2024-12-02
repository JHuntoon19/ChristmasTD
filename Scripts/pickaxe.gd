extends Projectile
class_name PickAxe
#Every frame moves the projectile in the correct direction
var rotateSpeed : float = 1.0
func _process(delta) -> void:
	position += direction * speed * delta
	#Rotates pickaxe so it can hit enemies more than once
	rotation += (speed * delta / 2) * rotateSpeed
