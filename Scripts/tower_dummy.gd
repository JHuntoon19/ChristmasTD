extends Node2D
#This is a bass class that the dummy towers will be based off of
class_name TowerDummy
#Use setup for the specific tower variables
signal placeTower(position : Vector2, towerName : String)
@export var towerName : String
var placeable : bool = true
var areas : Array[int] = []
var circColor : Color = Color("6a6a6a84")
var unColor : Color = Color("d83842a3")
@export var cost : int = 0
@export var tower : PackedScene
#Makes the range circle the correct size
func _ready():
	upgrade()
	setup()
	$RangeCircle.scale = Vector2($range/CollisionShape2D.shape.radius / 731, $range/CollisionShape2D.shape.radius / 739) * 2
func _process(delta):
	#Makes dummy follow mouse
	position = get_global_mouse_position()
	#Checks that the tower is not overlapping any others and that the player has enough money
	placeable = areas.is_empty() and Global.money >= cost
	if(placeable):
		#If the tower can be places makes the range circle gray
		$RangeCircle.self_modulate = circColor
		if(Input.is_action_just_pressed("click")):
			#User wants to place tower so this emits to the level the position and the tower to place
			placeTower.emit(position, towerName)
			#Subtracts the cost and removes teh dummy
			Global.money -= cost
			queue_free()
	else:
		#Makes range circle red when the tower cannot be placed
		$RangeCircle.self_modulate = unColor
	#Removes dummy if User backs out
	if(Input.is_action_just_pressed("back")):
		queue_free()
#Use this when creating tower specific dummys
func setup() -> void:
	#Change the tower name and the cost
	var towerRange = tower.instantiate()
	add_child(towerRange)
	$range/CollisionShape2D.shape.radius = towerRange.range
	towerRange.queue_free()

#Ensures that the dummy is not overlapping anything so that it can be placed
func _on_hitbox_area_entered(area):
	areas.append(1)
func _on_hitbox_area_exited(area):
	areas.remove_at(areas.size() - 1)
func upgrade():
	pass
