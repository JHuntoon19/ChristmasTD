extends Node
#Candy can scen
var CCScene : PackedScene = preload("res://Projectiles/candy_cane.tscn")
#Carrot scene
var CaScene : PackedScene = preload("res://Projectiles/carrot.tscn")
@onready var projectiles : Node2D = $Projectiles
@onready var ui = $UI
var money : int = 0
func _ready():
#	Connects all towers to level
	for elf in get_tree().get_nodes_in_group("Elf"):
		elf.connect("Elfattack", elfTowerAttack)
	for snowman in get_tree().get_nodes_in_group("Snowman"):
		snowman.connect("snowmanAttack", snowmanAttack)
	for cow in get_tree().get_nodes_in_group("Cow"):
		cow.connect("dead", deadCow)
#When elf wants to attack
func elfTowerAttack(tower : Area2D, enemy : Area2D) -> void:
#	Instantiates a candy cane and gives it the correct position and direction
	var CC : Area2D = CCScene.instantiate()
#	We need the position of the pathfollow2D node not just the area
	var enemyParent : PathFollow2D = enemy.get_parent()
	var direction : Vector2 = Vector2 (enemyParent.position - tower.position).normalized()
	CC.position = tower.position
	CC.direction = direction
	CC.rotation = direction.angle()
	projectiles.call_deferred("add_child",CC)

#When the snowman wants to attack
func snowmanAttack(tower : Area2D, projNum : int) -> void:
#	Ang splits up a circle into even parts
	var ang : float = 2 * PI / (projNum)
#	Repeats for the given amount of times
	for n : int in range(projNum):
#		Creates a carrot with the correct position and direction
		var Ca : Area2D = CaScene.instantiate()
#		add parts of the circle each time to end with carrots evenly spread
		var rotationAngle : float = ang * n
#		Trig to find the x and y values of the carrot's direction
		var direction : Vector2 = Vector2 (cos(rotationAngle), sin(rotationAngle))
		Ca.rotation = rotationAngle
		Ca.direction = direction
		Ca.position = tower.position
		projectiles.call_deferred("add_child", Ca)
func deadCow(enemy : PathFollow2D):
	enemy.queue_free()
	money += 15
	ui.updateMoneyText(str(money))
	print(money)
