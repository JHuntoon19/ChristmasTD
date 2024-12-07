extends Area2D
class_name Tower
@onready var attack_delay: Timer = %AttackDelay
@onready var attack_sound: AudioStreamPlayer2D = $AttackSound

#Enems is an array that holds all the enemies within range
var enems : Array[Area2D] = []
var canAttack : bool = true
#Multiplies the speed by this number to increase when tower is leveled up
var projSpeed : float = 1
#Holds the range of the tower
var towerRange : int
#Shows how fast the tower will attack
#Automatically changes the timer when updated
var attackSpeed : float
#type of tower set in inspectore of each tower
@export var type: Global.TowerType
#Sets up variable values on instantiation
func _init() -> void:
	upgrade()
#Applies variable values to nodes
func _ready() -> void:
	setup()
func _process(delta) -> void:
#	If enemies are in range and the timer has gone off it calls an attack method
	if(!enems.is_empty()):
		if(canAttack):
			canAttack = false
			attack_delay.start()
			attack_sound.play()
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
#Applies custom time and range on ready
func setup() -> void:
	attack_delay.wait_time = attackSpeed
	$Range/CollisionShape2D.shape.radius = towerRange
	
