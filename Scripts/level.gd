extends Node
#Candy can scen
var CCScene : PackedScene = preload("res://Projectiles/candy_cane.tscn")
#Carrot scene
var CaScene : PackedScene = preload("res://Projectiles/carrot.tscn")
#Snowball scene
var snowBallScene : PackedScene = preload("res://Projectiles/snowball.tscn")
@onready var sled: Sprite2D = $End/Sled
@onready var projectiles : Node2D = $Projectiles
@onready var ui = $UI
var money : int = 0
var monsterCount : int = 5
@onready var monster_path: Path2D = $Enemies/MonsterPath
@onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	#Sets basic default global values
	Global.money += 45
	Global.santaHeart = 4
	startLevel()
func startLevel() -> void:
	$UFO/AnimationPlayer.play("StartLevel")
func spawnEnemies():
	#Repeats for the monster count
	for monster in monsterCount:
		#Chooses a random number 1 or 2 to determine the type of monster
		var monsterType = randi_range(1,2)
		var monsterObj : PathFollow2D
		#If the monsterType is 1 this creates a basic monster
		if(monsterType == 1):
			monsterObj = preload("res://Enemy/monster.tscn").instantiate()
			monster_path.add_child(monsterObj)
		#If monsterType is a 2 it creates a fast monster
		elif(monsterType == 2):
			monsterObj = preload("res://Enemy/monster_2.tscn").instantiate()
			monster_path.add_child(monsterObj)
		#Connects the three signals that all enemies have
		monsterObj.connect("begined", begined)
		monsterObj.connect("ended", ended)
		monsterObj.connect("dead", deadEnemy)
		#Pauses loop so the monster spawn 1 second apart
		spawn_timer.start()
		await spawn_timer.timeout
func begined(enemy : PathFollow2D) -> void:
	if(enemy.presentHolder):
		Global.monsterPresentNum += 1
		var presentI : Sprite2D = preload("res://End/present_i.tscn").instantiate()
		$End/MSled.get_child(Global.monsterPresentNum - 1).call_deferred("add_child", presentI)
		enemy.presentHolder = false
		enemy.get_child(-1).queue_free()
	#When an enemy reaches the end of the path
func ended(enemy : PathFollow2D) -> void:
	#Checks that presents are left on the sled
	if(Global.presentNum > 0):
		#Gets the present from the  PresentHolder Node on the sled
		var present : Sprite2D = sled.get_child(Global.presentNum).get_child(0)
		#Creates a duplicate present to add to the enemy
		var copiedPresent : Sprite2D = present.duplicate()
		#Deletes the present from the sled
		present.queue_free()
		#Adds the duplicate present onto the enemy
		enemy.call_deferred("add_child", copiedPresent)
		enemy.presentHolder = true
		#Substracts from the amount of presents left
		Global.presentNum -= 1
#When elf wants to attack
#The tower and enemy are their positions
func elfTowerAttack(tower : Vector2, enemy : Vector2) -> void:
#	Instantiates a candy cane and gives it the correct position and direction
	var CC : Area2D = CCScene.instantiate()
	var direction : Vector2 = Vector2 (enemy - tower).normalized()
	CC.position = tower
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
func gnomeAttack(position : Vector2, enemy : Vector2):
	#	Instantiates a pckaxe and gives it the correct position and direction
	var PA : Area2D = preload("res://Projectiles/pickaxe.tscn").instantiate()
	var direction : Vector2 = Vector2 (enemy - position).normalized()
	PA.position = position
	PA.direction = direction
	projectiles.call_deferred("add_child",PA)
#removes enemy and updates the money
func deadEnemy(enemy : PathFollow2D, presentHolder : bool):
	#If the enemy is holding a present it has to drop it
	if(presentHolder):
		#Creates a new present to be dropped onto the path
		var present : Area2D = preload("res://End/present.tscn").instantiate()
		present.position = enemy.position
		$OpenPresents.call_deferred("add_child", present)
	#removes the enemy and adds money
	monsterCount -= 1
	enemy.queue_free()
	Global.money += 15
	if(monsterCount == 0):
		print(Global.santaHeart)
		get_tree().change_scene_to_file("res://Levels/transition.tscn")

#Creates a dummy elf tower to follow the mouse
#Connects the appropiate signal
func _on_ui_elf_tower_clicked():
	var elfDummy : Node2D = preload("res://UI/elf_dummy.tscn").instantiate()
	call_deferred("add_child", elfDummy)
	elfDummy.connect("placeTower", placeTower)
#Places a new tower in place of a dummy
func placeTower(position : Vector2, towerName : String) -> void :
	#Creates a elf tower
	if(towerName == "elf"):
		var elfTower : Area2D = preload("res://Towers/elf_tower.tscn").instantiate()
		elfTower.position = position
		$Towers.call_deferred("add_child",elfTower)
		elfTower.connect("Elfattack",elfTowerAttack)
	#Creates a snowman tower
	elif(towerName == "snow"):
		var snowTower : Area2D = preload("res://Towers/snowman_tower.tscn").instantiate()
		snowTower.position = position
		$Towers.call_deferred("add_child",snowTower)
		snowTower.connect("snowmanAttack",snowmanAttack)
	#Creates a gnome tower
	elif(towerName == "gnome"):
		var gnomeTower : Area2D = preload("res://Towers/gnome_tower.tscn").instantiate()
		gnomeTower.position = position
		$Towers.call_deferred("add_child",gnomeTower)
		gnomeTower.connect("gnomeAttack", gnomeAttack)
	#Creates the shield tower
	elif(towerName == "shield"):
		var shieldTower : StaticBody2D = preload("res://Towers/shield.tscn").instantiate()
		shieldTower.position = position
		$Towers.call_deferred("add_child",shieldTower)
#Creates a dummy snowman to follow the mouse
#Connects appropiate signal
func _on_ui_snow_tower_clicked():
	var snowDummy : Node2D = preload("res://UI/snow_dummy.tscn").instantiate()
	call_deferred("add_child", snowDummy)
	snowDummy.connect("placeTower",placeTower)

func _on_ui_gnome_tower_clicked() -> void:
	var gnomeDummy = preload("res://UI/gnome_dummy.tscn").instantiate()
	call_deferred("add_child",gnomeDummy)
	gnomeDummy.connect("placeTower",placeTower)


func _on_santa_santa_attack(position: Vector2, enemy: Vector2) -> void:
	var snowball = snowBallScene.instantiate()
	snowball.position = position
	snowball.direction = Vector2(enemy - position).normalized()
	$Projectiles.call_deferred("add_child",snowball)


func _on_ui_shield_tower_clicked() -> void:
	var shieldDummy = preload("res://UI/shield_dummy.tscn").instantiate()
	call_deferred("add_child", shieldDummy)
	shieldDummy.connect("placeTower", placeTower)


func _on_sled_present_added() -> void:
	#Stores the scene of the present image
	var presenti = preload("res://End/present_i.tscn").instantiate()
	#Depending on the amount of presents the sled has it adds it to the correct child
	#Keeps the presents in the right location
	sled.get_child(Global.presentNum).call_deferred("add_child", presenti)
	#Removes the present from santa
	#The present should be the last added node to santa
	$Santa.presentHolder = false
	$Santa.get_child(-1).queue_free()
