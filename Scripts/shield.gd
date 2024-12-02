extends Tower
#Extends tower for easy placement
class_name Shield
#How many hits the shield can take
var health : int = 10
var size : float = 1
func _init() -> void:
	upgrade()
func _ready() -> void:
	setup()
func _process(delta: float) -> void:
	#Once shield is out of health it deletes itself
	if(health <= 0):
		queue_free()
#When it is hit it decreases it's health
func _on_area_entered(area: Area2D) -> void:
	health -= 1
func upgrade() -> void:
	#Gives the dummy a size to draw placement cirlce color
	towerRange = 10
	for level : int in range(Global.shieldLevel + 1):
		#Upgrade change the size and the health amount
		match level:
			0:
				health = 10
				size = 1
			1:
				health = 20
				size = 1.3
			2:
				health = 40
				size = 1.5
			3:
				health = 60
				size = 2
func setup()-> void:
	scale = Vector2(size,size)
