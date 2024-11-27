extends Area2D
class_name Tower
@export var attack_delay : Timer
#Enems is an array that holds all the enemies within range
var enems : Array[Area2D] = []
var canAttack : bool = true
#Multiplies the speed by this number to increase when tower is leveled up
var projSpeed : int = 1
#Holds the range of the tower
var range : int
#Shows how fast the tower will attack
#Automatically changes the timer when updated
@export var attackSpeed : float = 0.5:
	get:
		return attackSpeed
	set(value):
		attackSpeed = value
		attack_delay.wait_time = attackSpeed

func _ready() -> void:
	range = $Range/CollisionShape2D.shape.radius
	upgrade()
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
func upgrade() -> void:
	pass
