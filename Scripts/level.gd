extends Node
class_name Level
#Candy can scen
var CCScene : PackedScene = preload("res://Projectiles/candy_cane.tscn")
#Carrot scene
var CaScene : PackedScene = preload("res://Projectiles/carrot.tscn")
#Snowball scene
var snowBallScene : PackedScene = preload("res://Projectiles/snowball.tscn")
@onready var sled: Sled = $End/Sled
@onready var projectiles : Node2D = $Projectiles
@onready var ui = $UI
var money : int = 0
var monsterCount : int = 5
@onready var monster_path: Path2D = $Enemies/MonsterPath
@onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	#Sets basic default global values
	Global.money += 45
	Global.heartUpdate.emit(Global.santaHeart)
	startLevel()
func startLevel() -> void:
	$UFO/AnimationPlayer.play("StartLevel")
func spawnEnemies():
	#Repeats for the monster count
	for monster : int in monsterCount:
		#Chooses a random number 1 or 2 to determine the type of monster
		var monsterType = randi_range(1,2)
		var monsterObj : Enemy
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
#When enemy reaches beging of path with a present it addes it to the monster sled
func begined(enemy : Enemy) -> void:
	if(enemy.presentHolder):
		Global.monsterPresentNum += 1
		var presentI : Sprite2D = preload("res://End/present_i.tscn").instantiate()
		$End/MSled.get_child(Global.monsterPresentNum - 1).call_deferred("add_child", presentI)
		enemy.presentHolder = false
		enemy.get_child(-1).queue_free()
	#When an enemy reaches the end of the path
func ended(enemy : Enemy) -> void:
	#Checks that presents are left on the sled
	if(Global.presentNum > 0):
		#Deletes the present from the  PresentHolder Node on the sled
		sled.get_child(Global.presentNum).get_child(0).queue_free()
		#Creates a duplicate present to add to the enemy
		var presentI : Sprite2D = preload("res://End/present_i.tscn").instantiate()
		#Adds the duplicate present onto the enemy
		enemy.call_deferred("add_child", presentI)
		enemy.presentHolder = true
		#Substracts from the amount of presents left
		Global.presentNum -= 1
#When elf wants to attack
#The tower and enemy are their positions
func elfTowerAttack(tower : Vector2, enemy : Vector2, projSpeed : int) -> void:
#	Instantiates a candy cane and gives it the correct position directio and speed
	var CC : Projectile = CCScene.instantiate()
	var direction : Vector2 = Vector2 (enemy - tower).normalized()
	CC.position = tower
	CC.direction = direction
	CC.rotation = direction.angle()
	CC.speed *= projSpeed
	projectiles.call_deferred("add_child",CC)

#When the snowman wants to attack
func snowmanAttack(tower : Tower, projNum : int, projSpeed : int) -> void:
#	Ang splits up a circle into even parts
	var ang : float = 2 * PI / (projNum)
#	Repeats for the given amount of times
	for n : int in range(projNum):
#		Creates a carrot with the correct position and direction
		var Ca : Projectile = CaScene.instantiate()
#		add parts of the circle each time to end with carrots evenly spread
		var rotationAngle : float = ang * n
#		Trig to find the x and y values of the carrot's direction
		var direction : Vector2 = Vector2 (cos(rotationAngle), sin(rotationAngle))
		#Sets carrot on right path with right speed
		Ca.rotation = rotationAngle
		Ca.direction = direction
		Ca.position = tower.position
		Ca.speed *= projSpeed
		projectiles.call_deferred("add_child", Ca)
func gnomeAttack(position : Vector2, enemy : Vector2, rotateSpeed : float, size : float):
	#	Instantiates a pckaxe and gives it the correct position and direction
	var PA : PickAxe = preload("res://Projectiles/pickaxe.tscn").instantiate()
	var direction : Vector2 = Vector2 (enemy - position).normalized()
	PA.position = position
	PA.direction = direction
	PA.rotateSpeed = rotateSpeed
	PA.scale = Vector2(size,size)
	projectiles.call_deferred("add_child",PA)
#removes enemy and updates the money
func deadEnemy(enemy : Enemy, presentHolder : bool):
	#If the enemy is holding a present it has to drop it
	if(presentHolder):
		#Creates a new present to be dropped onto the path
		var present : Present = preload("res://End/present.tscn").instantiate()
		present.position = enemy.position
		$OpenPresents.call_deferred("add_child", present)
	#removes the enemy and adds money
	monsterCount -= 1
	enemy.queue_free()
	Global.money += 15
	if(monsterCount == 0):
		get_tree().change_scene_to_file("res://Levels/transition.tscn")

#Creates a dummy elf tower to follow the mouse
#Connects the appropiate signal
func _on_ui_elf_tower_clicked():
	var elfDummy : TowerDummy = preload("res://UI/elf_dummy.tscn").instantiate()
	call_deferred("add_child", elfDummy)
	elfDummy.connect("placeTower", placeTower)
#Places a new tower in place of a dummy
func placeTower(position : Vector2, type : int) -> void :
	#Creates a elf tower
	if(type == Global.TowerType.ELF):
		var elfTower : Tower = preload("res://Towers/elf_tower.tscn").instantiate()
		elfTower.position = position
		$Towers.call_deferred("add_child",elfTower)
		elfTower.connect("Elfattack",elfTowerAttack)
	#Creates a snowman tower
	elif(type == Global.TowerType.SNOW):
		var snowTower : Tower = preload("res://Towers/snowman_tower.tscn").instantiate()
		snowTower.position = position
		$Towers.call_deferred("add_child",snowTower)
		snowTower.connect("snowmanAttack",snowmanAttack)
	#Creates a gnome tower
	elif(type == Global.TowerType.GNOME):
		var gnomeTower : Tower = preload("res://Towers/gnome_tower.tscn").instantiate()
		gnomeTower.position = position
		$Towers.call_deferred("add_child",gnomeTower)
		gnomeTower.connect("gnomeAttack", gnomeAttack)
	#Creates the shield tower
	elif(type == Global.TowerType.SHIELD):
		var shieldTower : Shield = preload("res://Towers/shield.tscn").instantiate()
		shieldTower.position = position
		$Towers.call_deferred("add_child",shieldTower)
#Creates a dummy snowman to follow the mouse
#Connects appropiate signal
func _on_ui_snow_tower_clicked():
	var snowDummy : TowerDummy = preload("res://UI/snow_dummy.tscn").instantiate()
	call_deferred("add_child", snowDummy)
	snowDummy.connect("placeTower",placeTower)

func _on_ui_gnome_tower_clicked() -> void:
	var gnomeDummy : TowerDummy = preload("res://UI/gnome_dummy.tscn").instantiate()
	call_deferred("add_child",gnomeDummy)
	gnomeDummy.connect("placeTower",placeTower)

#Position of Santa and the Pos of the enemy
#Shoots a snowball at the enemy
func _on_santa_santa_attack(position: Vector2, enemy: Vector2) -> void:
	var snowball : Projectile = snowBallScene.instantiate()
	snowball.position = position
	snowball.direction = Vector2(enemy - position).normalized()
	$Projectiles.call_deferred("add_child",snowball)

#Creates a shiled dummy to follow mouse
func _on_ui_shield_tower_clicked() -> void:
	var shieldDummy : TowerDummy = preload("res://UI/shield_dummy.tscn").instantiate()
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
	var santa : Santa = $Santa
	santa.presentHolder = false
	santa.get_child(-1).queue_free()
