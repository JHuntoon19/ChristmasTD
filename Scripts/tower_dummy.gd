extends Node2D
#This is a bass class that the dummy towers will be based off of
class_name TowerDummy
#Use setup for the specific tower variables
signal placeTower(position : Vector2, towerName : String)
@export var type: Global.TowerType
var placeable : bool = true
var onPlatform : bool = false
var onPath : bool = false
var inTower : bool = false
var areas : Array[Area2D] = []
var circColor : Color = Color("22ab80")
var unColor : Color = Color("ff443b")
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
	#Checks that the tower is not overlapping any others and on a built platform and that the player has enough money
	onPlatform = false
	inTower = false
	onPath = false
	checkIfPlaceable()
	attemptPlace()
	#Removes dummy if User backs out
	if(Input.is_action_just_pressed("back")):
		queue_free()
#Function to see if player wants to place the tower
func attemptPlace():
	if(placeable):
		#If the tower can be places makes the range circle gray
		$RangeCircle.self_modulate = circColor
		if(Input.is_action_just_pressed("click")):
			#User wants to place tower so this emits to the level the position and the tower to place
			placeTower.emit(position, type)
			#Subtracts the cost and removes teh dummy
			Global.money -= cost
			queue_free()
	else:
		#Makes range circle red when the tower cannot be placed
		$RangeCircle.self_modulate = unColor
#Function determines if the tower is valid to be placed
func checkIfPlaceable():
	for area :Area2D in areas:
		#checks if any areas it is colliding with are a platform
		if area.get_collision_layer_value(11):
			onPlatform = true
		#Checks if any areas it is colliding with are a tower
		if area.get_collision_layer_value(1):
			inTower = true
		if area.get_collision_layer_value(5):
			onPath = true
	#Determines if a tower is in a valid position with enough moneey
	placeable = onPlatform and Global.money >= cost and not inTower and not onPath
#Use this when creating tower specific dummys
func setup() -> void:
	#Change the tower name and the cost
	var towerClass : Tower = tower.instantiate()
	$range/CollisionShape2D.shape.radius = towerClass.towerRange
	match towerClass.type:
		Global.TowerType.ELF:
			cost = Global.elfCost
		Global.TowerType.SNOW:
			cost = Global.snowCost
		Global.TowerType.GNOME:
			cost = Global.gnomeCost
		Global.TowerType.SHIELD:
			#Only thing different about the shield is that the size changes
			cost = Global.shieldCost
			scale = Vector2(towerClass.size, towerClass.size)
	towerClass.queue_free()

#Ensures that the dummy is not overlapping anything so that it can be placed
func _on_hitbox_area_entered(area):
	areas.append(area)
	
func _on_hitbox_area_exited(area):
	areas.erase(area)
func upgrade():
	pass
