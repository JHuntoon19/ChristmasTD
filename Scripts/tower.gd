extends Area2D
class_name Tower
@onready var attack_delay : Timer = $AttackDelay
#Enems is an array that holds all the enemies within range
var enems : Array[Area2D] = []
var canAttack : bool = true
func _process(delta) -> void:
#	If enemies are in range and the timer has gone off it calls an attack method
	if(!enems.is_empty()):
		if(canAttack):
			canAttack = false
			attack_delay.start()
			attack()
#			Will be changed by the towers themselves
func attack() -> void:
	print("attack")
#Adds and removes enemies from the enems array
func _on_range_area_entered(area : Area2D) -> void:
	enems.append(area)
func _on_range_area_exited(area : Area2D) -> void:
	enems.erase(area)
func _on_attack_delay_timeout() -> void:
	canAttack = true
