extends "res://Scripts/projectile.gd"
func _ready() -> void:
	speed = 20
#Every frame moves the projectile in the correct direction
func _process(delta) -> void:
	position += direction * speed * delta
	#Rotates pickaxe so it can hit enemies more than once
	rotation += speed * delta / 2
