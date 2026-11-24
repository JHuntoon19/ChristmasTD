extends Tower
#Extends tower for easy placement
class_name Shield
#How many hits the shield can take
var health : int = 2
var size : float = 1
var numShields : int
@onready var shield_nodes: Node2D = $ShieldNodes
func _init() -> void:
	upgrade()
func _ready() -> void:
	setup()
	for segment : ShieldSeg in shield_nodes.get_children():
		segment.health = health
func _process(delta: float) -> void:
	numShields = shield_nodes.get_child_count()
	#Once shield is out of shield segments it deletes itself
	if(numShields <= 0):
		queue_free()
#When it is hit it decreases it's health
func _on_area_entered(area: Area2D) -> void:
	health -= 1
func upgrade() -> void:
	#Gives the dummy a size to draw placement cirlce color
	towerRange = 9
	for level : int in range(Global.shieldLevel):
		#Upgrade change the size and the health amount
		match level:
			0:
				health = 2
				size = 1
			1:
				health = 4
				size = 1.3
			2:
				health = 6
				size = 1.5
			3:
				health = 60
				size = 2
func setup()-> void:
	scale = Vector2(size,size)
